local ghostIds = {}
local ghostEntities = {}
local ghostParticles = {}

function RegisterSpookyGhostHunts(list)
	if GetResourceState('pengu_digiscanner') == 'missing' or not list or #list == 0 then return end

	for i = 1, #list do
		local hunt = list[i]
		ghostIds[hunt.id] = true

		exports[bridge.name]:AddInteraction(('MrNewbsSpookySeason:ghost:%s'):format(hunt.id), {
			model = hunt.model,
			coords = vector3(hunt.position.x, hunt.position.y, hunt.position.z),
			heading = hunt.position.w,
			radius = 100.0,
			onSpawn = function(interaction)
				ghostEntities[hunt.id] = interaction.entity
				lib.requestNamedPtfxAsset('core')
				UseParticleFxAssetNextCall('core')
				ghostParticles[hunt.id] = StartParticleFxLoopedOnEntity('ent_amb_fbi_door_smoke', interaction.entity, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
			end,
			onDespawn = function()
				if ghostParticles[hunt.id] then
					StopParticleFxLooped(ghostParticles[hunt.id], false)
					ghostParticles[hunt.id] = nil
				end
				ghostEntities[hunt.id] = nil
			end,
		})

		exports.pengu_digiscanner:SetupDigiScanner(vector3(hunt.position.x, hunt.position.y, hunt.position.z), {
			event = 'MrNewbsSpookySeason:Server:GhostHunting:ClaimLoot',
			isServer = true,
			args = hunt.id,
			interact = {
				interactKey = 38,
				interactMessage = locale('GhostHunt.InteractMessage'),
			},
		})
	end
end

function RemoveSpookyGhostHunts()
	for ghostId in pairs(ghostIds) do
		if ghostParticles[ghostId] then
			StopParticleFxLooped(ghostParticles[ghostId], false)
			ghostParticles[ghostId] = nil
		end
		ghostEntities[ghostId] = nil
		exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:ghost:%s'):format(ghostId))
	end
	ghostIds = {}
end

local function playGhostRitual(ghostId)
	local entity = ghostEntities[ghostId]
	ForceLightningFlash()
	if not entity or not DoesEntityExist(entity) then
		exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:ghost:%s'):format(ghostId))
		ghostIds[ghostId] = nil
		return
	end

	local candleModels = { `vw_prop_casino_art_skull_03b`, `vw_prop_casino_art_skull_03a` }
	local isPed = IsEntityAPed(entity)
	if isPed then PlayPain(entity, 3, 0.0) end

	local ghostCoords = GetEntityCoords(entity)
	local circleRadius = 1.2
	local ritualCandles = {}
	local numberOfCandles = 8
	local ritualDuration = 15000
	local ritualStartTime = GetGameTimer()
	local candleSpinSpeed = 1.5
	local candleTilt = 0.0

	for i = 1, numberOfCandles do
		local candleAngle = (i / numberOfCandles) * math.pi * 2
		local candleX = ghostCoords.x + circleRadius * math.cos(candleAngle)
		local candleY = ghostCoords.y + circleRadius * math.sin(candleAngle)
		local modelHash = lib.requestModel(candleModels[math.random(#candleModels)])
		if modelHash then
			local candle = CreateObject(modelHash, candleX, candleY, ghostCoords.z, false, false, false)
			SetModelAsNoLongerNeeded(modelHash)
			if candle ~= 0 and DoesEntityExist(candle) then
				PlaceObjectOnGroundProperly(candle)
				SetEntityHeading(candle, math.deg(candleAngle))
				SetEntityAsMissionEntity(candle, true, true)
				SetEntityCollision(candle, false, true)
				ritualCandles[#ritualCandles + 1] = candle
			end
		end
	end

	if isPed then StartEntityFire(entity) end

	while GetGameTimer() - ritualStartTime < ritualDuration do
		if not DoesEntityExist(entity) then break end
		ghostCoords = GetEntityCoords(entity)
		local timeElapsed = (GetGameTimer() - ritualStartTime) / 1000.0
		for i = 1, #ritualCandles do
			local candle = ritualCandles[i]
			if DoesEntityExist(candle) then
				local baseAngle = (i / numberOfCandles) * math.pi * 2
				local currentAngle = baseAngle + timeElapsed * candleSpinSpeed
				SetEntityCoordsNoOffset(candle, ghostCoords.x + circleRadius * math.cos(currentAngle), ghostCoords.y + circleRadius * math.sin(currentAngle), ghostCoords.z, false, false, false)
				SetEntityRotation(candle, candleTilt, 0.0, math.deg(currentAngle), 2, true)
			end
		end
		if candleTilt < 20.0 then candleTilt = candleTilt + 0.05 end
		Wait(0)
	end

	for i = 1, #ritualCandles do
		if DoesEntityExist(ritualCandles[i]) then DeleteEntity(ritualCandles[i]) end
	end

	Wait(4500)
	ForceLightningFlash()
	if ghostParticles[ghostId] then
		StopParticleFxLooped(ghostParticles[ghostId], false)
		ghostParticles[ghostId] = nil
	end
	exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:ghost:%s'):format(ghostId))
	ghostIds[ghostId] = nil
	ghostEntities[ghostId] = nil
end

RegisterNetEvent('MrNewbsSpookySeason:Client:GhostHunting:RitualComplete', function(ghostId)
	if source ~= 65535 then return end
	if not ghostIds[ghostId] then return end
	playGhostRitual(ghostId)
end)
