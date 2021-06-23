-- Locales
VB_AC.IsAdmin = false -- DON'T TOUCH THIS
local isusingfuncs = false
local isnoclipping = false
local noclipspeed = 1
local isnoclippingveh = false
local noclipveh = 1
local Players = {}

-- Thread

Citizen.CreateThread(function()
    Citizen.Wait(2500)
    TriggerServerEvent('SBmQ5ucMg4WGbpPHoSTl')
    Citizen.Wait(7500)
    while VB_AC.IsAdmin do
        Citizen.Wait(0)
        if isusingfuncs then
            if isnoclipping then
                local _ped = PlayerPedId()
                local _pcoords = GetEntityCoords(_ped)
                local _x = _pcoords.x
                local _y = _pcoords.y
                local _z = _pcoords.z
                local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
                local pitch = GetGameplayCamRelativePitch()
                local x = -math.sin(heading*math.pi/180.0)
                local y = math.cos(heading*math.pi/180.0)
                local z = math.sin(pitch*math.pi/180.0)
                local len = math.sqrt(x*x+y*y+z*z)
                if len ~= 0 then
                  x = x/len
                  y = y/len
                  z = z/len
                end
                local _camx = x
                local _camy = y
                local _camz = z
                if IsControlPressed(0, 32) then
                    _x = _x + noclipspeed * _camx
                    _y = _y + noclipspeed * _camy
                    _z = _z + noclipspeed * _camz
                elseif IsControlPressed(0, 33) then
                    _x = _x - noclipspeed * _camx
                    _y = _y - noclipspeed * _camy
                    _z = _z - noclipspeed * _camz
                end
                SetEntityVisible(_ped, false)
                SetEntityVelocity(_ped, 0.05,  0.05,  0.05)
                SetEntityCoordsNoOffset(_ped, _x, _y, _z, true, true, true) 
            end
            if isnoclippingveh then
                local _ped = GetVehiclePedIsIn(PlayerPedId(), false)
                local _pcoords = GetEntityCoords(_ped)
                local _x = _pcoords.x
                local _y = _pcoords.y
                local _z = _pcoords.z
                local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
                local pitch = GetGameplayCamRelativePitch()
                local x = -math.sin(heading*math.pi/180.0)
                local y = math.cos(heading*math.pi/180.0)
                local z = math.sin(pitch*math.pi/180.0)
                local len = math.sqrt(x*x+y*y+z*z)
                if len ~= 0 then
                  x = x/len
                  y = y/len
                  z = z/len
                end
                local _camx = x
                local _camy = y
                local _camz = z
                if IsControlPressed(0, 32) then
                    _x = _x + noclipveh * _camx
                    _y = _y + noclipveh * _camy
                    _z = _z + noclipveh * _camz
                elseif IsControlPressed(0, 33) then
                    _x = _x - noclipveh * _camx
                    _y = _y - noclipveh * _camy
                    _z = _z - noclipveh * _camz
                end
                SetEntityVisible(_ped, false)
                SetEntityVelocity(_ped, 0.05,  0.05,  0.05)
                SetEntityCoordsNoOffset(_ped, _x, _y, _z, true, true, true) 
            end
        end
    end
end)
-- MENU 2
local menu2 = MenuV:CreateMenu(false, "VB-AC Admin Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: Admin Menu')
local menu2_noclip = menu2:AddCheckbox({ icon = '🐦', label = 'NoClip', description = 'Activate/Deactivate NoClip', value = 'n' })
local menu2_range = menu2:AddRange({ icon = '💨', label = 'NoClip Speed', description = 'Set Noclip Speed', min = 0, max = 10, value = 0, saveOnUpdate = true })
local menu2_godmode = menu2:AddCheckbox({ icon = '🔱', label = 'GodMode', description = 'Activate/Deactivate GodMode',value = 'n' })
local menu2_invisible = menu2:AddCheckbox({ icon = '👻', description = 'Activate/Deactivate Invisibility', label = 'Invisible', value = 'n' })
local menu2_suicide = menu2:AddButton({ icon = '⚰️', description = 'Kill player', label = 'Suicide' })
local menu2_revive = menu2:AddButton({ icon = '🌈️', description = 'Revive yourself', label = 'Revive' })
local menu2_healplayer = menu2:AddButton({ icon = '✨', description = 'Heal yourself', label = 'Heal' })
local menu2_givearmor = menu2:AddButton({ icon = '🛡️', description = 'Give Yourself Armor', label = 'Give Armor' })
local menu2_giveallweapons = menu2:AddButton({ icon = '🔫', description = 'Give All Weapons to Yourself', label = 'Give All Weapons' })
local menu2_removeallweapons = menu2:AddButton({ icon = '❌', description = 'Remove All of Your Weapons', label = 'Remove All Weapons' })
local menu2_showcoords = menu2:AddButton({ icon = '🎯', description = 'Print Player Coords (F8)', label = 'Print Coords (F8)' })
menu2_noclip:On('check', function(item)
    isusingfuncs = true
    isnoclipping = true
end)
menu2_noclip:On('uncheck', function(item)
    isusingfuncs = false
    isnoclipping = false
    SetEntityVisible(PlayerPedId(), true)
end)
menu2_range:On('change', function(item, newValue, oldValue)
    noclipspeed = newValue
end)
menu2_godmode:On('check', function(item)
    SetEntityInvincible(PlayerPedId(), true)
end)
menu2_godmode:On('uncheck', function(item)
    SetEntityInvincible(PlayerPedId(), false)
end)
menu2_invisible:On('check', function(item)
    SetEntityVisible(PlayerPedId(), false)
end)
menu2_invisible:On('uncheck', function(item)
    SetEntityVisible(PlayerPedId(), true)
end)
menu2_suicide:On('select', function(item)
    SetEntityHealth(PlayerPedId(), 0)
end)
menu2_revive:On('select', function(item)
    TriggerEvent('esx_ambulancejob:revive') -- Change trigger if needed
end)
menu2_healplayer:On('select', function(item)
    local _ped = PlayerPedId()
    SetEntityHealth(_ped, 200)
    ClearPedBloodDamage(_ped)
    ResetPedVisibleDamage(_ped)
    ClearPedLastWeaponDamage(_ped)
end)
menu2_givearmor:On('select', function(item)
    SetPedArmour(PlayerPedId(), 100)
end)
local weapons = {"WEAPON_UNARMED", "WEAPON_KNIFE", "WEAPON_KNUCKLE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_SWITCHBLADE", "WEAPON_PISTOL", "WEAPON_PISTOL_MK2", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_SNSPISTOL", "WEAPON_HEAVYPISTOL", "WEAPON_VINTAGEPISTOL", "WEAPON_STUNGUN", "WEAPON_FLAREGUN", "WEAPON_MARKSMANPISTOL", "WEAPON_REVOLVER", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_MINISMG", "WEAPON_SMG_MK2", "WEAPON_ASSAULTSMG", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_COMBATMG_MK2", "WEAPON_COMBATPDW", "WEAPON_GUSENBERG", "WEAPON_RAYPISTOL", "WEAPON_MACHINEPISTOL", "WEAPON_ASSAULTRIFLE", "WEAPON_ASSAULTRIFLE_MK2", "WEAPON_CARBINERIFLE", "WEAPON_CARBINERIFLE_MK2", "WEAPON_ADVANCEDRIFLE", "WEAPON_SPECIALCARBINE", "WEAPON_BULLPUPRIFLE", "WEAPON_COMPACTRIFLE", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_MUSKET", "WEAPON_HEAVYSHOTGUN", "WEAPON_DBSHOTGUN", "WEAPON_SNIPERRIFLE", "WEAPON_HEAVYSNIPER", "WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_STINGER", "WEAPON_FIREWORK", "WEAPON_HOMINGLAUNCHER", "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_PROXMINE", "WEAPON_MINIGUN", "WEAPON_RAILGUN", "WEAPON_POOLCUE", "WEAPON_BZGAS", "WEAPON_SMOKEGRENADE", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNOWBALL", "WEAPON_FLARE", "WEAPON_BALL"}
menu2_giveallweapons:On('select', function(item)
    for _, weapon in pairs(weapons) do
        local _whash = GetHashKey(weapon)
        GiveWeaponToPed(PlayerPedId(), _whash, 3000)
    end
end)
menu2_removeallweapons:On('select', function(item)
    for _, weapon in pairs(weapons) do
        local _whash = GetHashKey(weapon)
        RemoveWeaponFromPed(PlayerPedId(), _whash)
    end
end)

menu2_showcoords:On('select', function(item)
    local _coords = GetEntityCoords(PlayerPedId())
    print(_coords)
end)

-- MENU 3
local menu3 = MenuV:CreateMenu(false, "VB-AC: Connected Players", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: Connected Players')
menu3:On('open', function(m)
    m:ClearItems()
    TriggerServerEvent('tBtysfoC96Vx4JK8p3pW')
    Citizen.Wait(500)
    for k,v in pairs(Players) do
        local player = menu3:AddButton({label = v.name, value = v.name, description = "Server ID: "..v.id})
    end
end)

RegisterNetEvent("ppskINSwjmAXyHcpLLp")
AddEventHandler("ppskINSwjmAXyHcpLLp", function(playerlist)
    Players = playerlist
end)

-- MENU 4
local menu4 = MenuV:CreateMenu(false, "VB-AC Server Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: Server Tools')
local menu4_deletevehicles = menu4:AddButton({ icon = '🚙', label = 'Delete All Vehicles', description = 'Delete All Vehicles in Server', value = menu4_deletevehicles })
local menu4_deleteprops = menu4:AddButton({ icon = '🏢', label = 'Delete All Props', value = deleteprops, description = 'Delete all Entities in Server' })
local menu4_deletepeds = menu4:AddButton({ icon = '🧍', label = 'Delete All Peds', value = menu4_deletepeds, description = 'Delete all Peds in server' })
menu4_deletevehicles:On('select', function(item)
    TriggerServerEvent('cq1PxSiVi0iCw0maULS3')
end)

menu4_deleteprops:On('select', function(item)
    TriggerServerEvent('xsc8yaDNYGoCMvAWogff')
end)

menu4_deletepeds:On('select', function(item)
    TriggerServerEvent('m0QCCVqpGuCSLNBc60Tc')
end)

-- MENU 5
local menu5 = MenuV:CreateMenu(false, "VB-AC Teleport Options", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: Teleport Options')
local menu5_tptowaypoint = menu5:AddButton({ icon = '📍', label = 'TP To Waypoint', description = 'TP To Waypoint' })
menu5_tptowaypoint:On('select', function(item) -- Thanks to Qalle (ESX_Marker for this :) (https://github.com/qalle-git/esx_marker)
    local _waypoint = GetFirstBlipInfoId(8)

    if DoesBlipExist(_waypoint) then
        local waypointCoords = GetBlipInfoIdCoord(_waypoint)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                break
            end

            Citizen.Wait(5)
        end
    end
end)

-- MENU 6
local menu6 = MenuV:CreateMenu(false, "VB-AC Vehicle Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: Vehicle Tools')
local menu6_fixcar = menu6:AddButton({ icon = '🔧', label = 'Fix Car', description = 'Fix Car' })
local menu6_godmode = menu6:AddCheckbox({ icon = '🔱', label = 'GodMode', description = 'GodMode', value = 'n' })
local menu6_noclip = menu6:AddCheckbox({ icon = '🐦', label = 'NoClip (Vehicle)', description = 'Noclip with a Vehicle', value = 'n' })
local menu6_nocliprange = menu6:AddRange({ icon = '💨', label = 'Noclip Speed', min = 0, max = 10, value = 0, saveOnUpdate = true, description = 'Set NoClip Speed' })
local menu6_engineboost = menu6:AddRange({ icon = '👩‍🦼', label = 'Engine Boost', min = 0, max = 10, value = 0, saveOnUpdate = true, description = 'Set Vehicle Engine Boost' })
menu6_fixcar:On('select', function(item)
    local _ped = PlayerPedId()
    local _vehiclein = GetVehiclePedIsIn(_ped)
    SetVehicleFixed(_vehiclein)
    SetVehicleDeformationFixed(_vehiclein)
    SetVehicleUndriveable(_vehiclein, false)
    SetVehicleEngineOn(_vehiclein, true, true)
end)
menu6_godmode:On('check', function(item)
    local _ped = PlayerPedId()
    local _vehiclein = GetVehiclePedIsIn(_ped)
    SetEntityInvinicible(_vehiclein, true)
end)
menu6_godmode:On('uncheck', function(item)
    local _ped = PlayerPedId()
    local _vehiclein = GetVehiclePedIsIn(_ped)
    SetEntityInvinicible(_vehiclein, false)
end)
menu6_noclip:On('check', function(item)
    isusingfuncs = true
    isnoclippingveh = true
end)
menu6_noclip:On('uncheck', function(item)
    isusingfuncs = false
    isnoclippingveh = false
    SetEntityVisible(PlayerPedId(), true)
    local _vehiclein = GetVehiclePedIsIn(PlayerPedId())
    SetEntityVisible(_vehiclein, true)
end)
menu6_nocliprange:On('change', function(item, newValue, oldValue)
    noclipveh = newValue
end)
menu6_engineboost:On('change', function(item, newValue, oldValue)
    local _veh = GetVehiclePedIsIn(PlayerPedId())
    local _boost = 1.0
    if newValue ~= 1 then
        _boost = newValue * 50.0
    end 
    SetVehicleEnginePowerMultiplier(_veh, _boost)
end)

-- MENU 7
local menu7 = MenuV:CreateMenu(false, "VB-AC Admin Tools", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: TP Tools Tools')
local menu7_acinfo = menu7:AddButton({ icon = 'ℹ️', label = 'AntiCheat Version: 3.0', description = 'discord.com/invite/EAU2DM4hdn' })
local menu7_creatorac = menu7:AddButton({ icon = 'ℹ️', label = 'VB-AC by VisiBait#0712', description = 'discord.com/invite/EAU2DM4hdn' })

-- PRINCIPAL MENU
local menu = MenuV:CreateMenu(false, "Welcome to VB-AC's Admin Menu", 'centerright', 255, 0, 0, 'size-125', 'example', 'menuv', 'VB-AC: Main Menu')
local menu_admintools = menu:AddButton({ icon = '🔥', label = 'Admin Tools', value = menu2, description = 'Open Admin Tools' })
local menu_connectedplayers = menu:AddButton({ icon = '⛹️', label = 'Connected Players', value = menu3, description = 'See the Player List' })
local menu_servertools = menu:AddButton({ icon = '🤖', label = 'Server Tools', value = menu4, description = 'Open Server Tools' })
local menu_tpoptions = menu:AddButton({ icon = '📍', label = 'Teleport Options', value = menu5, description = 'Open Teleport Options' })
local menu_vehicleoptions = menu:AddButton({ icon = '🚗', label = 'Vehicle Options', value = menu6, description = 'Open Vehicle Options' })
local menu_infoanticheat = menu:AddButton({ icon = 'ℹ️', label = 'Information', value = menu7, description = 'See the Anticheat Version' })

RegisterCommand('vbacmenu', function()
    if VB_AC.IsAdmin then
        menu:Open()
    end
end, false)

RegisterKeyMapping('vbacmenu', "VB-AC Admin Menu", 'keyboard', 'INSERT')
