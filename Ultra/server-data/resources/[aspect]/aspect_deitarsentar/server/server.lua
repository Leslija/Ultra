local oArray = {}
local oPlayerUse = {}


AddEventHandler('playerDropped', function()
    local oSource = source
    if oPlayerUse[oSource] ~= nil then
        oArray[oPlayerUse[oSource]] = nil
        oPlayerUse[oSource] = nil
    end
end)



RegisterServerEvent('aspect_deitarsentar:Server:Enter')
AddEventHandler('aspect_deitarsentar:Server:Enter', function(object, objectcoords)
    local oSource = source
    if oArray[objectcoords] == nil then
        oPlayerUse[oSource] = objectcoords
        oArray[objectcoords] = true
        TriggerClientEvent('aspect_deitarsentar:Client:Animation', oSource, object, objectcoords)
    end
end)


RegisterServerEvent('aspect_deitarsentar:Server:Leave')
AddEventHandler('aspect_deitarsentar:Server:Leave', function(objectcoords)
    local oSource = source

    oPlayerUse[oSource] = nil
    oArray[objectcoords] = nil
end)

