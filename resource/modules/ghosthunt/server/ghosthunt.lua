local ghostHunt = nil

local function buildGhostHunt()
	if GetResourceState('pengu_digiscanner') ~= 'started' then return end
	if not Config.GhostHunts or #Config.GhostHunts == 0 then return end

	local hunt = Config.GhostHunts[math.random(1, #Config.GhostHunts)]
	ghostHunt = {
		id = 1,
		position = hunt.position,
		model = hunt.model,
		claimed = {},
	}
end

function GetGhostHuntClientList(src)
	local list = {}
	if not ghostHunt then return list end

	local identifier = bridge.framework.getIdentifier(src)
	if not identifier or ghostHunt.claimed[identifier] then return list end

	list[1] = {
		id = ghostHunt.id,
		position = ghostHunt.position,
		model = ghostHunt.model,
	}
	return list
end

RegisterNetEvent('MrNewbsSpookySeason:server:claimedGhostLoot', function(ghostId)
	local src = source
	if type(ghostId) ~= 'number' or ghostId ~= math.floor(ghostId) or not ghostHunt or ghostHunt.id ~= ghostId then return end
	if not IsSpookyPlayerNear(src, ghostHunt.position, 10.0) then return end

	local identifier = bridge.framework.getIdentifier(src)
	if not identifier or ghostHunt.claimed[identifier] then return end

	ghostHunt.claimed[identifier] = true
	GrantSpookyEventTokens(src, 5, 40)
	TriggerClientEvent('MrNewbsSpookySeason:client:completedRitual', src, ghostId)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if cache.resource ~= resourceName then return end
	buildGhostHunt()
end)
