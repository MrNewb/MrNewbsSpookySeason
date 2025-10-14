---@diagnostic disable: duplicate-set-field
local graveObj = {}
GraveClass = {}
GraveClass.__index = GraveClass

function GraveClass:new(id, position, lootType)
    local obj = {
        id = id,
        position = position,
        lootTable = lootType,
        claimed = {},
    }
    setmetatable(obj, self)
    graveObj[id] = obj
    return obj
end

function GraveClass:getLootTable()
    return Config.LootTypes[self.lootTable]
end

function GraveClass:verifyEligible(src)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local graveCoords = vector3(self.position.x, self.position.y, self.position.z)
    local distance = #(playerCoords - graveCoords)
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier(src)
    if distance < 5 and not self.claimed[plyridentifier] then
        self.claimed[plyridentifier] = true
        self:addItemsForPlayer(src)
        return true
    end
    return false
end

function GraveClass:addItemsForPlayer(src)
    local lootTable = self:getLootTable()
    local randomIndex = math.random(1, #lootTable)
    local selectedItem = lootTable[randomIndex]
    if selectedItem.rewardType == "cash" then
        Bridge.Framework.AddAccountBalance(src, "cash", selectedItem.count)
    elseif selectedItem.rewardType == "item" then
        Bridge.Inventory.AddItem(src, selectedItem.name, selectedItem.count or 1, nil, selectedItem.metadata or {})
    end
    Bridge.Inventory.AddItem(src, "event_token", math.random(1, 3), nil, { description = locale("Items.EventTokenDescription") })
    TriggerClientEvent("MrNewbsSpookySeason:Client:GraveRobbing:LootClaimed", src, self.id)
end

RegisterNetEvent("MrNewbsSpookySeason:Server:GraveRobbing:ClaimLoot", function(id)
    local src = source
    local obj = graveObj[id]
    if not obj then return print(("[DEBUG] No loot table found with id '%s'."):format(tostring(id))) end
    if not obj:verifyEligible(src) then return end
end)

function BuildGraveObjects()
    for k, graveData in pairs(Config.Graves) do
        local id = Bridge.Ids.Random(graveObj, 10)
        GraveClass:new(id, graveData.position, graveData.lootTable)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    BuildGraveObjects()
    Wait(2000)
    SharedData.Graves = graveObj
end)