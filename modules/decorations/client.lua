---@diagnostic disable: duplicate-set-field
decorationObj = {}
DecorationClass = {}
DecorationClass.__index = DecorationClass

local function registerEnt(self)
    Bridge.Entity.Create({
        id = self.id,
        entityType = self.entityType,
        model = self.model,
        coords = self.position,
        heading = self.position.w,
        spawnDistance = 100,
    })
end

function DecorationClass:new(id, position, model, entityType)
    local obj = {
        id = id,
        position = position,
        model = model,
        entityType = entityType,
    }
    setmetatable(obj, self)
    decorationObj[id] = obj
    registerEnt(obj)
    return obj
end

function DecorationClass:destroy()
    Bridge.Entity.Destroy(self.id)
    decorationObj[self.id] = nil
end

function BuildDecorationObjects()
    for k, decor in pairs(Config.Decorations) do
        local id = Bridge.Ids.Random(decorationObj, 10)
        DecorationClass:new(id, decor.position, decor.model, decor.entityType)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    BuildDecorationObjects()
    SharedData = SharedData or {}
    SharedData.Decorations = decorationObj or {}
end)

AddEventHandler('MrNewbsSpookySeason:Client:InitialData', function(data)
    if source ~= 65535 then return end
    if not Config.Decorations then return end
    for _, decoration in pairs(Config.Decorations) do
        local id = Bridge.Ids.Random(decorationObj, 10)
        DecorationClass:new(id, decoration.position, decoration.model, decoration.entityType)
    end
end)

local function destroyAll()
    for k, v in pairs(decorationObj) do
        v:destroy()
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    destroyAll()
end)

AddEventHandler("community_bridge:Client:OnPlayerUnload", function()
    destroyAll()
end)