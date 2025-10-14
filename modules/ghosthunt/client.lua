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
    }
    setmetatable(obj, self)
    ghostObj[id] = obj
    obj:register()
    return obj
end

function GhostClass:register()
    Bridge.Entity.Create({
        id = self.id,
        entityType = self.entityType,
        model = self.model,
        coords = self.position,
        heading = self.position.w,
        spawnDistance = 100,
        OnSpawn = function(entityData)
            self.entityID = entityData.spawned
            Bridge.Particle.CreateOnEntity("core", "ent_amb_fbi_door_smoke", entityData.spawned, vector3(0.0, 0.0, 1.0), vector3(0.0, 0.0, 0.0), 1.5, vector3(0, 0, 0), true, false)
        end,
        OnRemove = function(entityData)
            if not entityData.spawned then return end
            self.entityID = nil
        end
    })

    exports['pengu_digiscanner']:SetupDigiScanner(vector3(self.position.x, self.position.y, self.position.z), {
        event = "MrNewbsSpookySeason:Server:GhostHunting:ClaimLoot",
        isServer = true,
        args = self.id,
        interact = {
            interactKey = 38,
            interactMessage = locale("GhostHunt.InteractMessage"),
        }
    })
end

function GhostClass:destroy()
    Bridge.Entity.Destroy(self.id)
    ghostObj[self.id] = nil
end

function GhostClass:destroyRitual()
    ForceLightningFlash()
    if not self.entityID then self:destroy() return end

    local candleModels = {"vw_prop_casino_art_skull_03b", "vw_prop_casino_art_skull_03b", "vw_prop_casino_art_skull_03a", "vw_prop_casino_art_skull_03a"}

    local isGhostPed = self.entityType == "ped"
    if isGhostPed then PlayPain(self.entityID, 3, 0.0) end

    local ghostCoords = GetEntityCoords(self.entityID)
    local circleRadius = 1.2
    local ritualCandles = {}
    local numberOfCandles = 8

    local ritualDuration = 15000
    local ritualStartTime = GetGameTimer()
    local candleSpinSpeed = 1.5
    local candleTilt = 0

    for i = 1, numberOfCandles do
        local candleAngle = (i / numberOfCandles) * math.pi * 2
        local candleX = ghostCoords.x + circleRadius * math.cos(candleAngle)
        local candleY = ghostCoords.y + circleRadius * math.sin(candleAngle)
        local candleZ = ghostCoords.z

        local randomModel = candleModels[math.random(#candleModels)]
        local candleEntity = Bridge.Utility.CreateProp(randomModel, vector3(candleX, candleY, candleZ), 0.0, false)

        PlaceObjectOnGroundProperly(candleEntity)
        SetEntityHeading(candleEntity, math.deg(candleAngle))
        SetEntityAsMissionEntity(candleEntity, true, true)
        SetEntityCollision(candleEntity, false, true)

        table.insert(ritualCandles, candleEntity)
    end

    if isGhostPed then StartEntityFire(self.entityID) end

    while GetGameTimer() - ritualStartTime < ritualDuration do
        if not self.entityID then break end

        ghostCoords = GetEntityCoords(self.entityID)
        local timeElapsed = (GetGameTimer() - ritualStartTime) / 1000.0

        for i, candle in ipairs(ritualCandles) do
            if DoesEntityExist(candle) then
                local baseAngle = (i / numberOfCandles) * math.pi * 2
                local currentAngle = baseAngle + timeElapsed * candleSpinSpeed

                local newX = ghostCoords.x + circleRadius * math.cos(currentAngle)
                local newY = ghostCoords.y + circleRadius * math.sin(currentAngle)
                local newZ = ghostCoords.z

                SetEntityCoordsNoOffset(candle, newX, newY, newZ, false, false, false)
                SetEntityRotation(candle, candleTilt, 0.0, math.deg(currentAngle), 2, true)
            end
        end

        if candleTilt < 20 then candleTilt = candleTilt + 0.05 end

        Wait(0)
    end

    for _, candleProp in pairs(ritualCandles) do
        if DoesEntityExist(candleProp) then SetEntityAsMissionEntity(candleProp, true, true) DeleteEntity(candleProp) end
    end

    Wait(4500)
    ForceLightningFlash()
    self:destroy()
end

RegisterNetEvent('MrNewbsSpookySeason:Client:GhostHunting:RitualComplete', function(id)
    local obj = ghostObj[id]
    if not obj then return end
    obj:destroyRitual()
end)

AddEventHandler('community_bridge:Client:OnPlayerLoaded', function()
    Wait(1000)
    if not SharedData.GhostHunts then return end
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier()
    for k, huntData in pairs(SharedData.GhostHunts) do
        if not huntData.claimed[plyridentifier] then
            GhostClass:new(k, huntData.position, huntData.entityType, huntData.model)
        end
    end
end)

local function destroyAll()
    for k, v in pairs(ghostObj) do
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