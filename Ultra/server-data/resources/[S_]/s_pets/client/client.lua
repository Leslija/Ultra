QBCore                             = nil
local pet, bowlObj, activePet,illness
local petHealth, petFood = 100, 300
local petMoving, stay, feeding, ballThrown, chasing, searching = false, false, false, false, false, false
local petSpeed = 8.0
local attacking = false
local petShopSpawned,vetSpawned = false, false
local petShopNPC, vet
local petName = 'Pet'

PlayerJob = {}

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(response)
    PlayerJob = response
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)


-- On player spawn, set relationship to all pets
AddEventHandler('playerSpawned', function()
    local Player = PlayerPedId()
    AddRelationshipGroup('OWNER')
    SetPedRelationshipGroupHash(Player,GetHashKey('OWNER'))
end)


-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            local spawnCoords = vector3(563.1297, 2741.196, 41.86084)
            local dst = #(spawnCoords - pedCoords)
            
            if dst < 100 and petShopSpawned == false then
                TriggerEvent('s_pets:spawnPed',spawnCoords,180.16)
                petShopSpawned = true
            end
            if dst >= 101  then
                petShopSpawned = false
                DeleteEntity(petShopNPC)
            end
    end
end)
-- Spawn NPC
RegisterNetEvent('s_pets:spawnPed')
AddEventHandler('s_pets:spawnPed',function(coords,heading)
    local hash = GetHashKey('a_f_y_soucent_03')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do 
        Wait(10)
    end

    petShopNPC = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(petShopNPC, true)
    SetEntityInvincible(petShopNPC, true)
    SetBlockingOfNonTemporaryEvents(petShopNPC, true)
    SetModelAsNoLongerNeeded(hash)
    exports['s_target']:AddEntityZone('petShopNPC', petShopNPC, {
            name="petShopNPC",
            debugPoly=false,
            useZ = true
                }, {
                options = {
                    {
                    event = "s_pets:petStore",
                    icon = "far fa-comment",
                    label = "Loja Animais",
                    },                                     
                },
                    job = {"all"},
                    distance = 2.5
                })  

end)


-- Spawn VET NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            local spawnCoords = vector3(561.2571, 2741.103, 41.86084)
            local dst = #(spawnCoords - pedCoords)
            
            if dst < 100 and vetSpawned == false then
                TriggerEvent('s_pets:spawnVet',spawnCoords,180.36)
                vetSpawned = true
            end
            if dst >= 101  then
                vetSpawned = false
                DeleteEntity(vet)
            end
    end
end)
-- Spawn NPC
RegisterNetEvent('s_pets:spawnVet')
AddEventHandler('s_pets:spawnVet',function(coords,heading)
    local hash = GetHashKey('s_f_y_sweatshop_01')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do 
        Wait(10)
    end

    vet = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(vet, true)
    SetEntityInvincible(vet, true)
    SetBlockingOfNonTemporaryEvents(vet, true)
    SetModelAsNoLongerNeeded(hash)
    exports['s_target']:AddEntityZone('vet', vet, {
            name="vet",
            debugPoly=false,
            useZ = true
                }, {
                options = {
                    {
                    event = "s_pets:healPet",
                    icon = "far fa-comment",
                    label = "Tratar Animal",
                    },                  
                    {
                    event = "s_pets:removePet",
                    icon = "far fa-comment",
                    label = "Abandonar Animal",
                    },   



                },
                    job = {"all"},
                    distance = 2.5
                })  

end)








Citizen.CreateThread(function()
    RegisterKeyMapping("PetMenu", "Pet Menu", "keyboard", "F9") 
    RegisterCommand('PetMenu', PetMenu, false)
    TriggerEvent("chat:removeSuggestion", "/PetMenu")
    RegisterKeyMapping("PetAttack", "PetAttack", "keyboard", "G") 
    RegisterCommand('PetAttack', k9Attack, false)
    TriggerEvent("chat:removeSuggestion", "/PetAttack")   
    RegisterKeyMapping("PetSearch", "PetSearch", "keyboard", "H") 
    RegisterCommand('PetSearch', k9Search, false)
    TriggerEvent("chat:removeSuggestion", "/PetSearch")       
end)

local aiming, entity

