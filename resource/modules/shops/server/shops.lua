local lastPurchaseAt = {}

AddEventHandler('playerDropped', function()
	lastPurchaseAt[source] = nil
end)

RegisterNetEvent('MrNewbsSpookySeason:server:purchasedShopItem', function(shopId, itemName, amount)
	local src = source
	if type(shopId) ~= 'string' or shopId == '' or #shopId > 32 then return end
	if type(itemName) ~= 'string' or itemName == '' or #itemName > 64 then return end

	amount = tonumber(amount)
	if not amount or amount ~= amount or amount % 1 ~= 0 or amount < 1 or amount > 100 then
		bridge.notifications.notify(src, { description = locale('Shop.InvalidAmount'), type = 'error', duration = 5000 })
		return
	end

	local now = GetGameTimer()
	if lastPurchaseAt[src] and now - lastPurchaseAt[src] < 1000 then return end

	local shop = Config.Shops[shopId]
	if not shop or not shop.inventory then
		bridge.notifications.notify(src, { description = locale('Shop.InvalidShop'), type = 'error', duration = 5000 })
		return
	end

	local priceEach = shop.inventory[itemName]
	if type(priceEach) ~= 'number' or priceEach < 1 then
		bridge.notifications.notify(src, { description = locale('Shop.ItemNotForSale'), type = 'error', duration = 5000 })
		return
	end

	if not IsSpookyPlayerNear(src, shop.position, 5.0) then return end
	lastPurchaseAt[src] = now

	local totalPrice = priceEach * amount
	if bridge.inventory.getItemCount(src, 'event_token') < totalPrice then
		bridge.notifications.notify(src, { description = locale('Shop.NotEnoughTokens'), type = 'error', duration = 5000 })
		return
	end

	if not bridge.inventory.canCarryItem(src, itemName, amount) then
		bridge.notifications.notify(src, { description = locale('Shop.CannotCarry'), type = 'error', duration = 5000 })
		return
	end

	if not bridge.inventory.removeItem(src, 'event_token', totalPrice) then
		bridge.notifications.notify(src, { description = locale('Shop.NotEnoughTokens'), type = 'error', duration = 5000 })
		return
	end

	if not bridge.inventory.addItem(src, itemName, amount) then
		bridge.inventory.addItem(src, 'event_token', totalPrice)
		bridge.notifications.notify(src, { description = locale('Shop.CannotCarry'), type = 'error', duration = 5000 })
		return
	end
end)
