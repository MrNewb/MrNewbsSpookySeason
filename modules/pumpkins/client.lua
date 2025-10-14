---@diagnostic disable: duplicate-set-field
local pumpkinObj = {}
PumpkinClass = {}
PumpkinClass.__index = PumpkinClass

function PumpkinClass:new(id, position, model)
    local obj = {
        id = id,
        position = position,
        model = model
    }
    setmetatable(obj, self)
    pumpkinObj[id] = obj
    obj:register()
    return obj
end

function PumpkinClass:destroy()
    Bridge.Entity.Destroy(self.id)
    pumpkinObj[self.id] = nil
end

function PumpkinClass:trickOrTreat(ped)
    local chance = math.random(1, 100)
    if chance <= 50 then return true end
    SetPedToRagdoll(ped, 1000, 1000, 0, false, false, false)
    TriggerServerEvent("MrNewbsSpookySeason:Server:JackOLantern:FailedGrab", self.id)
    self:destroy()
    Bridge.Notify.SendNotify(locale("Notifications.TrickNotification"), "error", 5000)
    return false
end

function PumpkinClass:pumpkinClaim()
    local ped = PlayerPedId()
	local animationDict = "anim@treasurehunt@hatchet@action"
	local animName = "hatchet_pickup"
	Bridge.Utility.RequestAnimDict(animationDict)
    TaskPlayAnim(ped, animationDict, animName, 8.0, -8.0, -1, 1, 31, true, true, true)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.5)
    ForceLightningFlash()
    local success = self:trickOrTreat(ped)
    if not success then return end
	Wait(5000)
    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", false)
	StopAnimTask(ped, animationDict, animName, 0.5)
	Wait(500)
    Bridge.Notify.SendNotify(locale("Notifications.TreatNotification"), "success", 5000)
    TriggerServerEvent("MrNewbsSpookySeason:Server:JackOLantern:ClaimLoot", self.id)
	RemoveAnimDict(animationDict)
    self:destroy()
end

function PumpkinClass:register()
    Bridge.Entity.Create({
        id = self.id,
        entityType = "object",
        model = self.model,
        coords = self.position,
        heading = self.position.w,
        spawnDistance = 100,
        OnSpawn = function(entityData)
            SetEntityInvincible(entityData.spawned, true)
            FreezeEntityPosition(entityData.spawned, true)
            Bridge.Target.AddLocalEntity(entityData.spawned, {
                {
                    name = 'SpookyPumpkin ' .. entityData.id,
                    label = locale("Target.PumpkinLabel"),
                    icon  = locale("Target.PumpkinIcon"),
                    color = locale("Target.PumpkinColor"),
                    distance = 5,
                    onSelect = function()
                        self:pumpkinClaim()
                    end
                },
            })
            self.entityID = entityData.spawned
        end,
        OnRemove = function(entityData)
            if not entityData.spawned then return end
            Bridge.Target.RemoveLocalEntity(entityData.spawned)
            self.entityID = nil
        end
    })
end

AddEventHandler('community_bridge:Client:OnPlayerLoaded', function()
    Wait(1000)
    if not SharedData.Pumpkins then return end
    local plyridentifier = Bridge.Framework.GetPlayerIdentifier()
    for k, pumpkinData in pairs(SharedData.Pumpkins) do
        if not pumpkinData.claimed[plyridentifier] then
            PumpkinClass:new(k, pumpkinData.position, pumpkinData.model)
        end
    end
end)

local function destroyAll()
    for k, v in pairs(pumpkinObj) do
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