local ESX = nil
local isTowing = false
local towVehicle = nil
local towBlip = nil
local startLocation = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsControlJustReleased(0, 38) and vehicle ~= 0 then
            local vehicleModel = GetEntityModel(vehicle)
            local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)

            if isTowing then
                if towVehicle == vehicle then
                    isTowing = false
                    towVehicle = nil
                    startLocation = nil
                    RemoveBlip(towBlip)
                    towBlip = nil
                    ESX.ShowNotification('Towing stopped.')
                end
            else
                if isVehicleTowable(vehicleName) then
                    isTowing = true
                    towVehicle = vehicle
                    startLocation = GetEntityCoords(playerPed)
                    towBlip = AddBlipForEntity(vehicle)
                    SetBlipSprite(towBlip, 1)
                    SetBlipColour(towBlip, 5)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString('Towed Vehicle')
                    EndTextCommandSetBlipName(towBlip)
                    ESX.ShowNotification('Towing started.')
                else
                    ESX.ShowNotification('This vehicle cannot be towed.')
                end
            end
        end

        if isTowing and towVehicle ~= nil then
            local currentLocation = GetEntityCoords(playerPed)
            local distance = #(currentLocation - startLocation)
            local earnings = calculateEarnings(distance)

            ESX.ShowHelpNotification('Distance: ~g~' .. math.floor(distance) .. 'm~s~ | Earnings: ~g~$' .. earnings .. '~s~')
        end
    end
end)

function isVehicleTowable(vehicleName)
    for _, towableVehicle in ipairs(Config.TowableVehicles) do
        if string.lower(towableVehicle) == string.lower(vehicleName) then
            return true
        end
    end
    return false
end

function calculateEarnings(distance)
    return math.floor(Config.TowPrice * Config.TowMultiplier * distance)
end

RegisterNetEvent('towMoneySystem:stopTowing')
AddEventHandler('towMoneySystem:stopTowing', function(earnings)
    isTowing = false
    towVehicle = nil
    startLocation = nil
    RemoveBlip(towBlip)
    towBlip = nil
    ESX.ShowNotification('Towing completed. You earned: ~g~$' .. earnings .. '~s~')
end)