function k9Search()
    if PlayerJob.name == 'police' then
        if DoesEntityExist(pet) then
        attacking = true
            if IsPlayerFreeAiming(PlayerId()) then
                aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if (aiming) then
                    if IsEntityAPed(entity) then
                        TaskGoToEntity(pet, entity, -1, 2.0, petSpeed, 1073741824.0, 0)
                        searching = true
                        return entity
                    end
                end
            end
        end
    end

end

function k9Attack()
    if PlayerJob.name == 'police' then
        if DoesEntityExist(pet) then
        attacking = true
            if IsPlayerFreeAiming(PlayerId()) then
                aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if (aiming) then
                    if IsEntityAPed(entity) then
                        SetCanAttackFriendly(pet, true, false)
                        SetPedRelationshipGroupDefaultHash(entity, GetHashKey("CIVMALE"))
                        SetPedRelationshipGroupHash(pet,GetHashKey('COUGAR'))
                        TaskPutPedDirectlyIntoMelee(pet, entity, 0.0, -1.0, 0.0, 0)
                        return entity
                    end
                end
            end
        end
    end

end


RegisterNetEvent('s_pets:spawnPet')
AddEventHandler('s_pets:spawnPet',function(modelname)

    if DoesEntityExist(pet) then

        DeleteEntity(pet)

    else

    local playerCoords = GetEntityCoords(PlayerPedId())
    local hash = modelname
    local playerPed = PlayerPedId()
    local playerGroup = GetPedGroupIndex(playerPed)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    pet = CreatePed(28, hash, playerCoords.x +1, playerCoords.y +1, playerCoords.z -1, 1, 1)
    SetModelAsNoLongerNeeded(hash)
    AddRelationshipGroup('PET')
    AddRelationshipGroup('OWNER')
    SetPedRelationshipGroupHash(pet,GetHashKey('PET'))
    SetPedRelationshipGroupHash(playerPed,GetHashKey('OWNER'))
    SetRelationshipBetweenGroups(0, GetHashKey("PET"), GetHashKey('OWNER'))
    petOut()
    petSickness()
    local petModel = GetEntityModel(pet)
    if petModel == GetHashKey('a_c_pug') or petModel == GetHashKey('a_c_poodle') then
        SitDict = "creatures@pug@amb@world_dog_sitting@idle_a"
        SitAnim = "idle_b"
        BarkDict = "creatures@pug@amb@world_dog_barking@idle_a"
        BarkAnim = "idle_a"
        SleepDict = nil
        SleepAnim = nil
    elseif petModel == GetHashKey('a_c_rottweiler') or petModel == GetHashKey('a_c_husky') or petModel == GetHashKey('a_c_retriever')  or petModel == GetHashKey('a_c_shepherd')  then
        SitDict = "creatures@retriever@amb@world_dog_sitting@idle_a"
        SitAnim = "idle_b"
        BarkDict = "creatures@rottweiler@amb@world_dog_barking@idle_a"
        BarkAnim = "idle_a"
        SleepDict = "creatures@rottweiler@amb@sleep_in_kennel@"
        SleepAnim = "sleep_in_kennel"
    elseif petModel == GetHashKey('a_c_cat_01') then
        SitDict = "creatures@cat@amb@world_cat_sleeping_ground@base"
        SitAnim = "base"
        BarkDict = nil
        BarkAnim = nil
        SleepDict = "creatures@cat@amb@world_cat_sleeping_ground@base"
        SleepAnim = "base"
    elseif petModel == GetHashKey('a_c_rabbit_01') then
        SitDict = nil
        SitAnim = nil
        BarkDict = "creatures@rabbit@amb@world_rabbit_eating@base"
        BarkAnim = "base"
        SleepDict = nil
        SleepAnim = nil
    elseif petModel == GetHashKey('a_c_mtlion') then
        SitDict = "creatures@cougar@amb@world_cougar_rest@base"
        SitAnim = "base"
        BarkDict = nil
        BarkAnim = nil
        SleepDict = nil
        SleepAnim = nil
    elseif petModel == GetHashKey('a_c_hen') then
        SitDict = "creatures@hen@amb@world_hen_standing@idle_a"
        SitAnim = "idle_a"
        BarkDict = "creatures@hen@amb@world_hen_pecking@base"
        BarkAnim = "base"
        SleepDict = nil
        SleepAnim = nil
    elseif petModel == GetHashKey('a_c_westy') then
        SitDict = nil
        SitAnim = nil
        BarkDict = nil
        BarkAnim = nil
        SleepDict = nil
        SleepAnim = nil
    elseif petModel == GetHashKey('a_c_pig') then
        SitDict = nil
        SitAnim = nil
        BarkDict = "creatures@pig@amb@world_pig_grazing@base"
        BarkAnim = "base"
        SleepDict = nil
        SleepAnim = nil

    end
end


end)


