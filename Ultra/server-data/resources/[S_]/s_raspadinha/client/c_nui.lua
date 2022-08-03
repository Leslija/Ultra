local inMenu = false

RegisterNetEvent("s_raspadinha:nuiOpenCard")
AddEventHandler("s_raspadinha:nuiOpenCard", function(key, price, amount, price_type, price_label)
  if inMenu then return end
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = 'openScratch',
    key = key,
    price = price,
    amount = amount,
    price_type = price_type,
    price_label = price_label,
    win_message = "Ganhas-te!",
    lose_message = "Perdes-te :(",
    currency = "€",
    scratchAmount = Config.ScratchAmount,
    resourceName = GetCurrentResourceName(),
    debug = debugIsEnabled
  })
  inMenu = true
end)

RegisterNUICallback('nuiCloseCard', function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeScratch'})
  TriggerEvent("s_raspadinha:stopScratchingEmote")
  TriggerServerEvent('s_raspadinha:stopScratching', data.price, data.amount, data.type)
  inMenu = false
end)