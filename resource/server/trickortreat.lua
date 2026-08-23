local trickOrTreatObjects = {}

local function buildTrickOrTreat()
	for index, data in ipairs(Config.TrickOrTreat) do
		trickOrTreatObjects[index] = {
			id = index,
			targetPoint = data.targetPoint,
			model = data.model,
			pedSpawn = data.pedSpawn,
			lootTable = data.lootTable,
			claimed = {},
		}
	end
end

function GetTrickOrTreatClientList(src)
	local identifier = bridge.framework.getIdentifier(src)
	local list = {}
	if not identifier then return list end

	for index, house in pairs(trickOrTreatObjects) do
		if not house.claimed[identifier] then
			list[#list + 1] = {
				id = index,
				targetPoint = house.targetPoint,
				model = house.model,
				pedSpawn = house.pedSpawn,
			}
		end
	end

	return list
end

lib.callback.register('MrNewbsSpookySeason:Callback:ClaimTrickOrTreat', function(src, houseId)
	if type(houseId) ~= 'number' then return false end

	local house = trickOrTreatObjects[houseId]
	if not house then return false end
	if not IsSpookyPlayerNear(src, house.pedSpawn, 5.0) then return false end

	local identifier = bridge.framework.getIdentifier(src)
	if not identifier or house.claimed[identifier] then return false end

	house.claimed[identifier] = true
	GrantSpookyReward(src, RollSpookyLoot(house.lootTable))
	if math.random(1, 100) <= 25 then
		GrantSpookyEventTokens(src, 1, 3)
	end
	return true
end)

buildTrickOrTreat()
