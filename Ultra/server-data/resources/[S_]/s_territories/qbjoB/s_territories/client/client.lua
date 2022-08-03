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

local PlayerData                = {}
local venda = false
local claimPos, closestTerritory, halfwayAlert, captureBlip = nil, nil, false, nil
ESX = nil

if Config.Framework == 'ESX' then
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config.getSharedObject, function (obj) ESX = obj end)
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
        CreateMapBlips()
        PlayerData = xPlayer
    end)
    
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)

    RegisterNetEvent('esx:onPlayerLogout')
    AddEventHandler('esx:onPlayerLogout', function()
        ESX.PlayerLoaded = false
        ESX.PlayerData = {}
        if (claimPos ~= nil) then CaptureFailed(true) end
    end)

    AddEventHandler('esx:onPlayerDeath', function(data)
        if (claimPos ~= nil) then CaptureFailed(true) end
    end)
    
elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
    local PlayerData = QBCore.Functions.GetPlayerData()

    PlayerJob = {}

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job
            if PlayerData.job.onduty then
                for k, v in pairs(Config.JobsAbleToControl) do if v == PlayerJob.name then havejob = true end end
                if havejob then TriggerServerEvent("QBCore:ToggleDuty") end end
        end)
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate') AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
    RegisterNetEvent('QBCore:Client:SetDuty') AddEventHandler('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

    AddEventHandler('onResourceStart', function(resource)
        if GetCurrentResourceName() == resource then
            QBCore.Functions.GetPlayerData(function(PlayerData)
                PlayerJob = PlayerData.job
                for k, v in pairs(Config.JobsAbleToControl) do if v == PlayerJob.name then havejob = true end end
                if havejob then onDuty = PlayerJob.onduty end end) 
        end
        Wait(500)
    end)

end

AddEventHandler('onResourceStart', function(resourceName)
    CreateMapBlips()
end)


--- ###### THREADS ----- ###########
Citizen.CreateThread(function()
    local objLoopSleep = 1
    while true do
        Citizen.Wait(objLoopSleep * 1000)
        local closestDistance = 100
        if (claimPos == nil) then
            for k, v in pairs(Config.Territories) do
                if (v.control ~= nil) then
                    local distance = #(GetEntityCoords(PlayerPedId()) - v.control.location)
                    if (distance < closestDistance) then 
                        closestDistance = distance 
                        closestTerritory = k
                    end
                end
            end
        else
            closestDistance = #(GetEntityCoords(PlayerPedId()) - Config.Territories[closestTerritory].control.location)
            if (closestDistance > 30) or IsEntityDead(PlayerPedId()) then
                CaptureFailed()
            else
                claimPos.duration = claimPos.duration - (objLoopSleep * 1000)
                CaptureSuccessfulCheck()
            end
        end
    end
end)

if not Config.Target  then
    Citizen.CreateThread(function()
        while true do
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local ped = PlayerPedId()

            local inRange = false

            for k, v in pairs(Config.Territories) do
                local dist = GetDistanceBetweenCoords(pos, v.control.location, true)
                if dist < 10 then
                    if dist < 3 then
                        DrawText3Ds(v.control.location.x, v.control.location.y, v.control.location.z + 0.00, '[E] - '..v.label)
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent("s_territories:client:menusemtarget")
                        end
                    end
                inRange = true
                end
            end
    
            if not inRange then
                Citizen.Wait(2000)
            end
    
            Citizen.Wait(3)
        end
    end)
end

if Config.IncreaseValueStash  then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(Config.IncreaseTime*60000)
            TriggerServerEvent("s_territories:server:increasestash")    
        end
    end)
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Territories) do
        local caixa = CreateObject(Config.Prop,v.control.location.x, v.control.location.y, v.control.location.z - 1.00,false,false,false) 
        FreezeEntityPosition(caixa, true)
    end

    if Config.Target then
        local options = {{ event = 's_territories:client:openstash', icon = 'fas fa-box', label = Translations['stash'], territory = closestTerritory }}
        table.insert(options, { event = 's_territories:client:comecarcontrolo', icon = 'fas fa-map-marker-alt', label = Translations['control'], territory = closestTerritory })
        if Config.SellDrugsTerritories then
        table.insert(options, { event = 's_territories:client:venderdroga', icon = 'fas fa-cannabis', label = Translations['selldrugs'], territory = closestTerritory })
        end
        exports[Config.TargetType]:AddTargetModel({Config.Prop}, {
            options = options,
            distance = 4.0
        })
    end
