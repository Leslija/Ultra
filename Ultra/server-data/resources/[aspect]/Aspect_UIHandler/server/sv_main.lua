ESX = nil
QBCore = nil

if Config.Framework == 'ESX' then
    TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)
elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end
