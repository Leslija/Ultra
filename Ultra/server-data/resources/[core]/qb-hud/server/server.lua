local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('dinheiro', 'Ver dinheiro em mão', {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local cashamount = Player.PlayerData.money.cash
 --   TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
    TriggerClientEvent('QBCore:Notify', source, "Dinheiro em mão: "..cashamount.."€" , 'primary', 1500)
end)


function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- Stress

local ResetStress = false

RegisterServerEvent("qb-hud:Server:UpdateStress")
AddEventHandler('qb-hud:Server:UpdateStress', function(StressGain)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + StressGain
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
	end
end)

RegisterServerEvent('qb-hud:Server:GainStress')
AddEventHandler('qb-hud:Server:GainStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent('QBCore:Notify', src, 'A ficar stressado', 'error', 1500)
	end
end)

RegisterServerEvent('qb-hud:Server:RelieveStress')
AddEventHandler('qb-hud:Server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end

if newStress > 70 then 
	     TriggerClientEvent("hud:client:shake", src)
	end 

        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:UpdateStress", src, newStress)
        TriggerClientEvent('QBCore:Notify', src, 'Estás a relaxar')
	end
end)

-- Seatbelt

RegisterServerEvent('seatbelt:server:PlaySound')
AddEventHandler('seatbelt:server:PlaySound', function(action, passengers)
    pass = json.decode(passengers)
    if Config.playSoundForPassengers then
        for _, ped in ipairs(pass) do
            local vol = (source == ped and Config.volume or Config.passengerVolume)
            TriggerClientEvent('seatbelt:client:PlaySound', ped, action, vol)
        end
    end
end)