RegisterNetEvent('s_pets:removePet')
AddEventHandler('s_pets:removePet',function()
    QBCore.Functions.Notify("Nós tirarmos-te o animal, és um monstro!", "error")
TriggerServerEvent('s_pets:removePet')
end)


RegisterNetEvent('s_pets:useTennisBall')
AddEventHandler('s_pets:useTennisBall',function()

        local hash = 'prop_tennis_ball'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
        SetModelAsNoLongerNeeded(hash)
        AttachEntityToEntity(ballObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand 
        local forwardVector = GetEntityForwardVector(PlayerPedId())
        local force = 50.0
        local animDict = "melee@unarmed@streamed_variations"
        local anim = "plyr_takedown_front_slap"
        ClearPedTasks(PlayerPedId())
        while (not HasAnimDictLoaded(animDict)) do
            RequestAnimDict(animDict)
            Citizen.Wait(5)
        end
        TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
        Wait(500)
        DetachEntity(ballObj)
        ApplyForceToEntity(ballObj,1,forwardVector.x*force,forwardVector.y*force + 5.0,forwardVector.z,0,0,0,0,false,true,true,false,true)
        ballID = ObjToNet(ballObj)
        SetNetworkIdExistsOnAllMachines(ballObj,true)
        ballThrown = true
        chasing = true
        TriggerServerEvent('s_pets:removeBall')
end)


RegisterNetEvent('s_pets:petGetIn')
AddEventHandler('s_pets:petGetIn',function()
vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
TaskWarpPedIntoVehicle(pet,vehicle,-2)

end)

RegisterNetEvent('s_pets:petGetOut')
AddEventHandler('s_pets:petGetOut',function()
    vehicle = GetVehiclePedIsIn(pet,false)
    TaskLeaveVehicle(pet,vehicle,16)
end)

RegisterNetEvent('s_pets:healPet')
AddEventHandler('s_pets:healPet',function()
local illnessFee = 0

if DoesEntityExist(pet) then



    SetEntityCoords(pet,-1570.3,-966.69,12.84)
    stay = true
    FreezeEntityPosition(pet,true)
    if SleepDict == nil then

    else
        LoadAnimDict(SleepDict)
        TaskPlayAnim(pet, SleepDict, SleepAnim ,8.0, -8, -1, 1, 0, false, false, false)
    end
    QBCore.Functions.Notify("O teu animal está a ser tratado na outra sala!", "primary")
    Wait(15000)
    stay = false
    SetEntityCoords(pet,-1570.02,-968.1,12.03)
    FreezeEntityPosition(pet,false)
    ClearPedTasks(pet)
    if petHealth < 100 or petSpeed ~= 10.0 then
        if illness == 'fatigue' then
            QBCore.Functions.Notify("O teu animal foi tratado por " ..illness, "primary")
            SetEntityHealth(pet,200)
            illness = 'none'
            illnessFee = 100
            petSpeed = 10.0
        elseif illness == 'kennelcough' then
            QBCore.Functions.Notify("O teu animal foi tratado", "primary")
            illness = 'none'
            SetEntityHealth(pet,200)
            illnessFee = 300
            petHealth = 100
        end
            TriggerServerEvent('s_pets:chargeABitch',illnessFee)
    end





else
    QBCore.Functions.Notify("Onde está o teu animal? Eu não trato pessoas.", "primary")
end
end)


function petSickness()

Citizen.CreateThread(function()
    while true do

        if DoesEntityExist(pet) then       
            if illness == 'none' then
                local chance = math.random(1,100)
                if chance <= Config.IllnessChance then
                    local pick = math.random(1,2)
                    if pick == 1 then
                        illness = 'fatigue'
                    else
                        illness = 'kennelcough'
                    end
                end
            end

        else
            break
        end
    Wait(600000)
    end
end)

end


RegisterNetEvent('s_pets:k9ItemCheck')
AddEventHandler('s_pets:k9ItemCheck',function(ItemCheck)
    print('did i trigger')
local found = ItemCheck

print(found)
    if found then
    QBCore.Functions.Notify(Config.K9Message, "primary")
    LoadAnimDict(BarkDict)
    TaskPlayAnim(pet, BarkDict, BarkAnim ,8.0, -8, -1, 1, 0, false, false, false)
    Wait(5000)
    ClearPedTasks(pet)
else
end


end)



-- Main Pet Loop

function petOut()

Citizen.CreateThread(function()
    while true do

        if DoesEntityExist(pet) then


            --Search a Person
            if searching then
                local dst = #(GetEntityCoords(pet) - GetEntityCoords(entity))
                if dst < 4 then

                    local player, distance = QBCore.Functions.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                            Wait(5000)
                            searching = false
                        TriggerServerEvent('s_pets:k9Search',GetPlayerServerId(PlayerId()), GetPlayerServerId(player))

                    end

                end
            end

            -- K9 is Attacking
            if attacking then
                if DoesEntityExist(entity) then
                    local entityHealth = GetEntityHealth(entity)
                    if entityHealth <= 140 then
                        attacking = false
                        entity = nil
                        local chance = math.random(1,100)
                        if chance <= Config.IllnessChance then
                            local pick = math.random(1,2)
                            if pick == 1 then
                                illness = 'fatigue'
                            else
                                illness = 'kennelcough'
                            end
                        end
                        SetPedRelationshipGroupHash(pet,GetHashKey('PET'))
                    end

                end

            end



            -- Chase ball if it was thrown
            if ballThrown then
                local speed = GetEntitySpeed(pet)
                local dst3 = #(GetEntityCoords(pet) - GetEntityCoords(ballObj))
                if speed <= 0 then
                TaskGoToEntity(pet, ballObj, -1, 2.0, petSpeed, 1073741824.0, 0)
                stay = false
                feeding = false
                    if dst3 < 2 then
                        DeleteEntity(ballObj)
                        ballThrown = false
                        petMoving = false
                        chasing = false
                        returnBall = true
                    end
                end
            end





            -- If pet has an illness, lower health or other things
            if illness == "fatigue" then
                petSpeed = 1.0
            elseif illness == "kennelcough" then
                petHealth = petHealth -.3
            end



            -- If Health less/equal to 0 then kill pet
            if petHealth <= 0 then
                SetEntityInvincible(pet,false)
                SetEntityHealth(pet,0)
            end

            -- If Pet is Alive, Take Food Away
            if petHealth > 0 then
                if petFood > 0 then
                    petFood = petFood - .5
                    --print(petFood)
                else
                    --If Food is less then 0, Take Health away
                    petHealth = petHealth -.5
                    --print(petHealth)
                end
            end


            -- Feeding & Moving to Bowl
            if feeding and not petMoving then
                petMoving = true
                stay = false
                TaskGoToEntity(pet, bowlObj, -1, 2.0, petSpeed, 1073741824.0, 0)
                local dst2 = #(GetEntityCoords(pet) - GetEntityCoords(bowlObj))
                    if dst2 < 4 then
                        if BarkDict == nil then

                        else
                            LoadAnimDict(BarkDict)
                            TaskPlayAnim(pet, BarkDict, BarkAnim ,8.0, -8, -1, 1, 0, false, false, false)
                        end
                        Wait(5000)
                        DeleteEntity(bowlObj)
                        petFood = 300
                        feeding = false
                        petMoving = false
                        ClearPedTasks(pet)
                    end
            end

            -- Move & Stay
            local dst = #(GetEntityCoords(pet) - GetEntityCoords(PlayerPedId()))
            if dst > 5 and not petMoving and not stay and not feeding and not chasing and not attacking and not searching then
                petMoving = true
                TaskGoToEntity(pet, PlayerPedId(), -1, 1.0, petSpeed, 1073741824.0, 0)
            elseif dst < 5 then
                petMoving = false
                if returnBall then
                    TriggerServerEvent('s_pets:returnBall')
                    returnBall = false
                end
            end

        else
            break
        end
        Wait(2000)
    end
end)

end


RegisterNetEvent('s_pets:getOwnedPet')
AddEventHandler('s_pets:getOwnedPet',function()
    QBCore.Functions.TriggerCallback("s_pets:getPetSQL", function(cb)
        petInfo = table.unpack(cb)
        if petInfo ~= nil then
            activePet = petInfo.modelname
            petHealth = petInfo.health
            illness = petInfo.illnesses
            petName = petInfo.name
            if activePet then
                TriggerEvent('s_pets:spawnPet',activePet)
            end
        end
    end)
end)



RegisterNetEvent('s_pets:feedPet')
AddEventHandler('s_pets:feedPet',function()
    if not DoesEntityExist(bowlObj) then
        bendAnimation()
        local hash = 'prop_bowl_crisps'
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-1.0))
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(0) end
        bowlObj = CreateObjectNoOffset(hash, x, y, z, true, false)
        PlaceObjectOnGroundProperly(bowlObj)
        SetModelAsNoLongerNeeded(hash)
        feeding = true
    end
