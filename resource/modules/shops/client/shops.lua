local shopBlips = {}
local shopParticles = {}

local function setHalloweenWeather()
	if not Config.WeatherFeature then return end
	OpenSpookyToggleWeatherSync(false)
	SetWeatherTypeNowPersist('HALLOWEEN')
	SetWeatherTypePersist('HALLOWEEN')
	SetOverrideWeather('HALLOWEEN')
end

local function restoreWeather()
	if not Config.WeatherFeature then return end
	ClearOverrideWeather()
	ClearWeatherTypePersist()
	OpenSpookyToggleWeatherSync(true)
end

local function buyShopItem(shopId, itemName, price, label)
	local tokenCount = bridge.inventory.getItemCount('event_token')
	if tokenCount < price then return bridge.notifications.notify({ description = locale('Shop.NotEnoughTokens'), type = 'error', duration = 5000 }) end

	local input = bridge.inputs.inputdialog(label, {
		{ type = 'slider', label = locale('Shop.InputPurchaseAmount'), min = 1, max = math.min(100, math.floor(tokenCount / price)), step = 1 },
	})
	if not input or not input[1] then return end

	local amount = tonumber(input[1])
	if not amount or amount <= 0 or amount > 100 then return bridge.notifications.notify({ description = locale('Shop.InvalidAmount'), type = 'error', duration = 5000 }) end

	TriggerServerEvent('MrNewbsSpookySeason:server:purchasedShopItem', shopId, itemName, amount)
end

local function openBuyMenu(shopId, inventory)
	local options = {
		{
			title = locale('Shop.BuyTitle'),
			description = locale('Shop.BuyDescription'),
			icon = locale('Shop.ShopIcon'),
		},
	}

	for itemName, price in pairs(inventory) do
		local itemInfo = bridge.inventory.getItemInfo(itemName)
		local label = itemInfo and itemInfo.label or itemName
		options[#options + 1] = {
			title = locale('Shop.PurchaseTitle', label, price),
			icon = (itemInfo and itemInfo.image) or 'fa-solid fa-box',
			onSelect = function()
				buyShopItem(shopId, itemName, price, label)
			end,
		}
	end

	bridge.menu.openMenu({
		id = 'MrNewbsSpookySeason:shop:buy',
		title = locale('Shop.ShopSubMenuDescription'),
		options = options,
	})
end

local function openShopMenu(shopId, inventory)
	bridge.menu.openMenu({
		id = 'MrNewbsSpookySeason:shop',
		title = locale('Shop.Title'),
		options = {
			{
				title = locale('Shop.ShopTitle'),
				description = locale('Shop.ShopDescription'),
				icon = locale('Shop.ShopIcon'),
			},
			{
				title = locale('Shop.BuyItems'),
				description = locale('Shop.BuyItemsDescription'),
				icon = locale('Shop.BuyItemsIcon'),
				onSelect = function()
					openBuyMenu(shopId, inventory)
				end,
			},
		},
	})
end

function RegisterSpookyShops()
	for shopId, shop in pairs(Config.Shops) do
		local blip = AddBlipForCoord(shop.position.x, shop.position.y, shop.position.z)
		SetBlipSprite(blip, 781)
		SetBlipColour(blip, 2)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		SetBlipDisplay(blip, 4)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(locale('Shop.BlipLabel'))
		EndTextCommandSetBlipName(blip)
		shopBlips[shopId] = blip

		exports[bridge.name]:AddInteraction(('MrNewbsSpookySeason:shop:%s'):format(shopId), {
			model = shop.model,
			coords = vector3(shop.position.x, shop.position.y, shop.position.z),
			heading = shop.position.w,
			radius = 150.0,
			options = {
				{
					label = locale('Target.ShopLabel'),
					icon = locale('Target.ShopIcon'),
					distance = 5.0,
					onSelect = function()
						openShopMenu(shopId, shop.inventory)
					end,
				},
			},
			onEnter = function()
				setHalloweenWeather()
			end,
			onSpawn = function(interaction)
				SetEntityInvincible(interaction.entity, true)
				lib.requestNamedPtfxAsset('core')
				UseParticleFxAssetNextCall('core')
				shopParticles[shopId] = StartParticleFxLoopedOnEntity('ent_amb_snow_mist_base', interaction.entity, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 3.5, false, false, false)
			end,
			onDespawn = function()
				if shopParticles[shopId] then
					StopParticleFxLooped(shopParticles[shopId], false)
					shopParticles[shopId] = nil
				end
				restoreWeather()
			end,
		})
	end
end

function RemoveSpookyShops()
	restoreWeather()
	for shopId, blip in pairs(shopBlips) do
		if DoesBlipExist(blip) then RemoveBlip(blip) end
		shopBlips[shopId] = nil
		if shopParticles[shopId] then
			StopParticleFxLooped(shopParticles[shopId], false)
			shopParticles[shopId] = nil
		end
		exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:shop:%s'):format(shopId))
	end
end
