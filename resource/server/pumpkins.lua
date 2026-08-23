local pumpkinObjects = {}

local function buildPumpkins()
	for index, data in ipairs(Config.Pumpkins) do
		pumpkinObjects[index] = {
			id = index,
			position = data.position,
			model = data.model or `prop_veg_crop_03_pump`,
			lootTable = data.lootTable,
			claimed = {},
		}
	end
end

function GetPumpkinClientList(src)
	local identifier = bridge.framework.getIdentifier(src)
	local list = {}
	if not identifier then return list end

	for index, pumpkin in pairs(pumpkinObjects) do
		if not pumpkin.claimed[identifier] then
			list[#list + 1] = {
				id = index,
				position = pumpkin.position,
				model = pumpkin.model,
			}
		end
	end

	return list
end

lib.callback.register('MrNewbsSpookySeason:Callback:ClaimPumpkin', function(src, pumpkinId)
	if type(pumpkinId) ~= 'number' or pumpkinId ~= math.floor(pumpkinId) then return false end

	local pumpkin = pumpkinObjects[pumpkinId]
	if not pumpkin then return false end
	if not IsSpookyPlayerNear(src, pumpkin.position, 5.0) then return false end

	local identifier = bridge.framework.getIdentifier(src)
	if not identifier or pumpkin.claimed[identifier] then return false end

	pumpkin.claimed[identifier] = true

	if math.random(1, 100) <= 50 then
		return 'trick'
	end

	GrantSpookyReward(src, RollSpookyLoot(pumpkin.lootTable))
	GrantSpookyEventTokens(src, 1, 3)
	return 'treat'
end)

buildPumpkins()
