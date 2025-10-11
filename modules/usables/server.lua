---@diagnostic disable: duplicate-set-field
local usableObj = {}
UsableItemClass = {}
UsableItemClass.__index = UsableItemClass

function UsableItemClass:new(id, lootPool, animation)
    local obj = {
        id = id,
        lootPool = lootPool,
        animation = animation,
    }
    setmetatable(obj, self)
    usableObj[id] = obj
    obj:register()
    return obj
end

function UsableItemClass:getRandomItem()
    local pool = Config.LootTypes[self.lootPool]
    return pool[math.random(1, #pool)]
end

function UsableItemClass:register()
    Bridge.Framework.RegisterUsableItem(self.id, function(src, itemData)
        if not src then return print("No Self") end
        TriggerClientEvent("MrNewbsSpookySeason:Client:UsableItems:UseItem", src, self.id)
        Bridge.Inventory.RemoveItem(src, self.id, 1, itemData.slot, nil)
        Wait(5000)
        local selectedItem = self:getRandomItem()
        if selectedItem.rewardType == "cash" then
            Bridge.Framework.AddAccountBalance(src, "cash", selectedItem.count)
        elseif selectedItem.rewardType == "item" then
            Bridge.Inventory.AddItem(src, selectedItem.name, selectedItem.count or 1, nil, selectedItem.metadata or {})
        end
    end)
end

function RegisterUsableItems()
    for k, v in pairs(Config.UsableItems) do
        UsableItemClass:new(k, v.lootPool, v.animation)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    RegisterUsableItems()
end)