function IsSpookyPlayerNear(src, coords, maxDistance)
	local ped = GetPlayerPed(src)
	if ped == 0 or not DoesEntityExist(ped) then return false end
	return #(GetEntityCoords(ped) - vector3(coords.x, coords.y, coords.z)) <= maxDistance
end

function RollSpookyLoot(poolName)
	local pool = Config.LootTypes[poolName]
	if not pool or #pool == 0 then return end
	return pool[math.random(1, #pool)]
end

function GrantSpookyReward(src, reward)
	if not reward then return false end

	local count = reward.count
	if not count then
		count = math.random(reward.min or 1, reward.max or 1)
	end

	if reward.rewardType == 'cash' then
		return bridge.framework.addMoney(src, 'cash', count, 'spooky_season')
	end

	if reward.rewardType == 'item' then
		bridge.inventory.addItem(src, reward.name, count, reward.metadata)
		return true
	end

	return false
end

function GrantSpookyEventTokens(src, minCount, maxCount)
	bridge.inventory.addItem(src, 'event_token', math.random(minCount, maxCount), {
		description = locale('Items.EventTokenDescription'),
	})
end
