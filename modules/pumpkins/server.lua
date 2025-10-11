---@diagnostic disable: duplicate-set-field
local pumpkinObj = {}
PumpkinClass = {}
PumpkinClass.__index = PumpkinClass

function PumpkinClass:new(id, position, lootType, model)
    local obj = {
        id = id,
        position = position,
        model = model or `prop_veg_crop_03_pump`,
        lootTable = lootType,
        claimed = {},
    }
    setmetatable(obj, self)
    pumpkinObj[id] = obj
    return obj
end

function PumpkinClass:getLootTable()
    return Config.LootTypes[self.lootTable]
end

function PumpkinClass:verifyEligible(src)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local jackOLanternCoords = vector3(self.position.x, self.position.y, self.position.z)
    local distance = #(playerCoords - jackOLanternCoords)
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier(src)
    if distance < 5 and not self.claimed[plyridentifier] then
        self.claimed[plyridentifier] = true
        self:addItemsForPlayer(src)
        return true
    end
    return false
end

function PumpkinClass:addItemsForPlayer(src)
    local lootTable = self:getLootTable()
    local randomIndex = math.random(1, #lootTable)
    local selectedItem = lootTable[randomIndex]
    if selectedItem.rewardType == "cash" then
        Bridge.Framework.AddAccountBalance(src, "cash", selectedItem.count)
    elseif selectedItem.rewardType == "item" then
        Bridge.Inventory.AddItem(src, selectedItem.name, selectedItem.count or 1, nil, selectedItem.metadata or {})
    end
    Bridge.Inventory.AddItem(src, "event_token", math.random(1, 3), nil, { description = locale("Items.EventTokenDescription") })
end

RegisterNetEvent("MrNewbsSpookySeason:Server:JackOLantern:ClaimLoot", function(id)
    local src = source
    local obj = pumpkinObj[id]
    if not obj then return print(("[DEBUG] No loot table found with id '%s'."):format(tostring(id))) end
    if not obj:verifyEligible(src) then return end
end)

RegisterNetEvent("MrNewbsSpookySeason:Server:JackOLantern:FailedGrab", function(id)
    local src = source
    local obj = pumpkinObj[id]
    if not obj then return print(("[DEBUG] No loot table found with id '%s'."):format(tostring(id))) end
    local identifier = Bridge.Framework.GetPlayerIdentifier(src)
    if obj.claimed[identifier] then return end
    obj.claimed[identifier] = true
end)

function BuildPumpkinObjects()
    for _, data in ipairs(Config.Pumpkins) do
        local id = Bridge.Ids.Random(pumpkinObj, 10)
        PumpkinClass:new(id, data.position, data.lootTable, data.model)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    BuildPumpkinObjects()
    SharedData = SharedData or {}
    SharedData.Pumpkins = pumpkinObj
end)