end)


RegisterNetEvent('s_pets:stay')
RegisterNetEvent('s_pets:follow')

AddEventHandler('s_pets:follow',function()
stay = false
attacking = false
entity = nil
ClearPedTasks(pet)
end)

AddEventHandler('s_pets:stay',function()
stay = true
attacking = false
entity = nil
ClearPedTasks(pet)
LoadAnimDict(SitDict)
TaskPlayAnim(pet,SitDict,SitAnim  ,8.0, -8, -1, 1, 0, false, false, false)

end)


RegisterNetEvent('s_pets:petStore')
AddEventHandler('s_pets:petStore',function()

    exports['qb-menu']:openMenu({
        {
            header = "Loja Animais",
            txt = "Comprar comida" .. " por " .. Config.FoodPrice.. "€.",
            params = {
                event = "s_pets:buyFood",
            }
        },
		{
            header = "Comprar um",
            txt = Config.Pet1Label .. " por " .. Config.Pet1Price .. "€",
            params = {
                event = "s_pets:buyPet1",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet2Label .. " por " .. Config.Pet2Price .. "€",
            params = {
                event = "s_pets:buyPet2",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet3Label .. " por " .. Config.Pet3Price .. "€",
            params = {
                event = "s_pets:buyPet3",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet4Label .. " por " .. Config.Pet4Price .. "€",
            params = {
                event = "s_pets:buyPet4",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet5Label .. " por " .. Config.Pet5Price .. "€",
            params = {
                event = "s_pets:buyPet5",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet6Label .. " por " .. Config.Pet6Price .. "€",
            params = {
                event = "s_pets:buyPet6",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet7Label .. " por " .. Config.Pet7Price .. "€",
            params = {
                event = "s_pets:buyPet7",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet8Label .. " por " .. Config.Pet8Price .. "€",
            params = {
                event = "s_pets:buyPet8",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet9Label .. " por " .. Config.Pet9Price .. "€",
            params = {
                event = "s_pets:buyPet9",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet10Label .. " por " .. Config.Pet10Price .. "€",
            params = {
                event = "s_pets:buyPet10",
            }
        },
        {
            header = "Comprar um",
            txt = Config.Pet11Label .. " por " .. Config.Pet11Price .. "€",
            params = {
                event = "s_pets:buyPet11",
            }
        },
        {
            header = "< Sair",
            params = {
                event = "drp_drogas:client:sairmenu"
            }
        },
        -- vai ate ao 11
    })
end)

RegisterNetEvent('s_pets:buyFood')
AddEventHandler('s_pets:buyFood',function()
TriggerServerEvent('s_pets:buyFood',Config.FoodPrice)
end)
RegisterNetEvent('s_pets:buyPet1')
AddEventHandler('s_pets:buyPet1',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet1,Config.Pet1Price)
end)
RegisterNetEvent('s_pets:buyPet2')
AddEventHandler('s_pets:buyPet2',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet2,Config.Pet2Price)
end)
RegisterNetEvent('s_pets:buyPet3')
AddEventHandler('s_pets:buyPet3',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet3,Config.Pet3Price)
end)
RegisterNetEvent('s_pets:buyPet4')
AddEventHandler('s_pets:buyPet4',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet4,Config.Pet4Price)
end)
RegisterNetEvent('s_pets:buyPet5')
AddEventHandler('s_pets:buyPet5',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet5,Config.Pet5Price)
end)

RegisterNetEvent('s_pets:buyPet6')
AddEventHandler('s_pets:buyPet6',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet6,Config.Pet6Price)
end)

RegisterNetEvent('s_pets:buyPet7')
AddEventHandler('s_pets:buyPet7',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet7,Config.Pet7Price)
end)
RegisterNetEvent('s_pets:buyPet8')
AddEventHandler('s_pets:buyPet8',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet8,Config.Pet8Price)
end)

RegisterNetEvent('s_pets:buyPet9')
AddEventHandler('s_pets:buyPet9',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet9,Config.Pet9Price)
end)

