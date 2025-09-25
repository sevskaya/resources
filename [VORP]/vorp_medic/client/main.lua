local Lib <const>              = Import({ "/configs/config", "/languages/translation", "prompts", "blips" })
local Config <const>           = Lib.Config --[[@as vorp_medic]]
local Translation <const>      = Lib.Translation --[[@as vorp_medic_translation]]
local Prompts <const>          = Lib.Prompts --[[@as PROMPTS]]
local Blips <const>            = Lib.Blips --[[@as MAP]]

local Core <const>             = exports.vorp_core:GetCore()
local MenuData <const>         = exports.vorp_menu:GetMenuData()
local T <const>                = Translation.Langs[Config.Lang]

local blip                     = 0
local prompts <const>          = {}

local GetActivePlayers <const> = GetActivePlayers
local GetEntityCoords <const>  = GetEntityCoords
local GetPlayerPed <const>     = GetPlayerPed


local function getClosestPlayer()
    local players <const> = GetActivePlayers()
    local coords <const> = GetEntityCoords(PlayerPedId())

    for _, value in ipairs(players) do
        if PlayerId() ~= value then
            local targetPed <const> = GetPlayerPed(value)
            local targetCoords <const> = GetEntityCoords(targetPed)
            local distance <const> = #(coords - targetCoords)
            if distance < 3.0 then
                return true, targetPed, value
            end
        end
    end
    return false, nil
end

local function getPlayerJob()
    local job <const> = LocalPlayer.state.Character.Job
    return Config.MedicJobs[job]
end

local function isOnDuty()
    if not LocalPlayer.state.isMedicDuty then
        Core.NotifyObjective(T.Duty.YouAreNotOnDuty, 5000)
        return false
    end
    return true
end

local function createBlips()
    for _, value in pairs(Config.Stations) do
        Blips:Create('coords', {
            Pos = value.Coords,
            Blip = Config.Blips.Style,
            Options = {                       -- optional
                sprite = Config.Blips.Sprite, --string or integer if type is entity or coords
                name = value.Name,
                modifier = Config.Blips.Color,
            },
        })
    end
end

local function registerLocations()
    for key, value in pairs(Config.Stations) do
        local data = {
            sleep = 800,
            locations = {
                { coords = value.Coords,                label = value.Name,                distance = 2.0 },
                { coords = value.Storage[key].Coords,   label = value.Storage[key].Name,   distance = 1.5 },
                { coords = value.Teleports[key].Coords, label = value.Teleports[key].Name, distance = 2.0 },
            },
            prompts = {
                {
                    type = T.Menu.Press,
                    key = Config.Keys.B,
                    label = 'press',
                    mode = 'Standard',
                },
            }
        }
        local prompt <const> = Prompts:Register(data, function(prompt, index, self)
            if index == 2 then
                if isOnDuty() then
                    local isAnyPlayerClose <const> = getClosestPlayer()
                    if not isAnyPlayerClose then
                        TriggerServerEvent("vorp_medic:Server:OpenStorage", key)
                    else
                        Core.NotifyObjective(T.Error.PlayerNearbyCantOpenInventory, 5000)
                    end
                end
            end

            if index == 3 then
                if isOnDuty() then
                    OpenTeleportMenu(key)
                end
            end

            if index == 1 then
                local job <const> = LocalPlayer.state.Character.Job
                if Config.MedicJobs[job] then
                    OpenDoctorMenu()
                else
                    Core.NotifyObjective(T.Error.OnlyDoctorsCanOpenMenu, 5000)
                end
            end
        end, true) -- auto start on register

        table.insert(prompts, prompt)
    end
end


RegisterNetEvent("vorp_medic:Client:JobUpdate", function()
    local hasJob = getPlayerJob()

    -- lost job so destroy them
    if not hasJob then
        for _, value in pairs(prompts) do
            value:Destroy()
        end
        table.wipe(prompts)
        return
    end

    -- already exists no need to register or start them
    if #prompts > 0 then
        return
    end

    -- player was given the job
    registerLocations()
end)

CreateThread(function()
    repeat Wait(5000) until LocalPlayer.state.IsInSession
    createBlips()

    local hasJob <const> = getPlayerJob()
    if not hasJob then return end

    registerLocations()
end)

