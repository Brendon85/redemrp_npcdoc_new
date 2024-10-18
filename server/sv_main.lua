RedEM = exports["redem_roleplay"]:RedEM()

RegisterServerEvent("redemrp_npc:doctormoney")
AddEventHandler("redemrp_npc:doctormoney", function()
    local _source = source

    local user = RedEM.GetPlayer(_source)
    local identifier = user.getIdentifier()
    local Character = user.getSessionVar("charid") 
	local money = user.getMoney()
    local price = Config.Money
    if money >= price then
        user.removeMoney(price)
        TriggerClientEvent('redemrp_respawn:client:Revived', _source, price)
    else
        TriggerClientEvent('redem_roleplay:NotifyLeft', _source, "you dont have enough money", "cost 50$.", "menu_textures", "menu_icon_alert", 4000)
    end
 end)
--[[
RegisterServerEvent("redemrp_npc:doctor")
AddEventHandler("redemrp_npc:doctor", function()
    local _source = source
    local doctorsOnline = 0

    local players = GetPlayers()
    for _, playerId in pairs(players) do
        local player = RedEM.GetPlayer(playerId)
        if player.getJob() == "doctor" then
            doctorsOnline = doctorsOnline + 1
        end
    end

    if doctorsOnline >= Config.Doctor then
        TriggerClientEvent("redemrp_respawn:client:Revived", _source)
    else
        TriggerClientEvent(
            "redem_roleplay:NotifyLeft",
            source,
            "Not enough doctors online",
            "You need at least " .. Config.Doctor .. " doctors online to use this service.",
            "menu_textures",
            "menu_icon_alert",
            4000
        )
    end
end)
--]]

