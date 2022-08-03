Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Drugs = {
    ['Peds'] = {},
}

local PlayerData                = {}
-- APANHA 
local ApanhaAtiva = false
-- PROCESSOS
local processometa = false
local processoerva = false
local processococaina = false
-- CORTES
local cortar = false
local venda = false
-- LAVAGEM
local lavagem = false

ESX = nil

if Config.Framework == 'ESX' then
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(100)
    end
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(2000)
    isLoggedIn = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
    local PlayerData = QBCore.Functions.GetPlayerData()

    PlayerJob = {}

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job
            if PlayerData.job.onduty then
                for k, v in pairs(Config.WashJobRoles) do if v == PlayerJob.name then havejob = true end end
                if havejob then TriggerServerEvent("QBCore:ToggleDuty") end end
        end)
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate') AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
    RegisterNetEvent('QBCore:Client:SetDuty') AddEventHandler('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

    AddEventHandler('onResourceStart', function(resource)
        if GetCurrentResourceName() == resource then
            QBCore.Functions.GetPlayerData(function(PlayerData)
                PlayerJob = PlayerData.job
                for k, v in pairs(Config.WashJobRoles) do if v == PlayerJob.name then havejob = true end end
                if havejob then onDuty = PlayerJob.onduty end end) 
        end
        Wait(500)
    end)

end

local previousSkinData = {}

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do

            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local ped = PlayerPedId()

            local inRange = false

            -- APANHAS

            for k, v in pairs(Config['Drugs']['cocaine']) do
                local dist = GetDistanceBetweenCoords(pos, v['coords'], true)
                if dist < 10 then
                    if dist < 3 then
                        DrawText3Ds(v['coords'].x, v['coords'].y, v['coords'].z + 0.00, Translations['catchcocaine'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            if  ApanhaAtiva == false then
                                ApanhaCocaina()
                                ApanhaAtiva = true 
                            end
                        end
                    end
                inRange = true
                end
            end

            for k, v in pairs(Config['Drugs']['weed']) do
                local dist = GetDistanceBetweenCoords(pos, v['coords'], true)
                if dist < 10 then
                    if dist < 3 then
                        DrawText3Ds(v['coords'].x, v['coords'].y, v['coords'].z + 0.00, Translations['catchweed'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            if  ApanhaAtiva == false then
                                ApanhaErva()
                                ApanhaAtiva = true 
                            end
                        end
                    end
                inRange = true
                end
            end

            for k, v in pairs(Config['Drugs']['meth']) do
                local dist = GetDistanceBetweenCoords(pos, v['coords'], true)
                if dist < 10 then
                    if dist < 3 then
                        DrawText3Ds(v['coords'].x, v['coords'].y, v['coords'].z + 0.00, Translations['catchmeth'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            if  ApanhaAtiva == false then
                                ApanhaMeta()
                                ApanhaAtiva = true 
                            end
                        end
                    end
                inRange = true
                end
            end

            -- PROCESSOS SEM TARGET

            if not Config.Target then
                local dist = GetDistanceBetweenCoords(pos, Config['Drugs']['processcocaine'], true)
                if dist < 10 then
                    if dist < 3 then
                        DrawText3Ds(Config['Drugs']['processcocaine'].x, Config['Drugs']['processcocaine'].y, Config['Drugs']['processcocaine'].z + 0.00, Translations['processcocaine'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent('nxt_drugs:client:processococa', source)
                        end
                    end
                inRange = true
                end
                local dist2 = GetDistanceBetweenCoords(pos, Config['Drugs']['processweed'], true)
                if dist2 < 10 then
                    if dist2 < 3 then
                        DrawText3Ds(Config['Drugs']['processweed'].x, Config['Drugs']['processweed'].y, Config['Drugs']['processweed'].z + 0.00, Translations['processweed'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent('nxt_drugs:client:processoerva', source)
                        end
                    end
                inRange = true
                end
                local dist3 = GetDistanceBetweenCoords(pos, Config['Drugs']['processmeth'], true)
                if dist3 < 10 then
                    if dist3 < 3 then
                        DrawText3Ds(Config['Drugs']['processmeth'].x, Config['Drugs']['processmeth'].y, Config['Drugs']['processmeth'].z + 0.00, Translations['processmeth'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent('nxt_drugs:client:processometa', source)
                        end
                    end
                inRange = true
                end
                local dist4 = GetDistanceBetweenCoords(pos, Config['Drugs']['selldrugs'], true)
                if dist4 < 10 then
                    if dist4 < 3 then
                        DrawText3Ds(Config['Drugs']['selldrugs'].x, Config['Drugs']['selldrugs'].y, Config['Drugs']['selldrugs'].z + 0.00, Translations['selldrugs'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent('nxt_drugs:client:vendadrogas', source)
                        end
                    end
                inRange = true
                end
                if Config.WashMoneyAtive then
                local dist4 = GetDistanceBetweenCoords(pos, Config['WashMoney']['ped'].coords, true)
                if dist4 < 10 then
                    if dist4 < 3 then
                        DrawText3Ds(Config['WashMoney']['ped'].coords.x, Config['WashMoney']['ped'].coords.y, Config['WashMoney']['ped'].coords.z + 1.00, Translations['washmoney'])
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent('nxt_drugs:client:lavardinheiro', source)
                        end
                    end
                inRange = true
                end
                end
            end

            if not inRange then
                Citizen.Wait(2000)
            end

        Citizen.Wait(3)
    end
end)

-- APANHAS

function ApanhaCocaina()
    Citizen.CreateThread(function()
        if ApanhaAtiva == true then
        local ped = PlayerPedId()
        RequestAnimDict("amb@prop_human_bum_bin@idle_a")
        
        Citizen.Wait(100)
        FreezeEntityPosition(ped, true)
        TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
        exports['progressbar']:Progress({
            name = "unique_action_name",
            duration = 10000,
            label = Translations['pcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("nxt_core:server:apanhacocaina")
                local ped = PlayerPedId()
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                ApanhaAtiva = false
            else
            end
        end) 
    end
    end)
end

function ApanhaMeta()
    Citizen.CreateThread(function()
        if ApanhaAtiva == true then
        local ped = PlayerPedId()
        RequestAnimDict("amb@prop_human_bum_bin@idle_a")
        
        Citizen.Wait(100)
        FreezeEntityPosition(ped, true)
        TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
        exports['progressbar']:Progress({
            name = "unique_action_name",
            duration = 10000,
            label = Translations['pmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("nxt_core:server:apanhameta")
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                ApanhaAtiva = false
            else
            end
        end) 
    end
    end)
end

function ApanhaErva()
    Citizen.CreateThread(function()
        if ApanhaAtiva == true then
        local ped = PlayerPedId()
        RequestAnimDict("amb@prop_human_bum_bin@idle_a")
        
        Citizen.Wait(100)
        FreezeEntityPosition(ped, true)
        TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
        exports['progressbar']:Progress({
            name = "unique_action_name",
            duration = 10000,
            label = Translations['pweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("nxt_core:server:apanhaerva")
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                ApanhaAtiva = false
            else
            end
        end) 
    end
    end)
end

if Config.Framework == 'ESX' then
-- ########### PROCESSOS ###########

-- COCAINA
RegisterNetEvent('nxt_drugs:client:processococa', function()
    TriggerEvent('s_menu:sendMenu', {
        {
            id = 1,
            header = Translations['headerprocesscocaine'],
        },
        {
            id = 2,
            header = Config['Drugs']['cocainevalues']['processneeded'].."x 🌿",
            txt = Translations['textprocesscocaine'],
            params = {
                event = "nxt_drugs:client:processarcocaina",
                isServer = false,
            }
        }
    })
end)

RegisterNetEvent("nxt_drugs:client:processarcocaina")
AddEventHandler("nxt_drugs:client:processarcocaina", function(data)
if processococaina == false then
ESX.TriggerServerCallback('nxt_drugs:server:procesooncacoca', function(HasItems)
    if HasItems then
        processococaina = true
        exports['progressbar']:Progress({
            name = "processoccaina",
            duration = 10000,
            label = Translations['ppcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
                flags = 8,
				task = nil,
            },
        }, function(cancelled)
            if not cancelled then
                processococaina = false
                TriggerServerEvent("nxt_drugs:server:finalizarcoca")
            else
                processococaina = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

-- META

RegisterNetEvent('nxt_drugs:client:processometa', function()
    TriggerEvent('s_menu:sendMenu', {
        {
            id = 1,
            header = Translations['headerprocessmeth'],
        },
        {
            id = 2,
            header = Config['Drugs']['methvalues']['processneeded'].."x 🧪",
            txt = Translations['textprocessmeth'],
            params = {
                event = "nxt_drugs:client:processarmeta",
                isServer = false,
            }
        }
    })
end)

RegisterNetEvent("nxt_drugs:client:processarmeta")
AddEventHandler("nxt_drugs:client:processarmeta", function(data)
if processometa == false then
ESX.TriggerServerCallback('nxt_drugs:server:procesooncameta', function(HasItems)
    if HasItems then
        processometa = true
        exports['progressbar']:Progress({
            name = "processometa",
            duration = 10000,
            label = Translations['ppmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
                flags = 8,
				task = nil,
            },
        }, function(cancelled)
            if not cancelled then
                processometa = false
                TriggerServerEvent("nxt_drugs:server:finalizarmeta")
            else
                processometa = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

-- ERVA

RegisterNetEvent('nxt_drugs:client:processoerva', function()
    TriggerEvent('s_menu:sendMenu', {
        {
            id = 1,
            header = Translations['headerprocessweed'],
        },
        {
            id = 2,
            header = Config['Drugs']['weedvalues']['processneeded'].."x 🌿",
            txt = Translations['textprocessweed'],
            params = {
                event = "nxt_drugs:client:processarerva",
                isServer = false,
            }
        }
    })
end)

RegisterNetEvent("nxt_drugs:client:processarerva")
AddEventHandler("nxt_drugs:client:processarerva", function(data)
if processoerva == false then
ESX.TriggerServerCallback('nxt_drugs:server:procesooncaerva', function(HasItems)
    if HasItems then
        processoerva = true
        exports['progressbar']:Progress({
            name = "processoerva",
            duration = 10000,
            label = Translations['ppweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
                flags = 8,
				task = nil,
            },
        }, function(cancelled)
            if not cancelled then
                processoerva = false
                TriggerServerEvent("nxt_drugs:server:finalizarerva")
            else
                processoerva = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

-- FIM PROCESSOS ------

-- INICIO CORTE---

RegisterNetEvent('nxt_drugs:client:cortarmeta', function()
    TriggerEvent('s_menu:sendMenu', {
        {
            id = 1,
            header = Translations['cutmenu'],
            txt = "",
        },
        {
            id = 2,
            header = Translations['headercutcocaine'],
            txt = Config['Drugs']['cocainevalues']['cutneeded'].."x "..Translations['processedcocaine'].."</p>"..Config['Drugs']['bagsneeded'].."x "..Translations['empty_bags'].."</p> 1x "..Translations['drug_scale'],
            params = {
                event = "nxt_drugs:client:eventocheckcocaine",
                isServer = false,
                args = 1
            }
        },
        {
            id = 3,
            header = Translations['headercutweed'],
            txt = Config['Drugs']['weedvalues']['cutneeded'].."x "..Translations['processedweed'].."</p>"..Config['Drugs']['bagsneeded'].."x "..Translations['empty_bags'].."</p> 1x "..Translations['drug_scale'],
            params = {
                event = "nxt_drugs:client:eventocheckweed",
                isServer = false,
                args = 1
            }
        },
        {
            id = 4,
            header = Translations['headercutmeth'],
            txt = Config['Drugs']['methvalues']['cutneeded'].."x "..Translations['processedmeth'].."</p>"..Config['Drugs']['bagsneeded'].."x "..Translations['empty_bags'].."</p> 1x "..Translations['drug_scale'],
            params = {
                event = "nxt_drugs:client:eventocheckmeth",
                isServer = false,
                args = 1
            }
        },
    })
end)

RegisterNetEvent("nxt_drugs:client:eventocheckcocaine")
AddEventHandler("nxt_drugs:client:eventocheckcocaine", function(data)
if cortar == false then
ESX.TriggerServerCallback('nxt_drugs:server:cortarcocaina', function(HasItems)
    if HasItems then
        cortar = true
        exports['progressbar']:Progress({
            name = "processometa",
            duration = 10000,
            label = Translations['ppcutcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_parking_meter@female@base",
			    anim = "base_female",
            },
        }, function(cancelled)
            if not cancelled then
                cortar = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:cortarmeta")
            else
                cortar = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:eventocheckweed")
AddEventHandler("nxt_drugs:client:eventocheckweed", function(data)
if cortar == false then
ESX.TriggerServerCallback('nxt_drugs:server:cortarerva', function(HasItems)
    if HasItems then
        cortar = true
        exports['progressbar']:Progress({
            name = "processoerva",
            duration = 10000,
            label = Translations['ppcutweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_parking_meter@female@base",
			    anim = "base_female",
            },
        }, function(cancelled)
            if not cancelled then
                cortar = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:cortarmeta")
            else
                cortar = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:eventocheckmeth")
AddEventHandler("nxt_drugs:client:eventocheckmeth", function(data)
if cortar == false then
ESX.TriggerServerCallback('nxt_drugs:server:cortarmeta', function(HasItems)
    if HasItems then
        cortar = true
        exports['progressbar']:Progress({
            name = "processoerva",
            duration = 10000,
            label = Translations['ppcutmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_parking_meter@female@base",
			    anim = "base_female",
            },
        }, function(cancelled)
            if not cancelled then
                cortar = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:cortarmeta")
            else
                cortar = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

--- ############# VENDAAAAA ########### 

-- COCAINA VENDA

RegisterNetEvent('nxt_drugs:client:vendadrogas', function()
    if not jobChecksSelling() then return end
    TriggerEvent('s_menu:sendMenu', {
        {
            id = 1,
            header = Translations['selldrugsmenu'],
            txt = "",
        },
        {
            id = 2,
            header = Translations['headersellcocaine'],
            txt = Config['Drugs']['cocainevalues']['sellquantity'].."x = "..Config['Drugs']['cocainevalues']['sellquantity']*Config['Drugs']['cocainevalues']['price1g'].."€",
            params = {
                event = "nxt_drugs:client:vendercocaina",
                isServer = false,
                args = 1
            }
        },
        {
            id = 3,
            header = Translations['headersellweed'],
            txt = Config['Drugs']['weedvalues']['sellquantity'].."x = "..Config['Drugs']['weedvalues']['sellquantity']*Config['Drugs']['weedvalues']['price1g'].."€",
            params = {
                event = "nxt_drugs:client:vendererva",
                isServer = false,
                args = 1
            }
        },
        {
            id = 4,
            header = Translations['headersellmeth'],
            txt = Config['Drugs']['methvalues']['sellquantity'].."x = "..Config['Drugs']['methvalues']['sellquantity']*Config['Drugs']['methvalues']['price1g'].."€",
            params = {
                event = "nxt_drugs:client:vendermeta",
                isServer = false,
                args = 1
            }
        }
    })
end)

RegisterNetEvent("nxt_drugs:client:vendercocaina")
AddEventHandler("nxt_drugs:client:vendercocaina", function(data)
if venda == false then
ESX.TriggerServerCallback('nxt_drugs:server:checarcoca', function(HasItems)
    if HasItems then
        venda = true
        exports['progressbar']:Progress({
            name = "venderdrogassss",
            duration = 10000,
            label = Translations['sellcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                venda = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:vendadrogas")
            else
                venda = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:vendererva")
AddEventHandler("nxt_drugs:client:vendererva", function(data)
if venda == false then
ESX.TriggerServerCallback('nxt_drugs:server:checarerva', function(HasItems)
    if HasItems then
        venda = true
        exports['progressbar']:Progress({
            name = "venderdrogassss",
            duration = 10000,
            label = Translations['sellweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                venda = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:vendadrogas")
            else
                venda = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:vendermeta")
AddEventHandler("nxt_drugs:client:vendermeta", function(data)
if venda == false then
ESX.TriggerServerCallback('nxt_drugs:server:checarvmeta', function(HasItems)
    if HasItems then
        venda = true
        exports['progressbar']:Progress({
            name = "venderdrogassss",
            duration = 10000,
            label = Translations['sellmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                venda = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:vendadrogas")
            else
                venda = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)


--- LAVAGEM DE DINHEIRO

RegisterNetEvent('nxt_drugs:client:lavardinheiro', function()
    if not jobChecks() then return end
    TriggerEvent('s_menu:sendMenu', {
        {
            id = 1,
            header = Translations['headerwashmoney'],
            txt = Config['WashMoney']['amount'].."€",
            params = {
                event = "nxt_drugs:client:lavardinerito",
                isServer = false,
                args = 1
            }
        }
    })
end)

RegisterNetEvent("nxt_drugs:client:lavardinerito")
AddEventHandler("nxt_drugs:client:lavardinerito", function(data)
if lavagem == false then
ESX.TriggerServerCallback('nxt_drugs:server:checarsujo', function(HasItems)
    if HasItems then
        lavagem = true
        exports['progressbar']:Progress({
            name = "lavagenzita",
            duration = Config['WashMoney']['time']*1000,
            label = Translations['washingmoney'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                lavagem = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:client:lavardinheiro")
            else
                lavagem = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

elseif Config.Framework == 'QBCore' then

    -- ########### PROCESSOS ###########

-- COCAINA
RegisterNetEvent('nxt_drugs:client:processococa', function()
    exports['qb-menu']:openMenu({
        {
            header = Translations['headerprocesscocaine'],
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = Config['Drugs']['cocainevalues']['processneeded'].."x 🌿",
            txt = Translations['textprocesscocaine'],
            params = {
                event = "nxt_drugs:client:processarcocaina",
            }
        },
    })
end)

RegisterNetEvent("nxt_drugs:client:processarcocaina")
AddEventHandler("nxt_drugs:client:processarcocaina", function(data)
if processococaina == false then
    QBCore.Functions.TriggerCallback('nxt_drugs:server:procesooncacoca', function(HasItems)
    if HasItems then
        processococaina = true
        exports['progressbar']:Progress({
            name = "processoccaina",
            duration = 10000,
            label = Translations['ppcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
                flags = 8,
				task = nil,
            },
        }, function(cancelled)
            if not cancelled then
                processococaina = false
                TriggerServerEvent("nxt_drugs:server:finalizarcocaina")
            else
                processococaina = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

-- META

RegisterNetEvent('nxt_drugs:client:processometa', function()
    exports['qb-menu']:openMenu({
        {
            header = Translations['headerprocessmeth'],
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = Config['Drugs']['methvalues']['processneeded'].."x 🧪",
            txt = Translations['textprocessmeth'],
            params = {
                event = "nxt_drugs:client:processarmeta",
            }
        },
    })
end)

RegisterNetEvent("nxt_drugs:client:processarmeta")
AddEventHandler("nxt_drugs:client:processarmeta", function(data)
if processometa == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:procesooncameta', function(HasItems)
    if HasItems then
        processometa = true
        exports['progressbar']:Progress({
            name = "processometa",
            duration = 10000,
            label = Translations['ppmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
                flags = 8,
				task = nil,
            },
        }, function(cancelled)
            if not cancelled then
                processometa = false
                TriggerServerEvent("nxt_drugs:server:finalizarmeta")
            else
                processometa = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)


-- ERVA
RegisterNetEvent('nxt_drugs:client:processoerva', function()
    exports['qb-menu']:openMenu({
        {
            header = Translations['headerprocessweed'],
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = Config['Drugs']['weedvalues']['processneeded'].."x 🌿",
            txt = Translations['textprocessweed'],
            params = {
                event = "nxt_drugs:client:processarerva",
            }
        },
    })
end)


RegisterNetEvent("nxt_drugs:client:processarerva")
AddEventHandler("nxt_drugs:client:processarerva", function(data)
if processoerva == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:procesooncaerva', function(HasItems)
    if HasItems then
        processoerva = true
        exports['progressbar']:Progress({
            name = "processoerva",
            duration = 10000,
            label = Translations['ppweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
                flags = 8,
				task = nil,
            },
        }, function(cancelled)
            if not cancelled then
                processoerva = false
                TriggerServerEvent("nxt_drugs:server:finalizarerva")
            else
                processoerva = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

-- FIM PROCESSOS ------

-- INICIO CORTE---
RegisterNetEvent('nxt_drugs:client:cortarmeta', function()
    exports['qb-menu']:openMenu({
        {
            header = Translations['cutmenu'],
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = Translations['headercutcocaine'],
            txt = Config['Drugs']['cocainevalues']['cutneeded'].."x "..Translations['processedcocaine'].."</p>"..Config['Drugs']['bagsneeded'].."x "..Translations['empty_bags'].."</p> 1x "..Translations['drug_scale'],
            params = {
                event = "nxt_drugs:client:eventocheckcocaine",
            }
        },
        {
            header = Translations['headercutweed'],
            txt = Config['Drugs']['weedvalues']['cutneeded'].."x "..Translations['processedweed'].."</p>"..Config['Drugs']['bagsneeded'].."x "..Translations['empty_bags'].."</p> 1x "..Translations['drug_scale'],
            params = {
                event = "nxt_drugs:client:eventocheckweed",
            }
        },
        {
            header = Translations['headercutmeth'],
            txt = Config['Drugs']['methvalues']['cutneeded'].."x "..Translations['processedmeth'].."</p>"..Config['Drugs']['bagsneeded'].."x "..Translations['empty_bags'].."</p> 1x "..Translations['drug_scale'],
            params = {
                event = "nxt_drugs:client:eventocheckmeth",
            }
        },
    })
end)


RegisterNetEvent("nxt_drugs:client:eventocheckcocaine")
AddEventHandler("nxt_drugs:client:eventocheckcocaine", function(data)
if cortar == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:cortarcocaina', function(HasItems)
    if HasItems then
        cortar = true
        exports['progressbar']:Progress({
            name = "processometa",
            duration = 10000,
            label = Translations['ppcutcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_parking_meter@female@base",
			    anim = "base_female",
            },
        }, function(cancelled)
            if not cancelled then
                cortar = false
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("nxt_drugs:server:finalizarcocaina2")
            else
                cortar = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:eventocheckweed")
AddEventHandler("nxt_drugs:client:eventocheckweed", function(data)
if cortar == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:cortarerva', function(HasItems)
    if HasItems then
        cortar = true
        exports['progressbar']:Progress({
            name = "processoerva",
            duration = 10000,
            label = Translations['ppcutweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_parking_meter@female@base",
			    anim = "base_female",
            },
        }, function(cancelled)
            if not cancelled then
                cortar = false
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("nxt_drugs:server:finalizarerva2")
            else
                cortar = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:eventocheckmeth")
AddEventHandler("nxt_drugs:client:eventocheckmeth", function(data)
if cortar == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:cortarmeta', function(HasItems)
    if HasItems then
        cortar = true
        exports['progressbar']:Progress({
            name = "processoerva",
            duration = 10000,
            label = Translations['ppcutmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_parking_meter@female@base",
			    anim = "base_female",
            },
        }, function(cancelled)
            if not cancelled then
                cortar = false
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("nxt_drugs:server:finalizarmeta2")
            else
                cortar = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

--- ############# VENDAAAAA ########### 

-- COCAINA VENDA

RegisterNetEvent('nxt_drugs:client:vendadrogas', function()
    if not jobChecksSelling() then return end
    exports['qb-menu']:openMenu({
        {
            header = Translations['selldrugsmenu'],
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = Translations['headersellcocaine'],
            txt = Config['Drugs']['cocainevalues']['sellquantity'].."x = "..Config['Drugs']['cocainevalues']['sellquantity']*Config['Drugs']['cocainevalues']['price1g'].."€",
            params = {
                event = "nxt_drugs:client:vendercocaina",
            }
        },
        {
            header = Translations['headersellweed'],
            txt = Config['Drugs']['weedvalues']['sellquantity'].."x = "..Config['Drugs']['weedvalues']['sellquantity']*Config['Drugs']['weedvalues']['price1g'].."€",
            params = {
                event = "nxt_drugs:client:vendererva",
            }
        },
        {
            header = Translations['headersellmeth'],
            txt = Config['Drugs']['methvalues']['sellquantity'].."x = "..Config['Drugs']['methvalues']['sellquantity']*Config['Drugs']['methvalues']['price1g'].."€",
            params = {
                event = "nxt_drugs:client:vendermeta",
            }
        }
    })
end)

RegisterNetEvent("nxt_drugs:client:vendercocaina")
AddEventHandler("nxt_drugs:client:vendercocaina", function(data)
if venda == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:checarcoca', function(HasItems)
    if HasItems then
        venda = true
        exports['progressbar']:Progress({
            name = "venderdrogassss",
            duration = 10000,
            label = Translations['sellcocaine'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                venda = false
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("nxt_drugs:server:vendercocafinalll")
            else
                venda = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:vendererva")
AddEventHandler("nxt_drugs:client:vendererva", function(data)
if venda == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:checarerva', function(HasItems)
    if HasItems then
        venda = true
        exports['progressbar']:Progress({
            name = "venderdrogassss",
            duration = 10000,
            label = Translations['sellweed'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                venda = false
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("nxt_drugs:server:venderervafinalll")
            else
                venda = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)

RegisterNetEvent("nxt_drugs:client:vendermeta")
AddEventHandler("nxt_drugs:client:vendermeta", function(data)
if venda == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:checarvmeta', function(HasItems)
    if HasItems then
        venda = true
        exports['progressbar']:Progress({
            name = "venderdrogassss",
            duration = 10000,
            label = Translations['sellmeth'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                venda = false
                ClearPedTasks(PlayerPedId())
                TriggerEvent("nxt_drugs:server:vendermetafinalll")
            else
                venda = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)


--- LAVAGEM DE DINHEIRO
RegisterNetEvent('nxt_drugs:client:lavardinheiro', function()
    if not jobChecksQB() then return end
    exports['qb-menu']:openMenu({
        {
            header = Translations['headerwashmoney'],
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = Config['WashMoney']['amount'].."€",
            txt = Translations['washmoney2'],
            params = {
                event = "nxt_drugs:client:lavardinerito",
            }
        }
    })
end)


RegisterNetEvent("nxt_drugs:client:lavardinerito")
AddEventHandler("nxt_drugs:client:lavardinerito", function(data)
if lavagem == false then
QBCore.Functions.TriggerCallback('nxt_drugs:server:checarsujo', function(HasItems)
    if HasItems then
        lavagem = true
        exports['progressbar']:Progress({
            name = "lavagenzita",
            duration = Config['WashMoney']['time']*1000,
            label = Translations['washingmoney'],
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_common",
			    anim = "givetake1_a",
            },
        }, function(cancelled)
            if not cancelled then
                lavagem = false
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent("nxt_drugs:server:lavagemfinalll")
            else
                lavagem = false
                ClearPedTasks(PlayerPedId())
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    else
        ShowNotification(Translations['donthave'], 'error')
    end
end)
end
end)
end

-- ESX
function jobChecks()
	local canDo = true
	local check1 = true
	local check2 = true
	if Config.WashRequiredJob == true then check2 = false
		for k, v in pairs(Config.WashJobRoles) do
			if v == PlayerData.job.name then check2 = true end
		end
		if check2 == false then ShowNotification(Translations['permissions'], 'error') check2 = false end
	end
	if check1 == false or check2 == false then canDo = false end
	return canDo
end

function jobChecksSelling()
	local canDo = true
	local check1 = true
	local check2 = true
	if Config.SellRequiredJob == true then check2 = false
		for k, v in pairs(Config.SellJobRoles) do
			if v == PlayerData.job.name then check2 = true end
		end
		if check2 == false then ShowNotification(Translations['permissions'], 'error') check2 = false end
	end
	if check1 == false or check2 == false then canDo = false end
	return canDo
end

-- QBCORE

function jobChecksQB()
	local check = true
	if Config.WashRequiredJob == true then check = false
		for k, v in pairs(Config.WashJobRoles) do
			if v == PlayerJob.name then check = true end
		end
		if check == false then ShowNotification(Translations['permissions'], 'error') check = false end
	end
	return check
end


function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end
-- SPAWNA NPCS E TARGET SE ATIVO
Citizen.CreateThread(function()
    for k, v in pairs(Config['Drugs']['Peds']) do
        loadModel(v['model'])
        Drugs['Peds'][k] = CreatePed(4, GetHashKey(v['model']), v['coords'], v['heading'], false, true)
        FreezeEntityPosition(Drugs['Peds'][k], true)
        SetEntityInvincible(Drugs['Peds'][k], true)
        SetBlockingOfNonTemporaryEvents(Drugs['Peds'][k], true)
    end

    if Config.WashMoneyAtive then
        loadModel(Config['WashMoney']['ped'].model)
        pedlavagem = CreatePed(4, GetHashKey(Config['WashMoney']['ped'].model), Config['WashMoney']['ped'].coords, Config['WashMoney']['ped'].heading, false,true)  
        FreezeEntityPosition(pedlavagem, true)
        SetEntityInvincible(pedlavagem, true)
        SetBlockingOfNonTemporaryEvents(pedlavagem, true)
    end

    for k, v in pairs(Config['Drugs']['cocaine']) do
        local cocaplanta = CreateObject('prop_plant_01a',v['coords'].x, v['coords'].y, v['coords'].z - 1.00,false,false,false) 
        FreezeEntityPosition(cocaplanta, true)
    end
    for k, v in pairs(Config['Drugs']['weed']) do
        local ervaplanta = CreateObject('prop_weed_01',v['coords'].x, v['coords'].y, v['coords'].z - 1.00,false,false,false)  
        FreezeEntityPosition(ervaplanta, true)
    end
    for k, v in pairs(Config['Drugs']['meth']) do
        local barrilmeta = CreateObject('prop_barrel_exp_01a',v['coords'].x, v['coords'].y, v['coords'].z - 1.00,false,false,false)  
        FreezeEntityPosition(barrilmeta, true)
    end


    if Config.Target then
        exports[Config.TargetType]:AddTargetModel(Config['Drugs']['PedsModels']['ProcessCocaine'], {
            options = {
                {
                    event = "nxt_drugs:client:processococa",
                    icon = "fab fa-drupal",
                    label = Translations['processcocainelabel'],
                },
            },
            distance = 1.5,
        })
        exports[Config.TargetType]:AddTargetModel(Config['Drugs']['PedsModels']['ProcessWeed'], {
            options = {
                {
                    event = "nxt_drugs:client:processoerva",
                    icon = "fab fa-drupal",
                    label = Translations['processweedlabel'],
                },
            },
            distance = 1.5,
        })
        exports[Config.TargetType]:AddTargetModel(Config['Drugs']['PedsModels']['ProcessMeth'], {
            options = {
                {
                    event = "nxt_drugs:client:processometa",
                    icon = "fab fa-drupal",
                    label = Translations['processmethlabel'],
                },
            },
            distance = 1.5,
        })
        exports[Config.TargetType]:AddTargetModel(Config['Drugs']['PedsModels']['SellDrug'], {
            options = {
                {
                    event = "nxt_drugs:client:vendadrogas",
                    icon = "fab fa-drupal",
                    label = Translations['selldrugslabel'],
                },
            },
            distance = 1.5,
        })
        if Config.WashMoneyAtive then
            exports[Config.TargetType]:AddTargetModel(Config['WashMoney']['ped'].model, {
                options = {
                    {
                        event = "nxt_drugs:client:lavardinheiro",
                        icon = "fab fa-drupal",
                        label = Translations['washmoneylabel'],
                    },
                },
                distance = 1.5,
            })
        end
    end
end)