end)

--#### MENU SEM TARGET ###
AddEventHandler('s_territories:client:menusemtarget', function(data)
    if Config.Framework == 'ESX' then
        if closestTerritory ~= nil then 
            local name = closestTerritory
            local item = Config.Territories[name].selldrug.item
            local itemlabel = Config.Territories[name].selldrug.label
            local quantity = Config.Territories[name].selldrug.quantity
            local price = Config.Territories[name].selldrug.price
            local finalprice = price*quantity

            if Config.SellDrugsTerritories then
                local semtargetMenu = {
                    { id = 1, header = Config.Territories[name].label},
                    { id = 2, header = Translations['control'], txt = Translations['control_text'], params = { event = "s_territories:client:comecarcontrolo", isServer = false,  args = {territory = closestTerritory} } },
                    { id = 3, header = Translations['stash'], txt = Translations['open_stash'],params = { event = "s_territories:client:openstash", isServer = false,  args = {territory = closestTerritory} } },
                    { id = 4, header = Translations['sell']..' '..itemlabel, txt = Translations['sell']..' '..quantity..'x '..itemlabel..' '..Translations['for']..' '..finalprice..'€',params = { event = "s_territories:server:venderdroga2", isServer = true,  args = {data = closestTerritory} } }
                }
                exports[Config.MenuExport]:openMenu(semtargetMenu)
            else
                local semtargetMenu = {
                    { id = 1, header = Config.Territories[name].label},
                    { id = 2, header = Translations['control'], txt = Translations['control_text'], params = { event = "s_territories:client:comecarcontrolo", isServer = false,  args = {territory = closestTerritory} } },
                    { id = 3, header = Translations['stash'], txt = Translations['open_stash'],params = { event = "s_territories:client:openstash", isServer = false,  args = {territory = closestTerritory} } }
                }
                exports[Config.MenuExport]:openMenu(semtargetMenu)
            end
        else
        end
    elseif Config.Framework == 'QBCore' then
        if closestTerritory ~= nil then 
            local name = closestTerritory
            local item = Config.Territories[name].selldrug.item
            local itemlabel = Config.Territories[name].selldrug.label
            local quantity = Config.Territories[name].selldrug.quantity
            local price = Config.Territories[name].selldrug.price
            local finalprice = price*quantity

            if Config.SellDrugsTerritories then
                local semtargetMenu = {
                    { header = Config.Territories[name].label,  isMenuHeader = true},
                    { header = Translations['control'], txt = Translations['control_text'], params = { event = "s_territories:client:comecarcontrolo", isServer = false,  args = {territory = closestTerritory} } },
                    { header = Translations['stash'], txt = Translations['open_stash'],params = { event = "s_territories:client:openstash", isServer = false,  args = {territory = closestTerritory} } },
                    { header = Translations['sell']..' '..itemlabel, txt = Translations['sell']..' '..quantity..'x '..itemlabel..' '..Translations['for']..' '..finalprice..'€',params = { event = "s_territories:server:venderdroga2qb", isServer = true,  args = {data = closestTerritory} } }
                }
                exports[Config.MenuExport]:openMenu(semtargetMenu)
            else
                local semtargetMenu = {
                    { header = Config.Territories[name].label, isMenuHeader = true},
                    { header = Translations['control'], txt = Translations['control_text'], params = { event = "s_territories:client:comecarcontrolo", isServer = false,  args = {territory = closestTerritory} } },
                    { header = Translations['stash'], txt = Translations['open_stash'],params = { event = "s_territories:client:openstash", isServer = false,  args = {territory = closestTerritory} } }
                }
                exports[Config.MenuExport]:openMenu(semtargetMenu)
            end
        else
        end
    end
end)

--#### CONTROLAR AREA ####

RegisterNetEvent('s_territories:client:comecarcontrolo')
AddEventHandler('s_territories:client:comecarcontrolo', function(data)
    if (not IsPedArmed(PlayerPedId(), 4)) then
        ShowNotification(Translations['no_weapon'], "error")
        return
    end
    halfwayAlert = false
    if not jobChecks() then return end
    if Config.Framework == 'ESX' then 
        TriggerServerEvent('s_territories:server:comecarcontrolo', closestTerritory)
    elseif Config.Framework == 'QBCore' then
        local job = PlayerJob.name
        TriggerServerEvent('s_territories:server:comecarcontroloqb', closestTerritory, job)
    end   
end)

