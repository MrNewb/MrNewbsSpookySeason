---@param enabled boolean
function OpenSpookyToggleWeatherSync(enabled)
	enabled = enabled == true

	if GetResourceState('qb-weathersync') == 'started' then
		if enabled then
			TriggerEvent('qb-weathersync:client:EnableSync')
		else
			TriggerEvent('qb-weathersync:client:DisableSync')
		end
		return
	end
	if GetResourceState('cd_easytime') == 'started' then
		TriggerEvent('cd_easytime:PauseSync', not enabled)
		return
	end

	if GetResourceState('Renewed-Weathersync') == 'started' then
		LocalPlayer.state.syncWeather = enabled
		return
	end
end