function OpenDoctorMenu()
    MenuData.CloseAll()
    local elements <const> = {
        {
            label = T.Menu.HirePlayer,
            value = "hire",
            desc = T.Menu.HirePlayer .. "<br><br><br><br><br><br><br><br><br><br><br><br>"
        },
        {
            label = T.Menu.FirePlayer,
            value = "fire",
            desc = T.Menu.FirePlayer .. "<br><br><br><br><br><br><br><br><br><br><br><br>"
        }
    }

    MenuData.Open("default", GetCurrentResourceName(), "OpenDoctorMenu", {
        title = T.Menu.DoctorMenu,
        subtext = T.Menu.HireFireMenu,
        align = Config.Align,
        elements = elements,

    }, function(data, _)
        if data.current.value == "hire" then
            OpenHireMenu()
        elseif data.current.value == "fire" then
            local MyInput <const> = {
                type = "enableinput",
                inputType = "input",
                button = T.Player.Confirm,
                placeholder = T.Player.PlayerId,
                style = "block",
                attributes = {
                    inputHeader = T.Menu.FirePlayer,
                    type = "number",
                    pattern = "[0-9]",
                    title = T.Player.OnlyNumbersAreAllowed,
                    style = "border-radius: 10px; background-color: ; border:none;",
                }
            }

            local res = exports.vorp_inputs:advancedInput(MyInput)
            res = tonumber(res)
            if res and res > 0 then
                TriggerServerEvent("vorp_medic:server:firePlayer", res)
            end
        end
    end, function(_, menu)
        menu.close()
    end)
end

function OpenHireMenu()
    MenuData.CloseAll()
    local elements <const> = {}
    for key, _ in pairs(Config.MedicJobs) do
        table.insert(elements, { label = T.Jobs.Job .. ": " .. key, value = key, desc = T.Jobs.Job .. key })
    end

    MenuData.Open("default", GetCurrentResourceName(), "OpenHireFireMenu", {
        title = T.Menu.HireFireMenu,
        subtext = T.Menu.SubMenu,
        elements = elements,
        align = Config.Align,
        lastmenu = "OpenDoctorMenu"

    }, function(data, menu)
        if (data.current == "backup") then
            return _G[data.trigger]()
        end

        menu.close()
        local MyInput <const> = {
            type = "enableinput",
            inputType = "input",
            button = T.Player.Confirm,
            placeholder = T.Player.PlayerId,
            style = "block",
            attributes = {
                inputHeader = T.Menu.HirePlayer,
                type = "number",
                pattern = "[0-9]",
                title = T.Player.OnlyNumbersAreAllowed,
                style = "border-radius: 10px; background-color: ; border:none;",
            }
        }

        local res             = exports.vorp_inputs:advancedInput(MyInput)
        res                   = tonumber(res)
        if res and res > 0 then
            TriggerServerEvent("vorp_medic:server:hirePlayer", res, data.current.value)
        end
    end, function(_, menu)
        menu.close()
    end)
end

function OpenTeleportMenu(location)
    MenuData.CloseAll()
    local elements = {}
    for key, value in pairs(Config.Teleports) do
        if location then
            if location ~= key then
                table.insert(elements, {
                    label = key,
                    value = key,
                    desc = T.Teleport.TeleportTo .. ": " .. value.Name
                })
            end
        else
            table.insert(elements, {
                label = key,
                value = key,
                desc = T.Teleport.TeleportTo .. ": " .. value.Name
            })
        end
    end

    MenuData.Open("default", GetCurrentResourceName(), "OpenTeleportMenu", {
        title = T.Teleport.TeleportMenu,
        subtext = T.Menu.SubMenu,
        align = Config.Align,
        elements = elements,

    }, function(data, menu)
        menu.close()
        local coords <const> = Config.Teleports[data.current.value].Coords
        DoScreenFadeOut(1000)
        repeat Wait(0) until IsScreenFadedOut()
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, false)
        repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId()) == 1
        DoScreenFadeIn(1000)
        repeat Wait(0) until IsScreenFadedIn()
    end, function(_, menu)
        menu.close()
    end)
end

