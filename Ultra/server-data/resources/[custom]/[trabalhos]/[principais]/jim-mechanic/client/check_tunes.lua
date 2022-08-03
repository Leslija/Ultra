local QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
onDuty = false
--========================================================= CheckTunes

function playAnim(animDict, animName, duration, flag)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, flag, 1, false, false, false)
    RemoveAnimDict(animDict)
end

local vehicle = nil	
local vehProps = nil	
local model = nil	
local modelName = nil
local modCount = nil	

local function trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

RegisterNetEvent('jim-mechanic:client:Menu', function()
	if Config.RequiresJob == true then havejob = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then	havejob = true end
		end
		if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
	end
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 4.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 4.5, 0, 71)
			SetVehicleModKit(vehicle, 0)
			modelName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			for k, v in pairs(Config.carNames) do if modelName == v.name then modelName = v.newName end	end
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		end
		Plate = trim(GetVehicleNumberPlateText(vehicle))
		
		
		if modelName == "m5" then modelName = "bmci" end
		modCount = GetNumVehicleMods(vehicle, modType)
		vehProps.modEngine = vehProps.modEngine + 1
		vehProps.modBrakes = vehProps.modBrakes + 1
		vehProps.modSuspension = vehProps.modSuspension + 1
		vehProps.modTransmission = vehProps.modTransmission + 1
		vehProps.modArmor = vehProps.modArmor + 1
		vehProps.windowTint = vehProps.windowTint + 1
			
		if GetNumVehicleMods(vehicle, 12) ~= "0" then 
			if tostring(vehProps.modBrakes) == "3" then modBrakes = "✔ Travões Corrida" else modBrakes = "Stock" end
		else
			modBrakes = "Indisponivel"
		end


		--engine
		if GetNumVehicleMods(vehicle,11) ~= "0" then 
			if tostring(vehProps.modEngine) == "4" then modEngine = "✔ V8 Motor" 
			elseif tostring(vehProps.modEngine) == "3" then modEngine = "✔ Shonen Motor"
			elseif tostring(vehProps.modEngine) == "0" then	modEngine = "Stock" 
			end
		else	
			modEngine = "Indisponivel"
		end
		--suspension
		if GetNumVehicleMods(vehicle,15) ~= 0 then
			if tostring(vehProps.modSuspension) == "2" then modSuspension = "✔ Street Level"
			elseif tostring(vehProps.modSuspension) == "4" then	modSuspension = "✔ Racing Level" 
			elseif tostring(vehProps.modSuspension) == "0" then	modSuspension = "Stock" 
			end
		else		
			modSuspension = "Indisponivel"
		end
		--transmission
		if GetNumVehicleMods(vehicle,13) == "0" then modTransmission = "Indisponivel"
		else if vehProps.modTransmission == GetNumVehicleMods(vehicle, 13) then modTransmission = "✔ Transmissão Corrida" else modTransmission = "Stock" end
		end
		
		if GetNumVehicleMods(vehicle,16) == "0" then modTransmission = "Indisponivel"
		else if vehProps.modArmor == GetNumVehicleMods(vehicle, 16) then modArmor = "✔ Reforçada" else modArmor = "Stock" end
		end
		
		if tostring(vehProps.modTurbo) == "false" then modTurbo = "Não Instalado" else modTurbo = "✔ Instalado" end
		
		
		if tostring(vehProps.modXenon) == "false" then modXenon = "Não Instalado" else modXenon = "✔ Instalado" end
		if GetVehicleHeadlightsColour(vehicle) == -1 then xenonColor = " (Stock)"
		elseif GetVehicleHeadlightsColour(vehicle) == 0 then xenonColor = " (Ice Blue)"
		elseif GetVehicleHeadlightsColour(vehicle) == 1 then xenonColor = " (Blue)"
		elseif GetVehicleHeadlightsColour(vehicle) == 2 then xenonColor = " (Electric Blue)"
		elseif GetVehicleHeadlightsColour(vehicle) == 3 then xenonColor = " (Mint Green)"
		elseif GetVehicleHeadlightsColour(vehicle) == 4 then xenonColor = " (Lime Green)"
		elseif GetVehicleHeadlightsColour(vehicle) == 5 then xenonColor = " (Yellow)"
		elseif GetVehicleHeadlightsColour(vehicle) == 6 then xenonColor = " (Golden)"
		elseif GetVehicleHeadlightsColour(vehicle) == 7 then xenonColor = " (Orange)"
		elseif GetVehicleHeadlightsColour(vehicle) == 8 then xenonColor = " (Red)"
		elseif GetVehicleHeadlightsColour(vehicle) == 9 then xenonColor = " (Pony Pink)"
		elseif GetVehicleHeadlightsColour(vehicle) == 10 then xenonColor = " (Hot Pink)"
		elseif GetVehicleHeadlightsColour(vehicle) == 11 then xenonColor = " (Purple)"
		elseif GetVehicleHeadlightsColour(vehicle) == 12 then xenonColor = " (Blacklight)"
		elseif GetVehicleHeadlightsColour(vehicle) == 255 then xenonColor = ""
		end
		
		if GetDriftTyresEnabled(vehicle) == false then modDrift = "Não Instalada" elseif GetDriftTyresEnabled(vehicle) == 1 then modDrift = "✔ Instalado" end

		if GetVehicleTyresCanBurst(vehicle) == 1 then modBproof = "Não Instalada" elseif GetVehicleTyresCanBurst(vehicle) == false then	modBproof = "✔ Instalado" end
				
		local CheckMenu = {
			{
				isMenuHeader = true,
				header = "Veículo: "..QBCore.Shared.Vehicles[modelName].name.." "..QBCore.Shared.Vehicles[modelName].brand,
				txt = "Valor: "..QBCore.Shared.Vehicles[modelName].price.."€ | Matrícula: ["..GetVehicleNumberPlateText(vehicle).."]" },
			{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Livery:Apply", args = -2 } },
		}
		
		CheckMenu[#CheckMenu + 1] = { header = "Motor: ", txt = modEngine, params = { event = "jim-mechanic:client:Menu:Engine:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modEngine } } }
		CheckMenu[#CheckMenu + 1] = { header = "Travões: ", txt = modBrakes, params = { event = "jim-mechanic:client:Menu:Brakes:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modBrakes } } }
		if modSuspension ~= "Indisponivel" then CheckMenu[#CheckMenu + 1] = { header = "Suspensão: ", txt = modSuspension, params = { event = "jim-mechanic:client:Menu:Suspension:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modSuspension } } } end
		CheckMenu[#CheckMenu + 1] = { header = "Armadura: ", txt = modArmor, params = { event = "jim-mechanic:client:Menu:Armor:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modArmor } } }
		CheckMenu[#CheckMenu + 1] = { header = "Transmissão: ", txt = modTransmission, params = { event = "jim-mechanic:client:Menu:Transmission:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modTransmission } } }
		CheckMenu[#CheckMenu + 1] = { header = "Turbo: ", txt = modTurbo, params = { event = "jim-mechanic:client:Menu:Turbo:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modTurbo } } }
		CheckMenu[#CheckMenu + 1] = { header = "Xenon: ", txt = modXenon..xenonColor, params = { event = "jim-mechanic:client:Menu:Xenon:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modXenon } } }
		CheckMenu[#CheckMenu + 1] = { header = "Pneus Drift: ", txt = modDrift, params = { event = "jim-mechanic:client:Menu:Drift:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modDrift } } }
		CheckMenu[#CheckMenu + 1] = { header = "Pneus Prova Bala: ", txt = modBproof, params = { event = "jim-mechanic:client:Menu:BProof:Check", args = { modelName = modelName, plate = GetVehicleNumberPlateText(vehicle), vehicle = vehicle, mod = modBproof } } }
		CheckMenu[#CheckMenu + 1] = { header = "", txt = "☐ - Lista Possível Cosméticos", params = { event = "jim-mechanic:client:Menu:List", args = vehicle } }


		exports['qb-menu']:openMenu(CheckMenu)
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:List')
AddEventHandler('jim-mechanic:client:Menu:List', function()
		
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = nil

	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	SetVehicleModKit(vehicle, 0)
	
	if GetNumVehicleMods(vehicle, 0) ~= 0 then spoiler = "✔ - " else spoiler = "" end 
	if GetNumVehicleMods(vehicle, 1) ~= 0 then rbumper = "✔ - " else rbumper = "" end 
	if GetNumVehicleMods(vehicle, 2) ~= 0 then lbumper = "✔ - " else lbumper = "" end 
	if GetNumVehicleMods(vehicle, 3) ~= 0 then skirt = "✔ - " else skirt = "" end 
	if GetNumVehicleMods(vehicle, 4) ~= 0 then exhaust = "✔ - " else exhaust = "" end 
	if GetNumVehicleMods(vehicle, 5) ~= 0 then rollcage = "✔ - " else rollcage = "" end 

	if GetNumVehicleMods(vehicle, 6) ~= 0 then grill = "✔ - " else grill = "" end 
	if GetNumVehicleMods(vehicle, 7) ~= 0 then hood = "✔ - " else hood = "" end 
	if GetNumVehicleMods(vehicle, 8) ~= 0 then lfender = "✔ - " else lfender = "" end 
	if GetNumVehicleMods(vehicle, 9) ~= 0 then rfender = "✔ - " else rfender = "" end 
	if GetNumVehicleMods(vehicle, 10) ~= 0 then roof = "✔ - " else roof = "" end 
	--if GetNumVehicleMods(vehicle, 17) ~= 0 then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 18) ~= 0 then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 19) ~= 0 then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 20) ~= 0 then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 21) ~= 0 then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 22) ~= false then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 23) ~= 0 then  = "✔ - " else  = false end 
	--if GetNumVehicleMods(vehicle, 24) ~= 0 then  = "✔ - " else  = false end 
	if GetNumVehicleMods(vehicle, 25) ~= 0 then vanity = "✔ - " else vanity = "" end 
	if GetNumVehicleMods(vehicle, 26) ~= 0 then vanity2 = "✔ - " else vanity2 = "" end 
	if GetNumVehicleMods(vehicle, 27) ~= 0 then trima = "✔ - " else trima = "" end 
	if GetNumVehicleMods(vehicle, 28) ~= 0 then ornaments = "✔ - " else ornaments = "" end 
	if GetNumVehicleMods(vehicle, 29) ~= 0 then dashboard = "✔ - " else dashboard = "" end 
	if GetNumVehicleMods(vehicle, 30) ~= 0 then dials = "✔ - " else dials = "" end 
	if GetNumVehicleMods(vehicle, 31) ~= 0 then doorspeaker = "✔ - " else doorspeaker = "" end 
	if GetNumVehicleMods(vehicle, 32) ~= 0 then seats = "✔ - " else seats = "" end 
	if GetNumVehicleMods(vehicle, 33) ~= 0 then steering = "✔ - " else steering = "" end 
	if GetNumVehicleMods(vehicle, 34) ~= 0 then shifter = "✔ - " else shifter = "" end 
	if GetNumVehicleMods(vehicle, 35) ~= 0 then plaque = "✔ - " else plaque = "" end 
	if GetNumVehicleMods(vehicle, 36) ~= 0 then speaker = "✔ - " else speaker = "" end 
	if GetNumVehicleMods(vehicle, 37) ~= 0 then trunk = "✔ - " else trunk = "" end 
	if GetNumVehicleMods(vehicle, 38) ~= 0 then hydraulic = "✔ - " else hydraulic = "" end 
	if GetNumVehicleMods(vehicle, 39) ~= 0 then engineblock = "✔ - " else engineblock = "" end 
	if GetNumVehicleMods(vehicle, 40) ~= 0 then filter = "✔ - " else filter = "" end 
	if GetNumVehicleMods(vehicle, 41) ~= 0 then strut = "✔ - " else strut = "" end 
	if GetNumVehicleMods(vehicle, 42) ~= 0 then archcover = "✔ - " else archcover = "" end 
	if GetNumVehicleMods(vehicle, 43) ~= 0 then aerial = "✔ - " else aerial = "" end 
	if GetNumVehicleMods(vehicle, 44) ~= 0 then trimb = "✔ - " else trimb = "" end 
	if GetNumVehicleMods(vehicle, 45) ~= 0 then fueltank = "✔ - " else fueltank = "" end 

	local CheckMenu = {
		{
			isMenuHeader = true,
			header = "Vehicle: "..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))),
			txt = "Lista Possível Costméticos" },
		{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Menu:Close" } },
	}
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "Cosméticos Exteriores", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = spoiler.."Spoilers - ["..GetNumVehicleMods(vehicle, 0).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = rbumper.."Pára-Choque Frontal - ["..GetNumVehicleMods(vehicle, 1).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = lbumper.."Pára-Choque Traseiro - ["..GetNumVehicleMods(vehicle, 2).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = skirt.."Saias - ["..GetNumVehicleMods(vehicle, 3).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = exhaust.."Escapamento - ["..GetNumVehicleMods(vehicle, 4).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = grill.."Grades - ["..GetNumVehicleMods(vehicle, 6).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = hood.."Capôs - ["..GetNumVehicleMods(vehicle, 7).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = lfender.."Pára-Choque Esquerdo - ["..GetNumVehicleMods(vehicle, 8).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = rfender.."Pára-Choque Direito - ["..GetNumVehicleMods(vehicle, 9).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = roof.."Teto - ["..GetNumVehicleMods(vehicle, 10).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = vanity.."Suporte Matrícula - ["..GetNumVehicleMods(vehicle, 25).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = vanity2.."Matrículas Vanity - ["..GetNumVehicleMods(vehicle, 26).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = trima.."Guarnição A - ["..GetNumVehicleMods(vehicle, 27).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = trimb.."Guarnição B - ["..GetNumVehicleMods(vehicle, 44).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = trunk.."Malas - ["..GetNumVehicleMods(vehicle, 37).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = engineblock.."Blocos do Motor - ["..GetNumVehicleMods(vehicle, 39).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = filter.."Filtros de Ar - ["..GetNumVehicleMods(vehicle, 40).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = strut.."Suporte do motor - ["..GetNumVehicleMods(vehicle, 41).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = archcover.."Coberturas de Arco - ["..GetNumVehicleMods(vehicle, 42).." opções]", }
	
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "Cosméticos Interiores", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = rollcage.."Gaiolas - ["..GetNumVehicleMods(vehicle, 5).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = ornaments.."Enfeites - ["..GetNumVehicleMods(vehicle, 28).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = dashboard.."Painéis - ["..GetNumVehicleMods(vehicle, 29).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = dials.."Mostrador - ["..GetNumVehicleMods(vehicle, 30).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = doorspeaker.."Colunas Portas - ["..GetNumVehicleMods(vehicle, 31).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = seats.."Assentos - ["..GetNumVehicleMods(vehicle, 32).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = steering.."Volantes - ["..GetNumVehicleMods(vehicle, 33).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = shifter.."Manetes Vel. - ["..GetNumVehicleMods(vehicle, 34).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = plaque.."Placas - ["..GetNumVehicleMods(vehicle, 35).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = speaker.."Colunas Som - ["..GetNumVehicleMods(vehicle, 36).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = hydraulic.."Hidráulicos - ["..GetNumVehicleMods(vehicle, 38).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = aerial.."Aéreos - ["..GetNumVehicleMods(vehicle, 43).." opções]", }
	CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = fueltank.."Tanques Comb. - ["..GetNumVehicleMods(vehicle, 45).." opções]", }
	exports['qb-menu']:openMenu(CheckMenu)
end)

