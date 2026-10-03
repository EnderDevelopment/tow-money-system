local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('towMoneySystem:stopTowing', function(source, cb, distance)
    local xPlayer = ESX.GetPlayerFromId(source)
    local earnings = math.floor(Config.TowPrice * Config.TowMultiplier * distance)

    if xPlayer then
        xPlayer.addAccountMoney('bank', earnings)
        MySQL.Async.execute('INSERT INTO tow_jobs (player_id, vehicle_model, distance_traveled, earnings) VALUES (@player_id, @vehicle_model, @distance_traveled, @earnings)', {
            ['@player_id'] = xPlayer.identifier,
            ['@vehicle_model'] = GetDisplayNameFromVehicleModel(GetEntityModel(towVehicle)),
            ['@distance_traveled'] = distance,
            ['@earnings'] = earnings
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('towMoneySystem:stopTowing', source, earnings)
                cb(true)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)