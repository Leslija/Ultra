local blips = {
  {title="6STR Tunners", colour=48, id=446, x = 165.18, y = -3041.01, z = 5.9},
  {title="Bennys", colour=1, id=446, x = -205.55, y = -1303.6, z = 31.24},
  
}


Citizen.CreateThread(function()
  
  for _, info in pairs(blips) do
  info.blip = AddBlipForCoord(info.x, info.y, info.z)

  SetBlipSprite(info.blip, info.id)
  SetBlipDisplay(info.blip, 4)
  SetBlipScale(info.blip, 0.5)
  SetBlipColour(info.blip, info.colour)

  SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(info.title)
  EndTextCommandSetBlipName(info.blip)

  RadiusBlip = AddBlipForRadius(info.x, info.y, info.z, 100.0)
  SetBlipRotation(RadiusBlip, 0)
  SetBlipAlpha(RadiusBlip, 0)
  SetBlipColour(RadiusBlip, 1)
end
end)

