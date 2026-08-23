local function useSpookyItem(src, item, lootPool)
	local success = lib.callback.await('MrNewbsSpookySeason:Callback:UseItemProgress', src, item and (item.label or item.name) or lootPool)
	if not success then
		bridge.notifications.notify(src, { description = locale('Notifications.Canceled'), type = 'error', duration = 5000 })
		return
	end

	local itemName = item and item.name or lootPool
	if not bridge.inventory.removeItem(src, itemName, 1, nil, item and item.slot) then return end
	GrantSpookyReward(src, RollSpookyLoot(lootPool))
end

bridge.framework.registerItemUse('pumpkin_basket', function(src, item)
	useSpookyItem(src, item, 'pumpkin_basket')
end)

bridge.framework.registerItemUse('rotten_casket', function(src, item)
	useSpookyItem(src, item, 'rotten_casket')
end)