RegisterNetEvent('s_pets:buyPet10')
AddEventHandler('s_pets:buyPet10',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet10,Config.Pet10Price)
end)


RegisterNetEvent('s_pets:buyPet11')
AddEventHandler('s_pets:buyPet11',function()
TriggerServerEvent('s_pets:buyPet',Config.Pet11,Config.Pet11Price)
end)








RegisterNetEvent('s_pets:namePet')
AddEventHandler('s_pets:namePet',function()
local keyboard = exports["qb-input"]:ShowInput({
    header = "Nome do Animal", 
    submitText = "Nome",
    inputs = {
        {
            text = "Nome Animal", -- text you want to be displayed as a place holder
            name = "nomeanimal", -- name of the input should be unique otherwise it might override
            type = "text", -- type of the input
            isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
        },
      
    }
})

    if keyboard ~= nil then
        TriggerServerEvent('s_pets:updatePetName', keyboard.nomeanimal)
        petName = keyboard.nomeanimal
    end
end)


function PetMenu()

TriggerEvent('s_pets:petMenu')

end

RegisterNetEvent('s_pets:petMenu')
AddEventHandler('s_pets:petMenu',function()

    exports['qb-menu']:openMenu({
        {
            header = "Chamar Animal",
            txt = "Chamar Animal",
            params = {
                event = "s_pets:getOwnedPet",
            }
        },
		{
            header = "Guardar Animal",
            txt = "Mandar animal para a casota.",
            params = {
                event = "s_pets:dismissPet",
            }
        },
        {
            header = "Comandos Animal",
            txt = "Comandos Animal.",
            params = {
                event = "s_pets:petCommands",
            }
        },
        {
            header = "Status",
            txt = petName .. "'s Status",
            params = {
                event = "s_pets:petStatus",
            }
        },
        {
            header = "< Sair",
            params = {
                event = "drp_drogas:client:sairmenu"
            }
        },
    })
end)


