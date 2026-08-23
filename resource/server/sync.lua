function BuildSpookyInitPayload(src)
	return {
		pumpkins = GetPumpkinClientList(src),
		graves = GetGraveClientList(src),
		ghostHunts = GetGhostHuntClientList(src),
		trickOrTreat = GetTrickOrTreatClientList(src),
	}
end

AddEventHandler('Newb_Bridge:server:playerLoad', function(src)
	TriggerClientEvent('MrNewbsSpookySeason:Client:Initialize', src, BuildSpookyInitPayload(src))
end)

lib.callback.register('MrNewbsSpookySeason:Callback:SyncClient', function(src)
	local ped = GetPlayerPed(src)
	if ped == 0 or not DoesEntityExist(ped) then return {} end
	return BuildSpookyInitPayload(src)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end
	exports[bridge.name]:VersionCheck('MrNewb/patchnotes', resourceName)
end)
