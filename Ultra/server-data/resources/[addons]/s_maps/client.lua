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
  
  