local function OpenMedicMenu()
    MenuData.CloseAll()
    local isONduty <const> = LocalPlayer.state.isMedicDuty
    local label <const> = isONduty and T.Duty.OffDuty or T.Duty.OnDuty
    local desc <const> = isONduty and T.Duty.GoOffDuty or T.Duty.GoOnDuty
    local elements <const> = {
        {
            label = label,
            value = "duty",
            desc = desc .. "<br><br><br><br><br><br><br><br><br><br><br><br>"
        }
    }

    if Config.UseTeleportsMenu then
        table.insert(elements, {
            label = T.Teleport.TeleportTo,
            value = "teleports",
            desc = T.Teleport.TeleportToDifferentLocations .. "<br><br><br><br><br><br><br><br><br><br><br><br>"
        })
    end

    MenuData.Open("default", GetCurrentResourceName(), "OpenMedicMenu", {
        title = T.Menu.DoctorMenu,
        subtext = T.Menu.SubMenu,
        align = Config.Align,
        elements = elements,

    }, function(data, menu)
        if data.current.value == "teleports" then
            OpenTeleportMenu()
        elseif data.current.value == "duty" then
            local result <const> = Core.Callback.TriggerAwait("vorp_medic:server:checkDuty")
            if result then
                Core.NotifyObjective(T.Duty.YouAreNowOnDuty, 5000)
            else
                Core.NotifyObjective(T.Duty.YouAreNotOnDuty, 5000)
            end
            menu.close()
        end
    end, function(_, menu)
        menu.close()
    end)
end

local function playAnimation(dict, anim)
    local ped <const> = PlayerPedId()
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        repeat Wait(0) until HasAnimDictLoaded(dict)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, 2000, 1, 0, false, false, false)
end

RegisterNetEvent("vorp_medic:Client:OpenMedicMenu", function()
    OpenMedicMenu()
end)

RegisterNetEvent("vorp_medic:Client:HealAnim", function()
    playAnimation("script_mp@player@healing", "healing_male")
end)

RegisterNetEvent("vorp_medic:Client:ReviveAnim", function()
    playAnimation("mech_revive@unapproved", "revive")
end)

RegisterNetEvent("vorp_medic:Client:HealPlayer", function(health, stamina)
    local ped <const> = PlayerPedId()
    local player <const> = PlayerId()
    if health and health > 0 then
        local inner <const> = GetAttributeCoreValue(ped, 0)
        local outter <const> = math.floor(GetPlayerHealth(player)) + 100

        if inner > 99 then
            local newHealth = outter + health
            SetEntityHealth(ped, newHealth, 0)
        else
            local newHealth = inner + health
            SetAttributeCoreValue(ped, 0, newHealth)
        end
    end

    if stamina and stamina > 0 then
        local inner <const> = GetAttributeCoreValue(ped, 1)
        if inner > 99 then
            ChangePedStamina(ped, stamina + 0.0)
        else
            local newStamina = inner + stamina
            SetAttributeCoreValue(ped, 1, newStamina)
        end
    end
end)

RegisterNetEvent("vorp_medic:Client:AlertDoctor", function(targetCoords)
    if blip ~= 0 then return end -- dont allow more than one call

    blip = Blips:Create('coords', {
        Pos = targetCoords,
        Blip = Config.Blips.Style,
        Options = {
            sprite = Config.Blips.Sprite,
            name = T.Alert.playeralert,
            modifier = Config.Blips.Color,
        },
    })

    StartGpsMultiRoute(joaat("COLOR_RED"), true, true)
    AddPointToGpsMultiRoute(targetCoords.x, targetCoords.y, targetCoords.z, false)
    SetGpsMultiRouteRender(true)
    local ped <const> = PlayerPedId()
    repeat Wait(1000) until #(GetEntityCoords(ped) - targetCoords) < 15.0 or blip == 0

    if blip ~= 0 then
        Core.NotifyObjective(T.Alert.ArrivedAtLocation, 5000)
        blip:Remove()
        blip = 0
    end
    ClearGpsMultiRoute()
end)


RegisterNetEvent("vorp_medic:Client:RemoveBlip", function()
    if blip == 0 then return end

    blip:Remove()
    blip = 0
    ClearGpsMultiRoute()
end)
