---@diagnostic disable: duplicate-set-field
local trickOrTreatObj = {}
TickOrTreatClass = {}
TickOrTreatClass.__index = TickOrTreatClass

function TickOrTreatClass:new(id, targetPoint, entityType, model, pedSpawn)
    local obj = {
        id = id,
        targetPoint = targetPoint,
        entityType = entityType,
        model = model,
        pedSpawn = pedSpawn,
    }
    setmetatable(obj, self)
    trickOrTreatObj[id] = obj
    obj:register()
    return obj
end

function TickOrTreatClass:register()
    local options = {
        {
            name = 'Knock ' .. self.id,
            icon = locale("Target.TrickKnockIcon"),
            iconColor = locale("Target.TrickKnockIconColor"),
            label = locale("Target.TrickKnockLabel"),
            distance = 2,
            onSelect = function()
                self:interaction()
            end,
        },
    }
    self.target = Bridge.Target.AddSphereZone(self.id, vector3(self.targetPoint.x, self.targetPoint.y, self.targetPoint.z), self.targetPoint.w, options, false)
    if Config.TrickOrTreatBlips then self.blip = Bridge.Utility.CreateBlip(self.targetPoint, 40, 44, 0.8, locale("Target.TrickKnockBlip"), true, 9) end
end

function TickOrTreatClass:entityCleanup()
    TaskTurnPedToFaceCoord(self.ped, self.targetPoint.x, self.targetPoint.y, self.targetPoint.z, 1.0)
    for i = 255, 0, -5 do
        SetEntityAlpha(self.ped, i, false)
        Wait(10)
    end
    Bridge.Utility.RemovePed(self.ped)
end

function TickOrTreatClass:createHousePed()
    self.ped = Bridge.Utility.CreatePed(self.model, vector3(self.pedSpawn.x, self.pedSpawn.y, self.pedSpawn.z), self.pedSpawn.w, false, nil)
    SetEntityAsMissionEntity(self.ped, true, true)
    SetEntityInvincible(self.ped, true)
    SetBlockingOfNonTemporaryEvents(self.ped, true)
end

function TickOrTreatClass:destroy()
    if self.target then Bridge.Target.RemoveZone(self.id) end
    if self.blip then Bridge.Utility.RemoveBlip(self.blip) end
    trickOrTreatObj[self.id] = nil
end

function TickOrTreatClass:interaction()
    local myPed = PlayerPedId()
    local myCoords = GetEntityCoords(myPed)
    local houseDict = "timetable@jimmy@doorknock@"
    local houseAnim = "knockdoor_idle"
    local sharedDict = "mp_common"
    local sharedAnim = "givetake2_a"
    Bridge.Utility.RequestAnimDict(houseDict)
    Bridge.Utility.RequestAnimDict(sharedDict)
    TaskTurnPedToFaceCoord(myPed, self.targetPoint.x, self.targetPoint.y, self.targetPoint.z, 1.0)
    TaskPlayAnim(myPed, houseDict, houseAnim, 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(3000)
    StopAnimTask(myPed, houseDict, houseAnim, 1.0)
    self:createHousePed()
    TaskTurnPedToFaceEntity(self.ped, myPed, 1.0)
    TaskTurnPedToFaceCoord(self.ped, myCoords.x, myCoords.y, myCoords.z, 1.0)
    TaskTurnPedToFaceCoord(myPed, self.pedSpawn.x, self.pedSpawn.y, self.pedSpawn.z, 1.0)
    TaskPlayAnim(self.ped, sharedDict, sharedAnim, 8.0, -8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(myPed, sharedDict, sharedAnim, 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(3000)
    StopAnimTask(self.ped, sharedDict, sharedAnim, 1.0)
    StopAnimTask(myPed, sharedDict, sharedAnim, 1.0)
    RemoveAnimDict(houseDict)
    RemoveAnimDict(sharedDict)
    TriggerServerEvent("MrNewbsSpookySeason:Server:TickOrTreat:GiveCandy", self.id)
    self:entityCleanup()
    Wait(1000)
    self:destroy()
end

local function destroyAll()
    for k, v in pairs(trickOrTreatObj) do
        v:destroy()
    end
end

AddEventHandler('MrNewbsSpookySeason:Client:InitialData', function(data)
    if source ~= 65535 then return end
    if not data.TrickOrTreat then return end
    local identifier = Bridge.Framework.GetPlayerIdentifier()
    for k, treat in pairs(data.TrickOrTreat) do
        if not treat.claimed[identifier] then
            TickOrTreatClass:new(k, treat.targetPoint, treat.entityType, treat.model, treat.pedSpawn)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    destroyAll()
end)

AddEventHandler("community_bridge:Client:OnPlayerUnload", function()
    destroyAll()
end)