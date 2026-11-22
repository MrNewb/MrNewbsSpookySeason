local graveObjects = {}

local function buildGraves()
	for index, data in ipairs(Config.Graves) do
		graveObjects[index] = {
			id = index,
			position = data.position,
			lootTable = data.lootTable,
			claimed = {},
		}
	end
end

function GetGraveClientList(src)
	local identifier = bridge.framework.getIdentifier(src)
	local list = {}
	if not identifier then return list end

	for index, grave in pairs(graveObjects) do
		if not grave.claimed[identifier] then
			list[#list + 1] = {
				id = index,
				position = grave.position,
			}
		end
	end

	return list
end

lib.callback.register('MrNewbsSpookySeason:Callback:ClaimGrave', function(src, graveId)
	if type(graveId) ~= 'number' or graveId ~= math.floor(graveId) then return false end

	local grave = graveObjects[graveId]
	if not grave then return false end
	if not IsSpookyPlayerNear(src, grave.position, 5.0) then return false end

	local identifier = bridge.framework.getIdentifier(src)
	if not identifier or grave.claimed[identifier] then return false end

	grave.claimed[identifier] = true
	GrantSpookyReward(src, RollSpookyLoot(grave.lootTable))
	GrantSpookyEventTokens(src, 1, 3)
	return true
end)

buildGraves()
