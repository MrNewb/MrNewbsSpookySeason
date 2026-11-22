function BuildSpookyInitPayload(src)
	return {
		pumpkins = GetPumpkinClientList(src),
		graves = GetGraveClientList(src),
		ghostHunts = GetGhostHuntClientList(src),
		trickOrTreat = GetTrickOrTreatClientList(src),
	}
end

AddEventHandler('Newb_Bridge:server:playerLoaded', function(src)
	TriggerClientEvent('MrNewbsSpookySeason:client:initialized', src, BuildSpookyInitPayload(src))
end)

lib.callback.register('MrNewbsSpookySeason:Callback:SyncClient', function(src)
	local ped = GetPlayerPed(src)
	if ped == 0 or not DoesEntityExist(ped) then return {} end
	return BuildSpookyInitPayload(src)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if cache.resource ~= resourceName then return end
	exports[bridge.name]:VersionCheck('MrNewb/patchnotes', resourceName)
end)