RegisterNetEvent('s_territories:client:capturar')
AddEventHandler('s_territories:client:capturar', function(data)
    local territoryCfg = Config.Territories[closestTerritory]
    local captureDuration = territoryCfg.control.controlTime * 60000
    claimPos = {
        zone = territoryCfg,
        duration = captureDuration,
        name = closestTerritory
    }
    ShowNotification(Translations['start_atempt']..': '..territoryCfg.label..', '..Translations['time_needed']..': '..math.ceil(captureDuration / 60000)..' '..Translations['minutes'], "inform")
    captureBlip = AddBlipForRadius(territoryCfg.control.location, 30.0)
    SetBlipColour(captureBlip, 1)
    GlobalBlipAlert(territoryCfg)
end)

function CaptureFailed(force)
    if (claimPos.duration > 0 or force) then
        ShowNotification(Translations['control_failed'], "error")
            if Config.Framework == 'ESX' then
                TriggerServerEvent('s_territories:server:controlofalhado', closestTerritory)
            elseif Config.Framework == 'QBCore' then
                TriggerServerEvent('s_territories:server:controlofalhadoqb', closestTerritory)
            end
        Cleanup()
    else
        CaptureSuccessfulCheck()
    end
end

function CaptureSuccessfulCheck()
    if (claimPos.duration <= 0) then
        ShowNotification(Translations['control_success'], "success")
        if Config.Framework == 'ESX' then
            TriggerServerEvent('s_territories:server:updateowner', claimPos.name)
        elseif Config.Framework == 'QBCore' then
            local job = PlayerJob.name
            TriggerServerEvent('s_territories:server:updateownerqb', claimPos.name, job)
        end
        Cleanup()
    end
end


--#### INICIO COFRE ####

AddEventHandler('s_territories:client:openstash', function(data)
    if Config.Framework == 'ESX' then
        TriggerServerEvent('s_territories:server:openstash', closestTerritory)
    elseif Config.Framework == 'QBCore' then
        local job = PlayerJob.name
        TriggerServerEvent('s_territories:server:openstashqb', closestTerritory, job)
    end
end)

--ESX
RegisterNetEvent('s_territories:client:cofreautorizado')
AddEventHandler('s_territories:client:cofreautorizado', function(data)
    local amount = data.amount
    local keyboard = exports[Config.MenuKeyboard]:DialogInput({
    header = "Saldo: "..amount.."€", 
    rows = {
        {
            id = 0, 
            txt = ""
        }
    }
    })
    if keyboard ~= nil then
    local amount2 = tonumber(keyboard[1].input)
        if amount2 and amount2 > 0 and amount2 <= amount then
            local data = {retirado = amount2, final = amount-amount2, name = data.name}
            TriggerServerEvent("s_territories:server:stashreward", data)
        else
            ShowNotification(Translations['invalid_amount'], "error")
        end
    end       
end)
--QBCORE
RegisterNetEvent('s_territories:client:cofreautorizadoqb')
AddEventHandler('s_territories:client:cofreautorizadoqb', function(data)
    local amount = data.amount
    local keyboard = exports['qb-input']:ShowInput({
        header = Translations['balance']..amount,
        submitText = Translations["Amount"],
        inputs = {
            {
                text = Translations['balance']..amount, -- text you want to be displayed as a place holder
                name = "removestash", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = 1, -- Default number option, this is optional
            }
        },
    })
        local amount2 = tonumber(keyboard.removestash)
        if amount2 and amount2 > 0 and amount2 <= amount then
            local data = {retirado = amount2, final = amount-amount2, name = data.name}
            local job = PlayerJob.name
            TriggerServerEvent("s_territories:server:stashrewardqb", data, job)
        else
            ShowNotification(Translations['invalid_amount'], "error")
        end
end)

--#### INICIO VENDA ####

