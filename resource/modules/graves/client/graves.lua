local graveIds = {}
local spawnedZombies = {}
local zombieGroup = `ZOMBIE`
local diggingGrave = false

local function spawnZombie(position)
	if math.random(1, 100) < 40 then return end

	local zombieModels = { `g_m_m_zombie_04`, `u_m_y_zombie_01`, `u_m_y_prisoner_01` }
	local modelHash = lib.requestModel(zombieModels[math.random(1, #zombieModels)])
	if not modelHash then return end

	local playerCoords = GetEntityCoords(cache.ped)
	local startZ = position.z - 5.0
	local zombie = CreatePed(4, modelHash, position.x, position.y, startZ, 0.0, false, false)
	SetModelAsNoLongerNeeded(modelHash)
	if zombie == 0 or not DoesEntityExist(zombie) then return end

	SetEntityAsMissionEntity(zombie, true, true)
	SetPedRelationshipGroupHash(zombie, zombieGroup)
	SetPedRagdollBlockingFlags(zombie, 1)
	SetPedCanRagdollFromPlayerImpact(zombie, false)
	SetBlockingOfNonTemporaryEvents(zombie, true)
	SetEntityHealth(zombie, 150)
	SetPedArmour(zombie, 100)

	local startTime = GetGameTimer()
	local duration = 6000
	local playerPed = cache.ped
	CreateThread(function()
		while GetGameTimer() - startTime < duration do
			local progress = (GetGameTimer() - startTime) / duration
			local currentZ = startZ + (playerCoords.z - 1.0 - startZ) * progress
			SetEntityCoords(zombie, position.x, position.y, currentZ, false, false, false, true)
			Wait(1)
		end
		if not DoesEntityExist(zombie) then return end
		SetEntityCoords(zombie, position.x, position.y, playerCoords.z - 1.0, false, false, false, true)
		TaskWanderStandard(zombie, 10.0, 10)
		TaskCombatPed(zombie, playerPed, 0, 16)
	end)

	SetTimeout(120000, function()
		if not DoesEntityExist(zombie) then return end
		ClearPedTasksImmediately(zombie)
		SetEntityAsNoLongerNeeded(zombie)
		DeleteEntity(zombie)
	end)

	spawnedZombies[#spawnedZombies + 1] = zombie
end

local function digGrave(graveId, position)
	if diggingGrave then return end
	diggingGrave = true
	local ped = cache.ped
	lib.requestAnimDict('random@burial')
	local shovel = nil
	local dirt = nil
	local shovelHash = lib.requestModel(`prop_tool_shovel`)
	local dirtHash = lib.requestModel(`prop_ld_shovel_dirt`)
	if shovelHash then
		shovel = CreateObject(shovelHash, 0.0, 0.0, 0.0, false, false, false)
		SetModelAsNoLongerNeeded(shovelHash)
	end
	if dirtHash then
		dirt = CreateObject(dirtHash, 0.0, 0.0, 0.0, false, false, false)
		SetModelAsNoLongerNeeded(dirtHash)
	end

	if shovel and DoesEntityExist(shovel) then
		SetEntityAsMissionEntity(shovel, true, true)
		AttachEntityToEntity(shovel, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.24, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	end
	if dirt and DoesEntityExist(dirt) then
		SetEntityAsMissionEntity(dirt, true, true)
		AttachEntityToEntity(dirt, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.24, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	end

	TaskPlayAnim(ped, 'random@burial', 'a_burial', 8.0, -8.0, -1, 1, 31, true, true, true)
	spawnZombie(position)
	Wait(6000)
	StopAnimTask(ped, 'random@burial', 'a_burial', 0.5)
	RemoveAnimDict('random@burial')

	if shovel and DoesEntityExist(shovel) then DeleteObject(shovel) end
	if dirt and DoesEntityExist(dirt) then DeleteObject(dirt) end

	local success = lib.callback.await('MrNewbsSpookySeason:Callback:ClaimGrave', false, graveId)
	diggingGrave = false
	if not success then return end

	bridge.target.removeZone(('MrNewbsSpookySeason:grave:%s'):format(graveId))
	graveIds[graveId] = nil
end

function RegisterSpookyGraves(list)
	if not list or #list == 0 then return end

	for i = 1, #list do
		local grave = list[i]
		graveIds[grave.id] = true
		bridge.target.addSphereZone({
			name = ('MrNewbsSpookySeason:grave:%s'):format(grave.id),
			coords = vector3(grave.position.x, grave.position.y, grave.position.z),
			radius = grave.position.w or 0.55,
			options = {
				{
					name = ('MrNewbsSpookySeason:grave:%s'):format(grave.id),
					icon = 'fa-solid fa-digging',
					iconColor = 'orange',
					label = locale('Target.GraveLabel'),
					distance = 2.0,
					onSelect = function()
						digGrave(grave.id, grave.position)
					end,
				},
			},
		})
	end
end

function RemoveSpookyGraves()
	for graveId in pairs(graveIds) do
		bridge.target.removeZone(('MrNewbsSpookySeason:grave:%s'):format(graveId))
	end
	for i = 1, #spawnedZombies do
		local zombie = spawnedZombies[i]
		if zombie and DoesEntityExist(zombie) then
			DeleteEntity(zombie)
		end
	end
	graveIds = {}
	spawnedZombies = {}
	diggingGrave = false
end

AddEventHandler('onResourceStart', function(resourceName)
	if cache.resource ~= resourceName then return end
	AddRelationshipGroup('ZOMBIE')
	SetRelationshipBetweenGroups(5, `PLAYER`, zombieGroup)
	SetRelationshipBetweenGroups(5, zombieGroup, `PLAYER`)
end)
