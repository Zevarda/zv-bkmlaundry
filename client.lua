local function addTargetToEntity(entity)
    local options = {
        {
            icon = 'fas fa-money-bill-wave',
            label = 'Launder Dirty Money',
            name = 'launder_money',
            onSelect = function()
                local input = lib.inputDialog('Convert Black Money', {
                    { type = 'number', label = 'Amount (min 10,000)', min = Config.MinAmount }
                })

                if not input or not input[1] then return end
                local amount = math.floor(tonumber(input[1]))

                if amount < Config.MinAmount then
                    lib.notify({type = 'error', description = 'Minimum is 10,000!'})
                    return
                end

                if Config.MaxAmount and amount > Config.MaxAmount then
                    lib.notify({type = 'error', description = 'Maximum is ' .. Config.MaxAmount})
                    return
                end

                local duration = math.floor((amount / 10000) * Config.BaseRate)

                RequestAnimDict(Config.Anim.dict)
                while not HasAnimDictLoaded(Config.Anim.dict) do Wait(0) end

                lib.progressBar({
                    duration = duration,
                    label = 'Laundering Money...',
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        car = true,
                        move = true,
                        combat = true,
                    },
                    anim = {
                        dict = Config.Anim.dict,
                        clip = Config.Anim.clip,
                    }
                })

                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('moneylaunder:convert', amount)
            end
        }
    }

    if GetResourceState('ox_target') == 'started' then
        exports.ox_target:addLocalEntity(entity, options)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AddTargetEntity(entity, {
            options = options,
            distance = Config.TargetDistance
        })
    else
        print('[MoneyLaunder] No supported target system found.')
    end
end

CreateThread(function()
    local model = joaat(Config.LaunderLocation.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local coords = Config.LaunderLocation.coords
    local entity

    if Config.UsePed then
        entity = CreatePed(0, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
        FreezeEntityPosition(entity, true)
        SetEntityInvincible(entity, true)
        SetBlockingOfNonTemporaryEvents(entity, true)
    else
        entity = CreateObject(model, coords.x, coords.y, coords.z - 1.0, false, false, false)
        SetEntityHeading(entity, coords.w)
        FreezeEntityPosition(entity, true)
    end

    addTargetToEntity(entity)
end)
