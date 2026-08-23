local houseIds = {}
local houseBlips = {}
local knockingOnHouse = false

local function createHousePed(model, spawn)
	local modelHash = lib.requestModel(model)
	if not modelHash then return 0 end

	local ped = CreatePed(4, modelHash, spawn.x, spawn.y, spawn.z, spawn.w, false, false)
	SetModelAsNoLongerNeeded(modelHash)
	if ped == 0 or not DoesEntityExist(ped) then return 0 end

	SetEntityAsMissionEntity(ped, true, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	return ped
end

local function fadeAndDeletePed(ped, targetPoint)
	if ped == 0 or not DoesEntityExist(ped) then return end
	TaskTurnPedToFaceCoord(ped, targetPoint.x, targetPoint.y, targetPoint.z, 1.0)
	for alpha = 255, 0, -5 do
		if not DoesEntityExist(ped) then return end
		SetEntityAlpha(ped, alpha, false)
		Wait(10)
	end
	if DoesEntityExist(ped) then DeleteEntity(ped) end
end

local function knockOnHouse(house)
	if knockingOnHouse then return end
	knockingOnHouse = true
	bridge.target.removeZone(('MrNewbsSpookySeason:trickortreat:%s'):format(house.id))
	if houseBlips[house.id] and DoesBlipExist(houseBlips[house.id]) then
		RemoveBlip(houseBlips[house.id])
		houseBlips[house.id] = nil
	end

	local playerPed = cache.ped
	lib.requestAnimDict('timetable@jimmy@doorknock@')
	lib.requestAnimDict('mp_common')
	TaskTurnPedToFaceCoord(playerPed, house.targetPoint.x, house.targetPoint.y, house.targetPoint.z, 1.0)
	TaskPlayAnim(playerPed, 'timetable@jimmy@doorknock@', 'knockdoor_idle', 8.0, -8.0, -1, 1, 0, false, false, false)
	Wait(3000)
	StopAnimTask(playerPed, 'timetable@jimmy@doorknock@', 'knockdoor_idle', 1.0)

	local housePed = createHousePed(house.model, house.pedSpawn)
	if housePed ~= 0 then
		TaskTurnPedToFaceEntity(housePed, playerPed, 1.0)
		TaskPlayAnim(housePed, 'mp_common', 'givetake2_a', 8.0, -8.0, -1, 1, 0, false, false, false)
	end
	TaskTurnPedToFaceCoord(playerPed, house.pedSpawn.x, house.pedSpawn.y, house.pedSpawn.z, 1.0)
	TaskPlayAnim(playerPed, 'mp_common', 'givetake2_a', 8.0, -8.0, -1, 1, 0, false, false, false)
	Wait(3000)
	StopAnimTask(playerPed, 'mp_common', 'givetake2_a', 1.0)
	if housePed ~= 0 then StopAnimTask(housePed, 'mp_common', 'givetake2_a', 1.0) end
	RemoveAnimDict('timetable@jimmy@doorknock@')
	RemoveAnimDict('mp_common')

	lib.callback.await('MrNewbsSpookySeason:Callback:ClaimTrickOrTreat', false, house.id)
	fadeAndDeletePed(housePed, house.targetPoint)
	houseIds[house.id] = nil
	knockingOnHouse = false
end

function RegisterSpookyTrickOrTreat(list)
	if not list or #list == 0 then return end

	for i = 1, #list do
		local house = list[i]
		houseIds[house.id] = true

		bridge.target.addSphereZone({
			name = ('MrNewbsSpookySeason:trickortreat:%s'):format(house.id),
			coords = vector3(house.targetPoint.x, house.targetPoint.y, house.targetPoint.z),
			radius = house.targetPoint.w or 0.5,
			options = {
				{
					name = ('MrNewbsSpookySeason:trickortreat:%s'):format(house.id),
					icon = locale('Target.TrickKnockIcon'),
					iconColor = locale('Target.TrickKnockIconColor'),
					label = locale('Target.TrickKnockLabel'),
					distance = 2.0,
					onSelect = function()
						knockOnHouse(house)
					end,
				},
			},
		})

		if Config.TrickOrTreatBlips then
			local blip = AddBlipForCoord(house.targetPoint.x, house.targetPoint.y, house.targetPoint.z)
			SetBlipSprite(blip, 40)
			SetBlipColour(blip, 44)
			SetBlipScale(blip, 0.8)
			SetBlipAsShortRange(blip, true)
			SetBlipDisplay(blip, 9)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(locale('Target.TrickKnockBlip'))
			EndTextCommandSetBlipName(blip)
			houseBlips[house.id] = blip
		end
	end
end

function RemoveSpookyTrickOrTreat()
	for houseId in pairs(houseIds) do
		bridge.target.removeZone(('MrNewbsSpookySeason:trickortreat:%s'):format(houseId))
		if houseBlips[houseId] and DoesBlipExist(houseBlips[houseId]) then
			RemoveBlip(houseBlips[houseId])
		end
	end
	houseIds = {}
	houseBlips = {}
	knockingOnHouse = false
end
