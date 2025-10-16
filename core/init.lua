Bridge = exports.community_bridge:Bridge()
SharedData = {}

function locale(message, ...)
    return Bridge.Language.Locale(message, ...)
end

if IsDuplicityVersion() then
    Bridge.Callback.Register('MrNewbsSpookySeason:Callback:GetInitialData', function(src)
        local _src = src
        return SharedData
    end)

else
    RegisterNetEvent("community_bridge:Client:OnPlayerUnload")

    RegisterNetEvent('community_bridge:Client:OnPlayerLoaded', function()
        SharedData = Bridge.Callback.Trigger('MrNewbsSpookySeason:Callback:GetInitialData')
        --print("All Shared Data " .. json.encode(SharedData, { indent = true }))
    end)
end
