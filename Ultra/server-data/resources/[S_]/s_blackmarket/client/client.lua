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

local configurated = false


if not Config.Target  then
    Citizen.CreateThread(function()
        while true do
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local ped = PlayerPedId()

            local inRange = false

            for k, v in pairs(Config.Location) do
                local dist = GetDistanceBetweenCoords(pos, Config.Location.coords, true)
                if dist < 10 then
                    if dist < 3 then
                        DrawText3Ds(Config.Location.coords.x, Config.Location.coords.y, Config.Location.coords.z + 0.00, '[E] - TESTE')
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerEvent("s_blackmarket:OpenMarket")
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

Citizen.CreateThread(function()
    if Config.Target then
        local options = {{ event = 's_blackmarket:OpenMarket', icon = 'fas fa-box', label = "Black Market"}}
        exports[Config.TargetType]:AddTargetModel({Config.Location.model}, {
            options = options,
            distance = 4.0
        })
    end
end)

RegisterNetEvent("s_blackmarket:OpenMarket")
AddEventHandler("s_blackmarket:OpenMarket", function()
    if not configurated then
        SetConfig()
        configurated = true
    end

    SendNUIMessage({
        open = true,
    })

    SetNuiFocus(true, true)
end)

RegisterNetEvent("s_blackmarket:LoadedProducts", function(products, total_solds)
    SendNUIMessage({
        load_products = true,
        products = products,
        total_solds = total_solds,
    })
end)

RegisterNetEvent("s_blackmarket:LoadedInventory", function(products)
    SendNUIMessage({
        load_inventory = true,
        products = products
    })
end)

RegisterNetEvent("s_blackmarket:LoadedSolds", function(products, total_solds)
    SendNUIMessage({
        load_solds = true,
        products = products,
        total_solds = total_solds,
    })
end)

RegisterNetEvent("s_blackmarket:LoadedMyAds", function(products)
    SendNUIMessage({
        load_ads = true,
        products = products
    })
end)

RegisterNetEvent("s_blackmarket:FinishedTransaction", function()
    SendNUIMessage({
        finish_transaction = true
    })
end)

RegisterNetEvent("s_blackmarket:Error", function(message)
    SendNUIMessage({
        error = true,
        error_text = message,
    })
end)

RegisterNUICallback("LoadProducts", function(data, cb)
    TriggerServerEvent("s_blackmarket:LoadProducts")
    cb('ok')
end)

RegisterNUICallback("LoadInventory", function(data, cb)
    TriggerServerEvent("s_blackmarket:LoadInventory")
    cb('ok')
end)

RegisterNUICallback("LoadSolds", function(data, cb)
    TriggerServerEvent("s_blackmarket:LoadSolds")
    cb('ok')
end)

RegisterNUICallback("LoadMyAds", function(data, cb)
    TriggerServerEvent("s_blackmarket:LoadMyAds")
    cb('ok')
end)

RegisterNUICallback("SellProduct", function(data, cb)
    TriggerServerEvent("s_blackmarket:SellProduct", data)
    cb('ok')
end)

RegisterNUICallback("BuyProduct", function(data, cb)
    TriggerServerEvent("s_blackmarket:BuyProduct", data)
    cb('ok')
end)

RegisterNUICallback("ReceiveItem", function(data, cb)
    TriggerServerEvent("s_blackmarket:ReceiveItem", data)
    cb('ok')
end)

RegisterNUICallback("RemoveItem", function(data, cb)
    TriggerServerEvent("s_blackmarket:RemoveItem", data)
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
	cb('ok')
end)

--------------- NPC

local one_time = false
local ped = 0

AddEventHandler('playerSpawned', function()
    SetConfig()
end)

CreateThread(function()
    while not DoesEntityExist(GetPlayerPed(-1)) do Wait(1000) end
    Wait(1000)
	SetConfig()
end)


function SetConfig()
    SendNUIMessage({
        config = true,
        translate = translate,
        application_fee = Config.Fee,
        sell_fee = Config.SellFee,
        name_resource = GetCurrentResourceName()
    })

    if  ped == 0 and not one_time then
		one_time = true
        RequestModel(GetHashKey(Config.Location.model))
        while not HasModelLoaded(GetHashKey(Config.Location.model)) do
            Wait(1)
        end
        
        ped = CreatePed(7, Config.Location.model, Config.Location.coords.x, Config.Location.coords.y, Config.Location.coords.z, Config.Location.heading, false, false)
        SetEntityCoordsNoOffset(ped,  Config.Location.coords.x, Config.Location.coords.y, Config.Location.coords.z)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
        Wait(500)

        Anim()

        if Config.Blip.enabled then
            local blip = AddBlipForCoord(Config.Location.coords.x, Config.Location.coords.y, Config.Location.coords.z)
            SetBlipSprite(blip, Config.Blip.sprite)
            SetBlipDisplay(blip, Config.Blip.display)
            SetBlipScale(blip, Config.Blip.scale)
            SetBlipColour(blip, Config.Blip.colour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blip.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end

function Anim()
    while not HasAnimDictLoaded('amb@world_human_hang_out_street@male_c@idle_a') do
        RequestAnimDict('amb@world_human_hang_out_street@male_c@idle_a')
        Wait(10)
    end

    TaskPlayAnim(ped, 'amb@world_human_hang_out_street@male_c@idle_a', 'idle_b', 2.0, 2.0, -1, 51, 0, false, false, false)
    RemoveAnimDict('amb@world_human_hang_out_street@male_c@idle_a')

end

function StopAnim()
    ClearPedTasks(ped)
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