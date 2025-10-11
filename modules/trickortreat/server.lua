---@diagnostic disable: duplicate-set-field
local trickOrTreatObj = {}
TickOrTreatClass = {}
TickOrTreatClass.__index = TickOrTreatClass

function TickOrTreatClass:new(id, targetPoint, entityType, model, pedSpawn, lootTable)
    local obj = {
        id = id,
        targetPoint = targetPoint,
        entityType = entityType,
        model = model,
        pedSpawn = pedSpawn,
        lootTable = lootTable,
        claimed = {}
    }
    setmetatable(obj, self)
    trickOrTreatObj[id] = obj
    return obj
end

function TickOrTreatClass:getLootTable()
    return Config.LootTypes[self.lootTable]
end

function TickOrTreatClass:verifyEligible(src)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local jackOLanternCoords = vector3(self.pedSpawn.x, self.pedSpawn.y, self.pedSpawn.z)
    local distance = #(playerCoords - jackOLanternCoords)
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier(src)
    if distance < 5 and not self.claimed[plyridentifier] then
        self.claimed[plyridentifier] = true
        self:addItemsForPlayer(src)
        return true
    end
    return false
end

function TickOrTreatClass:addItemsForPlayer(src)
    local lootTable = self:getLootTable()
    local randomIndex = math.random(1, #lootTable)
    local selectedItem = lootTable[randomIndex]
    if selectedItem.rewardType == "cash" then
        Bridge.Framework.AddAccountBalance(src, "cash", selectedItem.count)
    elseif selectedItem.rewardType == "item" then
        Bridge.Inventory.AddItem(src, selectedItem.name, selectedItem.count or 1, nil, selectedItem.metadata or {})
    end
    if math.random(1, 100) <= 25 then
        Bridge.Inventory.AddItem(src, "event_token", math.random(1, 3), nil, { description = locale("Items.EventTokenDescription") })
    end
end

RegisterNetEvent("MrNewbsSpookySeason:Server:TickOrTreat:GiveCandy", function(id)
    local src = source
    if not trickOrTreatObj[id] then return end
    local obj = trickOrTreatObj[id]
    obj:verifyEligible(src)
end)

function BuildTickOrTreatObjects()
    for k, treat in pairs(Config.TrickOrTreat) do
        local id = Bridge.Ids.Random(trickOrTreatObj, 10)
        TickOrTreatClass:new(id, treat.targetPoint, treat.entityType, treat.model, treat.pedSpawn, treat.lootTable)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    BuildTickOrTreatObjects()
    SharedData = SharedData or {}
    SharedData.TrickOrTreat = trickOrTreatObj
end)