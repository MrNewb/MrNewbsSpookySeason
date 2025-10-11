if GetResourceState("pengu_digiscanner") == "missing" then return end

---@diagnostic disable: duplicate-set-field
local ghostObj = {}
GhostClass = {}
GhostClass.__index = GhostClass

function GhostClass:new(id, position, entityType, model)
    local obj = {
        id = id,
        position = position,
        entityType = entityType,
        model = model,
        claimed = {},
    }
    setmetatable(obj, self)
    ghostObj[id] = obj
    return obj
end

function GhostClass:verifyEligible(src)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local graveCoords = vector3(self.position.x, self.position.y, self.position.z)
    local distance = #(playerCoords - graveCoords)
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier(src)
    print("Distance to ghost:", distance, "claimed:", self.claimed[plyridentifier] and "yes" or "no")
    if distance < 10 and not self.claimed[plyridentifier] then
        self.claimed[plyridentifier] = true
        self:addItemsForPlayer(src)
        return true
    end
    return false
end

function GhostClass:addItemsForPlayer(src)
    Bridge.Inventory.AddItem(src, "event_token", math.random(5, 40), nil, { description = locale("Items.EventTokenDescription") })
end

RegisterNetEvent("MrNewbsSpookySeason:Server:GhostHunting:ClaimLoot", function(id)
    local src = source
    local obj = ghostObj[id]
    if not obj then return print(("[DEBUG] No loot table found with id '%s'."):format(tostring(id))) end
    if not obj:verifyEligible(src) then return end
    TriggerClientEvent('MrNewbsSpookySeason:Client:GhostHunting:RitualComplete', src, id)
end)

function BuildGhostHuntObjects()
    local availableHunts = Config.GhostHunts
    local huntObject = availableHunts[math.random(1, #availableHunts)]
    local id = Bridge.Ids.Random(ghostObj, 10)
    GhostClass:new(id, huntObject.position, huntObject.entityType, huntObject.model)
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    BuildGhostHuntObjects()
    SharedData = SharedData or {}
    SharedData.GhostHunts = ghostObj
end)