AddEventHandler('s_territories:client:venderdroga', function(data)
    local name = closestTerritory
    local item = Config.Territories[name].selldrug.item
    local itemlabel = Config.Territories[name].selldrug.label
    local quantity = Config.Territories[name].selldrug.quantity
    local price = Config.Territories[name].selldrug.price
    local finalprice = price*quantity
    if Config.Framework == 'ESX' then
        local sellMenu = {
            { id = 1, header = Translations['sell']..' '..itemlabel,},
            { id = 2, header = Translations['sell']..' '..quantity..'x '..itemlabel..' '..Translations['for']..' '..finalprice..'€', params = { event = "s_territories:server:venderdroga2", isServer = true,  args = {data = closestTerritory} } }}
        exports[Config.MenuExport]:openMenu(sellMenu)
    elseif Config.Framework == 'QBCore' then
        local sellMenu = {
            { header = Translations['sell']..' '..itemlabel, isMenuHeader = true},
            { header = Translations['sell']..' '..quantity..'x '..itemlabel..' '..Translations['for']..' '..finalprice..'€', params = { event = "s_territories:server:venderdroga2qb", isServer = true,  args = {data = closestTerritory} } }}
        exports[Config.MenuExport]:openMenu(sellMenu)
    end
end)

RegisterNetEvent("s_territories:client:venderdrogaprocesso")
AddEventHandler("s_territories:client:venderdrogaprocesso", function(name)
    local data = name
    print(data)
    if venda == false then
        venda = true
        exports['progressbar']:Progress({
            name = "processoccaina",
            duration = Config.TimeSell*1000,
            label = Translations['selling'],
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
                venda = false
                if Config.Framework == 'ESX' then
                    TriggerServerEvent("s_territories:server:sellingreward", data)
                elseif Config.Framework == 'QBCore' then
                    TriggerServerEvent("s_territories:server:sellingrewardqb", data)
                end
            else
                venda = false
                ShowNotification(Translations['canceled'], 'error')
            end
        end)
    end
end)


--##### SETUP

RegisterCommand(Config.CommandGetZoneName, function()
    local zoneName = GetNameOfZone(GetEntityCoords(PlayerPedId()))
    TriggerEvent('chat:addMessage', {
        color = {0, 248, 185},
        multiline = true,
        args = {Translations['server_name'], Translations['territory'] .. zoneName}
    })
end)


RegisterNetEvent("safky:client:shownotification")
AddEventHandler("safky:client:shownotification", function(data)
    ShowNotification(data.msg, data.type)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        Cleanup()
	end
end)

--###### FUNÇÕES 

function jobChecks()
    if Config.Framework == 'ESX' then
        local canDo = true
        local check1 = true
        local check2 = true
        if Config.RequiredJob == true then check2 = false
            for k, v in pairs(Config.JobsAbleToControl) do
                if v == PlayerData.job.name then check2 = true end
            end
            if check2 == false then ShowNotification(Translations['permissions'], 'error') check2 = false end
        end
        if check1 == false or check2 == false then canDo = false end
        return canDo
    elseif Config.Framework == 'QBCore' then
        local check = true
        if Config.RequiredJob == true then check = false
            for k, v in pairs(Config.JobsAbleToControl) do
                if v == PlayerJob.name then check = true end
            end
            if check == false then ShowNotification(Translations['permissions'], 'error') check = false end
        end
        return check
    end
end

function GlobalBlipAlert(territoryCfg)
    if not Config.BlipsAlert.enabled then return end
    local blip = AddBlipForRadius(territoryCfg.control.location, 70.0)

    SetBlipSprite(blip, Config.BlipsAlert.sprite)
    SetBlipDisplay(blip, Config.BlipsAlert.display)
    SetBlipColour(blip, Config.BlipsAlert.colour)
    SetBlipAlpha(blip, Config.BlipsAlert.alpha)
    SetBlipAsShortRange(blip, true)
    SetBlipFlashes(blip, Config.BlipsAlert.flashes)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Translations['territory']..territoryCfg.label)
    EndTextCommandSetBlipName(blip)

    Citizen.Wait(60000)
    RemoveBlip(blip)
end

function CreateMapBlips()
    if not Config.Blips.enabled then return end
    Citizen.CreateThread(function()
        for k, v in pairs(Config.Territories) do
            local blip = AddBlipForCoord(v.control.location)

            SetBlipSprite(blip, Config.Blips.sprite)
            SetBlipDisplay(blip, Config.Blips.display)
            SetBlipScale(blip, Config.Blips.scale)
            SetBlipColour(blip, Config.Blips.colour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Translations['territory']..v.label)
            EndTextCommandSetBlipName(blip)
        end
    end)
end

function Cleanup()
    claimPos = nil
    closestTerritory = nil
    halfwayAlert = false
    if (captureBlip ~= nil) then
        RemoveBlip(captureBlip)
        captureBlip = nil
    end
end

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