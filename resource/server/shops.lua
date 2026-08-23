RegisterNetEvent('MrNewbsSpookySeason:Server:Shop:PurchaseItem', function(shopId, itemName, amount)
	local src = source
	if type(shopId) ~= 'string' or type(itemName) ~= 'string' or itemName == '' then return end

	amount = tonumber(amount)
	if not amount then return end
	amount = math.floor(amount)
	if amount <= 0 then
		bridge.notifications.notify(src, { description = locale('Shop.InvalidAmount'), type = 'error', duration = 5000 })
		return
	end

	local shop = Config.Shops[shopId]
	if not shop or not shop.inventory then
		bridge.notifications.notify(src, { description = locale('Shop.InvalidShop'), type = 'error', duration = 5000 })
		return
	end

	local priceEach = shop.inventory[itemName]
	if not priceEach then
		bridge.notifications.notify(src, { description = locale('Shop.ItemNotForSale'), type = 'error', duration = 5000 })
		return
	end

	if not IsSpookyPlayerNear(src, shop.position, 5.0) then return end

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

	bridge.inventory.addItem(src, itemName, amount)
end)
