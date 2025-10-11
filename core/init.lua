Bridge = exports.community_bridge:Bridge()

function locale(message, ...)
    return Bridge.Language.Locale(message, ...)
end

if IsDuplicityVersion() then

    SharedData = SharedData or {}

    RegisterNetEvent('community_bridge:Server:OnPlayerLoaded', function(src)
        local _src = src
        TriggerClientEvent('MrNewbsSpookySeason:Client:InitialData', _src, SharedData)
    end)

    -- CreateThread(function()
    --     Wait(5000)
    --     TriggerClientEvent('MrNewbsSpookySeason:Client:InitialData', -1, SharedData)
    -- end)
else
    RegisterNetEvent("community_bridge:Client:OnPlayerUnload", function()
    end)

    RegisterNetEvent('MrNewbsSpookySeason:Client:InitialData', function(data)
    end)
end