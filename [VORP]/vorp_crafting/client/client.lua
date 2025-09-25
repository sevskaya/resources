local progressbar = exports.vorp_progressbar:initiate()
local iscrafting = false
local blipsadded = false

local function GetCoordDistance(v1, v2)
    local v = vector3(v1.x, v1.y, v1.z)
    local x = vector3(v2.x, v2.y, v2.z)
    return #(v - x)
end

CreateThread(function()
    repeat Wait(4000) until LocalPlayer.state.IsInSession
    UIPrompt.initialize()

    while true do
        local sleep = 1000 -- optimize thread
        local player = PlayerPedId()
        local Coords = GetEntityCoords(player)
        local campfire = false
        if (not uiopen and not iscrafting) then
            if Config.CraftingPropsEnabled and CheckJobClient(Config.CampfireJobLock) then -- dont allow check if player dont have job
                for _, v in pairs(Config.CraftingProps) do
                    if iscrafting == false and uiopen == false and IsEntityDead(player) == false then
                        if type(v.prop) == "table" then
                            for _, vv in pairs(v.prop) do
                                campfire = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, Config.Distances.campfire, GetHashKey(vv), false)
                                if campfire then break end
                            end
                        else
                            local prop = v.prop --[[@as string]]
                            campfire = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, Config.Distances.campfire,
                                GetHashKey(prop), false)
                            if not campfire then break end
                        end

                        if campfire then
                            sleep = 0
                            UIPrompt.activate(v.title)
                            if UiPromptHasStandardModeCompleted(CraftPrompt, 0) then
                                local jobcheck = CheckJob(Config.CampfireJobLock) -- security check
                                if jobcheck then
                                    VUI.OpenUI({ id = v.title:lower() })
                                end
                            end
                        end
                    end
                end
            end

            local blipcount = 0
            for k, loc in ipairs(Config.Locations) do
                local jobcheck = CheckJobClient(loc.Job)
                if jobcheck and uiopen == false and IsEntityDead(player) == false then
                    if loc.Blip and blipsadded == false and loc.Blip.enable then
                        blipcount = blipcount + 1
                        Blips.addBlipForCoords(k, loc.name, loc.Blip.Hash, loc.x, loc.y, loc.z)
                    end

                    local dist = GetCoordDistance(loc, Coords)
                    if Config.Distances.locations > dist then
                        sleep = 0
                        UIPrompt.activate(loc.name)
                        if UiPromptHasStandardModeCompleted(CraftPrompt, 0) then
                            jobcheck = CheckJob(loc.Job)
                            if jobcheck then
                                VUI.OpenUI(loc)
                            end
                        end
                    end
                end
            end

            if blipcount > 0 then
                blipsadded = true
            end
        end

        if (uiopen or iscrafting) then
            sleep = 0
            UiPromptDisablePromptsThisFrame()
        end

        Wait(sleep)
    end
end)

RegisterNetEvent("vorp:crafting")
AddEventHandler("vorp:crafting", function(animation)
    local playerPed = PlayerPedId()
    iscrafting = true

    VUI.Animate()

    if not animation then
        animation = "craft"
    end

    Animations.playAnimation(playerPed, animation)
    progressbar.start(_U('Crafting'), Config.CraftTime, function()
        Animations.endAnimation(animation)
        TriggerEvent("vorp:TipRight", _U('FinishedCrafting'), 4000)
        VUI.Refocus()
        iscrafting = false
    end)
end)
