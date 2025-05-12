local isQBCore = GetResourceState('qb-core') == 'started'
local isESX = GetResourceState('es_extended') == 'started'

if not isQBCore and not isESX then
    error("Framework not found!")
end

local function RemoveBlackMoney(source, amount)
    if Config.Inventory == 'ox' then
        exports.ox_inventory:RemoveItem(source, 'black_money', amount)
    elseif Config.Inventory == 'qb' then
        local Player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(source)
        Player.Functions.RemoveItem('black_money', amount)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:RemoveItem(source, 'black_money', amount)
    end
end

local function AddCleanMoney(source, amount)
    if Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(source, 'money', amount)
    elseif Config.Inventory == 'qb' then
        local Player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(source)
        Player.Functions.AddItem('money', amount)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(source, 'money', amount)
    end
end

local function GetBlackMoneyCount(source)
    if Config.Inventory == 'ox' then
        local item = exports.ox_inventory:GetItem(source, 'black_money', false)
        return item and item.count or 0
    elseif Config.Inventory == 'qb' then
        local Player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(source)
        local item = Player.Functions.GetItemByName('black_money')
        return item and item.amount or 0
    elseif Config.Inventory == 'qs' then
        return exports['qs-inventory']:GetItemCount(source, 'black_money')
    end
    return 0
end

RegisterServerEvent('moneylaunder:convert', function(amount)
    local src = source
    if not tonumber(amount) then return end
    amount = math.floor(tonumber(amount))

    if amount < Config.MinAmount or (Config.MaxAmount and amount > Config.MaxAmount) then return end

    local hasMoney = GetBlackMoneyCount(src)
    if hasMoney < amount then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = 'Not enough black money.'
        })
        return
    end

    RemoveBlackMoney(src, amount)

    Wait(math.floor((amount / 10000) * Config.BaseRate))

    AddCleanMoney(src, amount)

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Laundering Complete',
        description = 'Your dirty money has been cleaned.',
        type = 'success'
    })
end)
