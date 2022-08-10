function test()
     TriggerServerEvent('aspect_paycheck:server:increase_moeny')
end

CreateThread(function()
     Wait(1000)
     test()
end)
