---@diagnostic disable: duplicate-set-field
local graveObj = {}
GraveClass = {}
GraveClass.__index = GraveClass

function GraveClass:new(id, position)
    local obj = {
        id = id,
        position = position,
    }
    setmetatable(obj, self)
    graveObj[id] = obj
    obj:register()
    return obj
end

function GraveClass:spawnZombie()
    local chance = math.random(1, 100)
    if chance < 40 then return end
    local zombieModels = {"g_m_m_zombie_04", "u_m_y_zombie_01", "g_m_m_zombie_05"}
    local randModel = zombieModels[math.random(1, #zombieModels)]
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local startZ = self.position.z - 5.0
    local zombPed = Bridge.Utility.CreatePed(randModel, vector3(self.position.x, self.position.y, startZ), 0.0, false, nil)
    SetEntityAsMissionEntity(zombPed, true, true)
    SetPedRelationshipGroupHash(zombPed, 'ZOMBIE')
    SetPedRagdollBlockingFlags(zombPed, 1)
    SetPedCanRagdollFromPlayerImpact(zombPed, false)
    SetBlockingOfNonTemporaryEvents(zombPed, true)
    SetEntityHealth(zombPed, 150.0)
    SetPedArmour(zombPed, 100)
    local startTime = GetGameTimer()
    local duration = 6000

    CreateThread(function()
        while GetGameTimer() - startTime < duration do
            local elapsed = GetGameTimer() - startTime
            local progress = elapsed / duration
            local currentZ = startZ + (pedCoords.z - 1.0 - startZ) * progress
            SetEntityCoords(zombPed, self.position.x, self.position.y, currentZ, false, false, false, true)
            Wait(1)
        end
        SetEntityCoords(zombPed, self.position.x, self.position.y, pedCoords.z - 1.0, false, false, false, true)
        TaskWanderStandard(zombPed, 10.0, 10)
        TaskCombatPed(zombPed, ped, 0, 16)
    end)
    SetTimeout(120000, function()
        if DoesEntityExist(zombPed) then
            ClearPedTasksImmediately(zombPed)
            SetEntityAsNoLongerNeeded(zombPed)
            DeleteEntity(zombPed)
        end
    end)
end

function GraveClass:digGrave()
    local ped = PlayerPedId()
	local animationDict = "random@burial"
	local animName = "a_burial"
    local prop1 = Bridge.Utility.CreateProp("prop_tool_shovel", vector3(0, 0, 0), 0.0, false)
    local prop2 = Bridge.Utility.CreateProp("prop_ld_shovel_dirt", vector3(0, 0, 0), 0.0, false)
    SetEntityAsMissionEntity(prop2, true, true)
    SetEntityAsMissionEntity(prop1, true, true)
	Bridge.Utility.RequestAnimDict(animationDict)

    TaskPlayAnim(ped, animationDict, animName, 8.0, -8.0, -1, 1, 31, true, true, true)
    AttachEntityToEntity(prop1, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.24, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    AttachEntityToEntity(prop2, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.24, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    self:spawnZombie()
	Wait(6000)
	StopAnimTask(ped, animationDict, animName, 0.5)

	Wait(500)
	if DoesEntityExist(prop1) then DeleteObject(prop1) end
	if DoesEntityExist(prop2) then DeleteObject(prop2) end
    RemoveAnimDict(animationDict)
    TriggerServerEvent("MrNewbsSpookySeason:Server:GraveRobbing:ClaimLoot", self.id)
    self:destroy()
end

function GraveClass:register()
    local options = {
        {
            name = 'Grave ' .. self.id,
            icon = "fa-solid fa-digging",
            iconColor = "orange",
            label = "Dig Grave",
            distance = 2,
            canInteract = function(entity)
                return true
            end,
            onSelect = function()
                self:digGrave()
            end,
        },
    }
    self.target = Bridge.Target.AddSphereZone(self.id, vector3(self.position.x, self.position.y, self.position.z), self.position.w, options, false)
end

function GraveClass:destroy()
    if self.target then Bridge.Target.RemoveZone(self.id) end
    graveObj[self.id] = nil
end

AddEventHandler('MrNewbsSpookySeason:Client:InitialData', function(data)
    if source ~= 65535 then return end
    if not data.Graves then return end
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier()
    for k, grave in pairs(data.Graves) do
        if not grave.claimed[plyridentifier] then
            GraveClass:new(k, grave.position)
        end
    end
end)

local function destroyAll()
    for k, v in pairs(graveObj) do
        v:destroy()
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    destroyAll()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    local zombies = `ZOMBIE`
    local players = `PLAYER`
    AddRelationshipGroup('ZOMBIE')
    SetRelationshipBetweenGroups(5, players, zombies)
    SetRelationshipBetweenGroups(5, zombies, players)
end)

AddEventHandler("community_bridge:Client:OnPlayerUnload", function()
    destroyAll()
end)