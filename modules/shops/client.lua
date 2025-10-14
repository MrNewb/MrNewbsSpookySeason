---@diagnostic disable: duplicate-set-field
local shopObj = {}
ShopClass = {}
ShopClass.__index = ShopClass

function ShopClass:new(id, position, model, entityType, inventory)
    local obj = {
        id = id,
        position = vector4(position.x, position.y, position.z, position.w),
        model = model,
        entityType = entityType,
        inventory = inventory,
    }
    setmetatable(obj, self)
    shopObj[id] = obj
    obj:register()
    return obj
end

function ShopClass:destroy()
    Bridge.Entity.Destroy(self.id)
    if self.blip then Bridge.Utility.RemoveBlip(self.blip) end
    shopObj[self.id] = nil
end

local function shopAmountInput(id, itemName, itemPrice, label)
    local eventTokenCount = Bridge.Inventory.GetItemCount("event_token")
    if eventTokenCount <= 0 then return Bridge.Notify.SendNotify(locale("Shop.NotEnoughTokens"), "error", 5000) end
    local obj = shopObj[id]
    if not obj then return print(("[DEBUG] No shop object found with id '%s'."):format(tostring(id))) end
    if not obj.inventory then return print(("[DEBUG] No inventory found for shop with id '%s'."):format(tostring(id))) end
    if not obj.inventory[itemName] then return print(("[DEBUG] No item named '%s' found in shop with id '%s'."):format(tostring(itemName), tostring(id))) end
    local price = obj.inventory[itemName]
    if eventTokenCount < price then return Bridge.Notify.SendNotify(locale("Shop.NotEnoughTokens"), "error", 5000) end
    local maxAffordable = math.floor(eventTokenCount / price)
    local input = Bridge.Input.Open(label, {
        { type = 'slider', label = locale("Shop.InputPurchaseAmount"), min = 0, max = maxAffordable, step = 1 },
    }, false)
    if not input or not input[1] then return end
    if tonumber(input[1]) <= 0 then return Bridge.Notify.SendNotify(locale("Shop.InvalidAmount"), "error", 5000) end
    TriggerServerEvent("MrNewbsSpookySeason:Server:Shop:PurchaseItem", id, itemName, tonumber(input[1]))
end

local function shopBuyMenu(id)
    local obj = shopObj[id]
    if not obj then return print(("[DEBUG] No shop object found with id '%s'."):format(tostring(id))) end
    if not obj.inventory then return print(("[DEBUG] No inventory found for shop with id '%s'."):format(tostring(id))) end
    local shopMenu = {
        {
            title = locale("Shop.BuyTitle"),
            description = locale("Shop.BuyDescription"),
            icon = locale("Shop.ShopIcon"),
        },
    }
    for k, v in pairs(obj.inventory) do
        local itemInfo = Bridge.Inventory.GetItemInfo(k)
        table.insert(shopMenu, {
            title = locale("Shop.PurchaseTitle", itemInfo.label, v),
            icon = itemInfo.image or "fa-solid fa-box",
            onSelect = function()
                shopAmountInput(id, k, v, itemInfo.label)
            end,
        })
    end
    local menuID = Bridge.Ids.Random(shopObj, 10)
    Wait(500)
    Bridge.Menu.Open({ id = menuID, title = locale("Shop.ShopSubMenuDescription"), options = shopMenu }, false)
end

local function shopMainMenus(id)
    -- I hate how gross menus make everything look
    local shopMenu = {
        {
            title = locale("Shop.ShopTitle"),
            description = locale("Shop.ShopDescription"),
            icon = locale("Shop.ShopIcon"),
        },
        {
            title = locale("Shop.BuyItems"),
            description = locale("Shop.BuyItemsDescription"),
            icon = locale("Shop.BuyItemsIcon"),
            onSelect = function()
                shopBuyMenu(id)
            end,
        },
    }
    local menuID = Bridge.Ids.Random(shopObj, 10)
    Wait(500)
    Bridge.Menu.Open({ id = menuID, title = locale("Shop.Title"), options = shopMenu }, false)
end

function ShopClass:register()
    self.blip = Bridge.Utility.CreateBlip(vector3(self.position.x, self.position.y, self.position.z), 781, 2, 0.8, locale("Shop.BlipLabel"), true, 4)
    Bridge.Entity.Create({
        id = self.id,
        entityType = self.entityType,
        model = self.model,
        coords = self.position,
        heading = self.position.w,
        spawnDistance = 100,
        OnSpawn = function(entityData)
            Bridge.Particle.CreateOnEntity("core", "ent_amb_snow_mist_base", entityData.spawned, vector3(0.0, 0.0, -1.0), vector3(0.0, 0.0, 0.0), 3.5, vector3(0, 0, 0), true, false)
            SetEntityInvincible(entityData.spawned, true)
            FreezeEntityPosition(entityData.spawned, true)
            Bridge.Target.AddLocalEntity(entityData.spawned, {
                {
                    name     = 'Spooky Shop ' .. entityData.id,
                    label    = locale("Target.ShopLabel"),
                    icon     = locale("Target.ShopIcon"),
                    color    = locale("Target.ShopColor"),
                    distance = 5,
                    onSelect = function()
                        shopMainMenus(self.id)
                    end
                },
            })
            self.entityID = entityData.spawned
            Bridge.Weather.ToggleSync(false)
            SetWeatherTypeNowPersist("HALLOWEEN")
            SetWeatherTypePersist("HALLOWEEN")
            SetOverrideWeather("HALLOWEEN")
        end,
        OnRemove = function(entityData)
            ClearOverrideWeather()
            Bridge.Weather.ToggleSync(true)
            if not entityData.spawned then return end
            Bridge.Target.RemoveLocalEntity(entityData.spawned)
            self.entityID = nil
        end
    })
end

RegisterNetEvent("MrNewbsSpookySeason:Client:UsableItems:UseItem", function(id)
    local itemInfo = Bridge.Inventory.GetItemInfo(id)
    if not itemInfo then return end
    Bridge.ProgressBar.Open({
        duration = 5000,
        label = itemInfo.label,
        disable = { move = true, combat = true },
        anim = { dict = "anim@heists@humane_labs@emp@hack_door", clip = "hack_loop", flag = 1, },
        prop = {
            model = "xm3_prop_xm3_present_01a",
            bone = 28422,
            pos = vector3(0.00, -0.19, -0.16),
            rot = vector3(0.0, 0.0, 0.0),
        },
        canCancel = true,
    })
end)

AddEventHandler('MrNewbsSpookySeason:Client:InitialData', function(data)
    if source ~= 65535 then return end
    if not data.Shops then return end
    for k, shop in pairs(data.Shops) do
        ShopClass:new(k, shop.position, shop.model, shop.entityType, shop.inventory)
    end
end)

local function destroyAll()
    for k, v in pairs(shopObj) do
        v:destroy()
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    destroyAll()
end)

AddEventHandler("community_bridge:Client:OnPlayerUnload", function()
    destroyAll()
end)