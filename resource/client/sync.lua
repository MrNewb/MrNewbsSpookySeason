local syncReceived = false

local function removeAllSpookySeason()
	RemoveSpookyDecorations()
	RemoveSpookyShops()
	RemoveSpookyPumpkins()
	RemoveSpookyGraves()
	RemoveSpookyGhostHunts()
	RemoveSpookyTrickOrTreat()
end

local function applyInit(payload)
	removeAllSpookySeason()
	RegisterSpookyDecorations()
	RegisterSpookyShops()
	if type(payload) ~= 'table' then return end
	RegisterSpookyPumpkins(payload.pumpkins)
	RegisterSpookyGraves(payload.graves)
	RegisterSpookyGhostHunts(payload.ghostHunts)
	RegisterSpookyTrickOrTreat(payload.trickOrTreat)
end

RegisterNetEvent('MrNewbsSpookySeason:Client:Initialize', function(payload)
	if source ~= 65535 then return end
	syncReceived = true
	applyInit(payload)
end)

AddEventHandler('Newb_Bridge:client:playerLoad', function()
	syncReceived = false
	removeAllSpookySeason()
end)

AddEventHandler('Newb_Bridge:client:playerUnload', function()
	syncReceived = false
	removeAllSpookySeason()
end)

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end
	removeAllSpookySeason()
end)

CreateThread(function()
	Wait(2500)
	if syncReceived then return end
	local payload = lib.callback.await('MrNewbsSpookySeason:Callback:SyncClient', false)
	if not payload or syncReceived then return end
	syncReceived = true
	applyInit(payload)
end)
