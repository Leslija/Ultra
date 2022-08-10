Citizen.CreateThread(function()
	RequestIpl("k4mb1_ornate_bank_milo_")
	local interiorid = GetInteriorAtCoords(247.9133, 218.0428, 105.2830)

	RefreshInterior(interiorid)
	
end)


Citizen.CreateThread(function()
	RequestIpl("gabz_pillbox_milo_")
  
	local interiorID = GetInteriorAtCoords(311.2546, -592.4204, 42.32737)
  
	if IsValidInterior(interiorID) then
	  RemoveIpl("rc12b_fixed")
	  RemoveIpl("rc12b_destroyed")
	  RemoveIpl("rc12b_default")
	  RemoveIpl("rc12b_hospitalinterior_lod")
	  RemoveIpl("rc12b_hospitalinterior")
	  RefreshInterior(interiorID)
	end
  end)
  
  

Citizen.CreateThread(function()
	local interiorid = GetInteriorAtCoords(1113.974, -1806.528, 20.0346)
	
	ActivateInteriorEntitySet(interiorid, "car_meet_set_01")
    --ActivateInteriorEntitySet(interiorid, "car_meet_set_02")
    --ActivateInteriorEntitySet(interiorid, "car_meet_set_03")
    --ActivateInteriorEntitySet(interiorid, "car_meet_set_04")
    ActivateInteriorEntitySet(interiorid, "car_meet_set_05")
    ActivateInteriorEntitySet(interiorid, "car_meet_set_06")
    ActivateInteriorEntitySet(interiorid, "car_meet_set_07")
    ActivateInteriorEntitySet(interiorid, "car_meet_set_08")

	RefreshInterior(interiorid)
	
end)