RegisterNetEvent('jim-mechanic:client:Menu:Close')
AddEventHandler('jim-mechanic:client:Menu:Close', function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	for i = 0, 5 do
		SetVehicleDoorShut(vehicle, i, false, true) -- will open every door from 0-5
	end
	exports['qb-menu']:closeMenu()
end)

---BRAKES CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Brakes:Check')
AddEventHandler('jim-mechanic:client:Menu:Brakes:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Travões Corrida" then
		TriggerEvent('jim-mechanic:client:Menu:Brakes', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Nenhum travão instalado", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Brakes', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover os travões?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveBrakes" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)



---TRANSMISSION CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Transmission:Check')
AddEventHandler('jim-mechanic:client:Menu:Transmission:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Transmissão de Corrida" then
		TriggerEvent('jim-mechanic:client:Menu:Transmission', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Nenhum transmissão instalada", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Transmission', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.." | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover a transmissão?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveTransmission" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---ARMOR CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Armor:Check')
AddEventHandler('jim-mechanic:client:Menu:Armor:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Reforçada" then
		TriggerEvent('jim-mechanic:client:Menu:Armor', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Nenhuma armadura instalada", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Armor', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover a armadura?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveArmor" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---TURBO CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Turbo:Check')
AddEventHandler('jim-mechanic:client:Menu:Turbo:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Instalado" then
		TriggerEvent('jim-mechanic:client:Menu:Turbo', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Nenhum turbo instalado", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Turbo', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover o turbo?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveTurbo" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---ENGINE CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Engine:Check')
AddEventHandler('jim-mechanic:client:Menu:Engine:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod ~= "Stock" then
		TriggerEvent('jim-mechanic:client:Menu:Engine', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Nenhum motor com melhorias instalado", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Engine', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover o motor?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveEngine" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---ENGINE CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Suspension:Check')
AddEventHandler('jim-mechanic:client:Menu:Suspension:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod ~= "Stock" then
		TriggerEvent('jim-mechanic:client:Menu:Suspension', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Nenhuma suspensão instalada", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Suspension', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover a suspensão?" },
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveSuspension" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---XENON CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Xenon:Check')
AddEventHandler('jim-mechanic:client:Menu:Xenon:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Instalado" then
		TriggerEvent('jim-mechanic:client:Menu:Xenon', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Sem Faróis Xenon instalados", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Xenon', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover os faróis xenon?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveXenon" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---BPROOF CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:BProof:Check')
AddEventHandler('jim-mechanic:client:Menu:BProof:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Instalado" then
		TriggerEvent('jim-mechanic:client:Menu:BProof', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Pneus à prova de bala não instalados", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:BProof', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover os pneus?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveBulletProof" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)

---DRIFT CHECKING

RegisterNetEvent('jim-mechanic:client:Menu:Drift:Check')
AddEventHandler('jim-mechanic:client:Menu:Drift:Check', function(data)
	vehProps = QBCore.Functions.GetVehicleProperties(data.vehicle)
	if data.mod == "✔ Instalado" then
		TriggerEvent('jim-mechanic:client:Menu:Drift', data)
	else
		TriggerEvent('jim-mechanic:client:Menu')
		TriggerEvent("QBCore:Notify", "Pneus de Drift não instalados", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Menu:Drift', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[data.modelName].name.." "..QBCore.Shared.Vehicles[data.modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[data.modelName].price.."€ | Matrícula: ["..data.plate.."]" },
		{ isMenuHeader = true, header = "Queres mesmo remover os pneus?"},
		{ header = "", txt = "Sim", params = { event = "jim-mechanic:client:giveDrift" } },
		{ header = "", txt = "Não", params = { event = "jim-mechanic:client:Menu" } },
	})
end)