RegisterNetEvent('s_pets:petStatus')
AddEventHandler('s_pets:petStatus',function()

    exports['qb-menu']:openMenu({
        {
            header = petName .. "'s Status",
            txt = "Voltar atrás",
            params = {
                event = "s_pets:petMenu",
            }
        },
		{
            header = "Vida",
            txt = petHealth,
        },
        {
            header = "Comida",
            txt = petFood,
        },
        {
            header = "Doenças",
            txt = petFood,
        },
        {
            header = petName,
            txt = "Alterar nome",
            params = {
                event = "s_pets:namePet",
            }
        },
        {
            header = "< Sair",
            params = {
                event = "drp_drogas:client:sairmenu"
            }
        },
    })

end)


RegisterNetEvent('s_pets:petCommands')
AddEventHandler('s_pets:petCommands',function()

    exports['qb-menu']:openMenu({
        {
            header = "Menu Animal",
            txt = "Voltar",
            params = {
                event = "s_pets:petMenu",
            }
        },
		{
            header = "Comandos",
            txt = "Seguir",
            params = {
                event = "s_pets:follow",
            }
        },
        {
            header = "Comandos",
            txt = "Ficar.",
            params = {
                event = "s_pets:stay",
            }
        },
        {
            header = "Comandos",
            txt = "Comida",
            params = {
                event = "s_pets:feedPet",
            }
        },
        {
            header = "Comandos",
            txt = "Colocar no veículo",
            params = {
                event = "s_pets:petGetIn",
            }
        },
        {
            header = "Comandos",
            txt = "Sair do veículo",
            params = {
                event = "s_pets:petGetOut",
            }
        },
        {
            header = "< Sair",
            params = {
                event = "drp_drogas:client:sairmenu"
            }
        },
    })

end)



RegisterNetEvent('s_pets:dismissPet')
AddEventHandler('s_pets:dismissPet',function()

    if DoesEntityExist(pet) then
        TaskWanderStandard(pet,10.0,10)
        SetPedAsNoLongerNeeded(pet)
        Wait(5000)
        DeleteEntity(pet)
        feeding = false
        stay = false
        TriggerServerEvent('s_pets:updatePet',petHealth,illness)
    end

end)

function bendAnimation()
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasksImmediately(PlayerPedId())
end


function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end