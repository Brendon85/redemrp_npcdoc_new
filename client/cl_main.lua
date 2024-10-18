RedEM = exports["redem_roleplay"]:RedEM()

local healing = false

Citizen.CreateThread(function()
    local pedModel = GetHashKey("CS_EagleFlies")
    local pedHandle
    local pedLocations = {
        {x = 417.31, y = 2231.47, z = 254.54, h = 209.66},--wapiti
    }

    while true do
        Citizen.Wait(1)

        if not DoesEntityExist(pedHandle) then
            RequestModel(pedModel)

            while not HasModelLoaded(pedModel) do
                Wait(100)
            end

            pedHandle = CreatePed(pedModel, pedLocations[1].x, pedLocations[1].y, pedLocations[1].z, pedLocations[1].h, false, true)
            GetGroundZAndNormalFor_3dCoord(pedLocations[1].x, pedLocations[1].y, pedLocations[1].z, false, 16)
            SetPedRandomComponentVariation(pedHandle, 0)
            SetBlockingOfNonTemporaryEvents(pedHandle, true)
            PlaceEntityOnGroundProperly(pedHandle)
            SetEntityInvincible(pedHandle, true)
            SetPedCanBeTargettedByPlayer(pedHandle, PlayerPedId(), false)
            FreezeEntityPosition(pedHandle, true)
        end

        for i = 1, #pedLocations do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), 0), pedLocations[i].x, pedLocations[i].y, pedLocations[i].z, true)
            if distance < 3.0 then
                RedEM.Functions.DrawText3D(pedLocations[i].x, pedLocations[i].y, pedLocations[i].z + 1, "Press [G] To be revived by the Indian tribe?")

                if IsControlJustReleased(0, 0x760A9C6F) then -- G
                    local playerPed = PlayerPedId()
                    if IsPedDeadOrDying(playerPed) then
                        TriggerServerEvent('redemrp_npc:doctormoney')
                    else
                        TriggerEvent('redem_roleplay:NotifyLeft', 'You are currently alive', 'you can\'t be revived by the Indian tribe!', 'menu_textures', 'menu_icon_alert', 4000)
                    end
                end
            end
        end
    end
end)

function IsPlayerNearCoords(x, y, z, radius)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < radius then
        return true
    end
end

function DisplayNPCText(text, s1, s2, x, y, r, g, b, font)
    SetTextScale(s1, s2)
    SetTextColor(r, g, b, 255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1, 0, 0, 0, 200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end
