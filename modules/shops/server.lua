---@diagnostic disable: duplicate-set-field
local shopObj = {}
ShopClass = {}
ShopClass.__index = ShopClass

function ShopClass:new(id, position, inventory, model, entityType)
    local obj = {
        id = id,
        position = position,
        inventory = inventory,
        model = model,
        entityType = entityType,
    }
    setmetatable(obj, self)
    shopObj[id] = obj
    return obj
end

RegisterNetEvent("MrNewbsSpookySeason:Server:Shop:PurchaseItem", function(id, itemName, amount)
    local src = source
    local obj = shopObj[id]
    if not obj then return Bridge.Notify.SendNotify(src, locale("Shop.InvalidShop"), "error", 5000) end
    if amount <= 0 then return Bridge.Notify.SendNotify(src, locale("Shop.InvalidAmount"), "error", 5000) end
    if not obj then return end
    if not obj.inventory[itemName] then return Bridge.Notify.SendNotify(src, locale("Shop.ItemNotForSale"), "error", 5000) end
    local eventTokenCount = Bridge.Inventory.GetItemCount(src, "event_token")
    local price = obj.inventory[itemName] * amount
    if price > eventTokenCount then return Bridge.Notify.SendNotify(src, locale("Shop.NotEnoughTokens"), "error", 5000) end
    Bridge.Inventory.RemoveItem(src, "event_token", price)
    Bridge.Inventory.AddItem(src, itemName, amount, nil, { description = locale("Items.EventTokenDescription") })
end)

function BuildShopObjects()
    for k, shopData in pairs(Config.Shops) do
        ShopClass:new(k, shopData.position, shopData.inventory, shopData.model, shopData.entityType)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    BuildShopObjects()
    SharedData = SharedData or {}
    SharedData.Shops = shopObj
end)