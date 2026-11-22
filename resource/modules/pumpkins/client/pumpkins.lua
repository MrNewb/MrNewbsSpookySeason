local pumpkinIds = {}
local claimingPumpkin = false

local function claimPumpkin(pumpkinId)
	if claimingPumpkin then return end
	claimingPumpkin = true
	local ped = cache.ped
	lib.requestAnimDict('anim@treasurehunt@hatchet@action')
	TaskPlayAnim(ped, 'anim@treasurehunt@hatchet@action', 'hatchet_pickup', 8.0, -8.0, -1, 1, 31, true, true, true)
	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)
	ForceLightningFlash()
	Wait(5000)

	local result = lib.callback.await('MrNewbsSpookySeason:Callback:ClaimPumpkin', false, pumpkinId)
	StopAnimTask(ped, 'anim@treasurehunt@hatchet@action', 'hatchet_pickup', 0.5)
	RemoveAnimDict('anim@treasurehunt@hatchet@action')

	if result == 'trick' then
		SetPedToRagdoll(ped, 1000, 1000, 0, false, false, false)
		bridge.notifications.notify({ description = locale('Notifications.TrickNotification'), type = 'error', duration = 5000 })
	elseif result == 'treat' then
		PlaySoundFrontend(-1, 'CHECKPOINT_PERFECT', 'HUD_MINI_GAME_SOUNDSET', false)
		bridge.notifications.notify({ description = locale('Notifications.TreatNotification'), type = 'success', duration = 5000 })
	end

	if result then
		exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:pumpkin:%s'):format(pumpkinId))
		pumpkinIds[pumpkinId] = nil
	end
	claimingPumpkin = false
end

function RegisterSpookyPumpkins(list)
	if not list or #list == 0 then return end

	local batch = {}
	for i = 1, #list do
		local pumpkin = list[i]
		pumpkinIds[pumpkin.id] = true
		batch[#batch + 1] = {
			id = ('MrNewbsSpookySeason:pumpkin:%s'):format(pumpkin.id),
			payload = {
				model = pumpkin.model,
				coords = vector3(pumpkin.position.x, pumpkin.position.y, pumpkin.position.z),
				heading = pumpkin.position.w,
				radius = 100.0,
				options = {
					{
						label = locale('Target.PumpkinLabel'),
						icon = locale('Target.PumpkinIcon'),
						distance = 5.0,
						onSelect = function()
							claimPumpkin(pumpkin.id)
						end,
					},
				},
			},
		}
	end

	exports[bridge.name]:AddInteractionsBatch(batch)
end

function RemoveSpookyPumpkins()
	for pumpkinId in pairs(pumpkinIds) do
		exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:pumpkin:%s'):format(pumpkinId))
	end
	pumpkinIds = {}
	claimingPumpkin = false
end
