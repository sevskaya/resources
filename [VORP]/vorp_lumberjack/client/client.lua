local CuttingPrompt
local active = false
local tool, hastool, UsePrompt, PropPrompt
local swing = 0
local nearby_tree
local T = Translation.Langs[Lang]
local TreeGroup = GetRandomIntInRange(0, 0xffffff)

local function CreateStartChopPrompt()
    local str = T.PromptLabels.cutLabel
    CuttingPrompt = UiPromptRegisterBegin()
    UiPromptSetControlAction(CuttingPrompt, Config.ChopPromptKey)
    str = VarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(CuttingPrompt, str)
    UiPromptSetEnabled(CuttingPrompt, true)
    UiPromptSetVisible(CuttingPrompt, true)
    UiPromptSetHoldMode(CuttingPrompt, 500)
    UiPromptSetGroup(CuttingPrompt, TreeGroup, 0)
    UiPromptRegisterEnd(CuttingPrompt)
end

local function GetTreeNearby(coords, radius, hash_filter)
    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, coords, radius, itemSet, 3, Citizen.ResultAsInteger())
    local found_entity

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            local model_hash = GetEntityModel(entity)

            if hash_filter[model_hash] then
                local tree_coords = GetEntityCoords(entity)
                local tree_x, tree_y, tree_z = table.unpack(tree_coords)

                found_entity = {
                    model_name = hash_filter[model_hash],
                    entity = entity,
                    model_hash = model_hash,
                    vector_coords = tree_coords,
                    x = tree_x,
                    y = tree_y,
                    z = tree_z,
                }

                break
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return found_entity
end

local function isPlayerReadyToChopTrees(player)
    if IsPedOnMount(player) then
        return false
    end

    if IsPedInAnyVehicle(player, false) then
        return false
    end

    if IsPedDeadOrDying(player, false) then
        return false
    end

    if IsEntityInWater(player) then
        return false
    end

    if IsPedClimbing(player) then
        return false
    end

    if not IsPedOnFoot(player) then
        return false
    end

    return true
end

local function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
    CreateThread(function()
        RequestAnimDict(dict)
        local dur = duration or -1
        local flag = flags or 1
        local intro = tonumber(introtiming) or 1.0
        local exit = tonumber(exittiming) or 1.0
        local timeout = 5
        while (not HasAnimDictLoaded(dict) and timeout > 0) do
            timeout = timeout - 1
            if timeout == 0 then
                print("Animation Failed to Load")
            end
            Wait(300)
        end
        TaskPlayAnim(actor, dict, body, intro, exit, dur, flag, 1, false, 0, false, "", true)
    end)
end

local function GetTown(x, y, z)
    return Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 1)
end

local function isInRestrictedTown(restricted_towns, player_coords)
    player_coords = player_coords or GetEntityCoords(PlayerPedId())

    local town_hash = GetTown(player_coords.x, player_coords.y, player_coords.z)

    if town_hash == false then
        return false
    end

    if restricted_towns[town_hash] then
        return true
    end

    return false
end

local function getUnChoppedNearbyTree(allowed_model_hashes, player, player_coords)
    player = player or PlayerPedId()

    if not isPlayerReadyToChopTrees(player) then
        return nil
    end

    player_coords = player_coords or GetEntityCoords(player)
    local found_nearby_tree = GetTreeNearby(player_coords, 1.4, allowed_model_hashes)
    if not found_nearby_tree then
        return nil
    end

    return found_nearby_tree
end


local function convertConfigTreesToHashRegister()
    local model_hashes = {}

    for _, model_name in ipairs(Config.Trees) do
        local model_hash = GetHashKey(model_name)
        model_hashes[model_hash] = model_name
    end

    return model_hashes
end

local function convertConfigTownRestrictionsToHashRegister()
    local restricted_towns = {}

    for _, town_restriction in ipairs(Config.TownRestrictions) do
        if not town_restriction.chop_allowed then
            local town_hash = GetHashKey(town_restriction.name)
            restricted_towns[town_hash] = town_restriction.name
        end
    end

    return restricted_towns
end

local function manageStartChopPrompt(restricted_towns, player_coords)
    local is_promp_enabled = true

    if isInRestrictedTown(restricted_towns, player_coords) then
        is_promp_enabled = false
    end
    UiPromptSetEnabled(CuttingPrompt, is_promp_enabled)
end

-- thread to find close by tree
CreateThread(function()
    repeat Wait(5000) until LocalPlayer.state.IsInSession
    local allowed_tree_model_hashes = convertConfigTreesToHashRegister()
    local restricted_towns = convertConfigTownRestrictionsToHashRegister()

    while true do
        local sleep = 1000
        if not active then
            local player = PlayerPedId()
            local player_coords = GetEntityCoords(player)

            nearby_tree = getUnChoppedNearbyTree(allowed_tree_model_hashes, player, player_coords)
            if nearby_tree then
                manageStartChopPrompt(restricted_towns, player_coords)
            end
        end

        Wait(sleep)
    end
end)

local function FPrompt()
    CreateThread(function()
        PropPrompt = nil
        local str = T.PromptLabels.keepHatchet
        local buttonhash = Config.CancelChopKey
        local holdbutton = 1000
        PropPrompt = UiPromptRegisterBegin()
        UiPromptSetControlAction(PropPrompt, buttonhash)
        str = VarString(10, 'LITERAL_STRING', str)
        UiPromptSetText(PropPrompt, str)
        UiPromptSetEnabled(PropPrompt, false)
        UiPromptSetVisible(PropPrompt, false)
        UiPromptSetHoldMode(PropPrompt, holdbutton)
        UiPromptRegisterEnd(PropPrompt)
    end)
end

local function LMPrompt(hold)
    CreateThread(function()
        UsePrompt = nil
        local str = T.PromptLabels.useHatchet
        local buttonhash = Config.ChopTreeKey
        UsePrompt = UiPromptRegisterBegin()
        UiPromptSetControlAction(UsePrompt, buttonhash)
        str = VarString(10, 'LITERAL_STRING', str)
        UiPromptSetText(UsePrompt, str)
        UiPromptSetEnabled(UsePrompt, false)
        UiPromptSetVisible(UsePrompt, false)
        if hold then
            UiPromptSetHoldIndefinitelyMode(UsePrompt)
        end
        UiPromptRegisterEnd(UsePrompt)
    end)
end


local function releasePlayer()
    if PropPrompt then
        UiPromptSetEnabled(PropPrompt, false)
        UiPromptSetVisible(PropPrompt, false)
    end

    if UsePrompt then
        UiPromptSetEnabled(UsePrompt, false)
        UiPromptSetVisible(UsePrompt, false)
    end

    FreezeEntityPosition(PlayerPedId(), false)
end

local function removeCuttingPrompt()
    if CuttingPrompt then
        UiPromptSetEnabled(CuttingPrompt, false)
        UiPromptSetVisible(CuttingPrompt, false)
    end
end

local function removeToolFromPlayer()
    hastool = false

    if not tool then
        return
    end
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xED00D72F81CF7278, tool, 1, 1)
    DeleteObject(tool)
    Citizen.InvokeNative(0x58F7DB5BD8FA2288, ped) -- Cancel Walk Style
    ClearPedDesiredLocoForModel(ped)
    ClearPedDesiredLocoMotionType(ped)

    tool = nil
end

local function treeFinished(tree)
    swing = 0
    -- rememberTreeAsChopped(tree) -- remember tree as chopped? to then remove it ?
    Wait(2000)
    removeToolFromPlayer()
    active = false
    --  forgetTreeAsChopped(tree)
    TriggerServerEvent("vorp_lumberjack:resetTable", tree)
end

local function EquipTool(toolhash)
    hastool = false
    Citizen.InvokeNative(0x6A2F820452017EA2) -- Clear Prompts from Screen
    if tool then
        DeleteEntity(tool)
    end
    Wait(500)
    FPrompt()
    LMPrompt()
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.0)
    tool = CreateObject(toolhash, coords.x, coords.y, coords.z, true, false, false, false)
    AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 7966), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false,
        2, true, false, false)
    Citizen.InvokeNative(0x923583741DC87BCE, ped, 'arthur_healthy')
    Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, "carry_pitchfork")
    Citizen.InvokeNative(0x2208438012482A1A, ped, true, true)
    ForceEntityAiAndAnimationUpdate(tool, true)
    Citizen.InvokeNative(0x3A50753042B6891B, ped, "PITCH_FORKS")

    Wait(500)
    -- show prompts
    UiPromptSetEnabled(PropPrompt, true)
    UiPromptSetVisible(PropPrompt, true)

    UiPromptSetEnabled(UsePrompt, true)
    UiPromptSetVisible(UsePrompt, true)

    hastool = true
end

local function goChop(tree)
    EquipTool('p_axe02x')
    local swingcount = math.random(Config.MinSwing, Config.MaxSwing)

    while hastool do
        FreezeEntityPosition(PlayerPedId(), true)

        if IsControlJustReleased(0, Config.CancelChopKey) or IsPedDeadOrDying(PlayerPedId(), false) then
            UiPromptSetEnabled(UsePrompt, false)
            treeFinished(tree)
            break
        elseif IsControlJustPressed(0, Config.ChopTreeKey) then
            local randomizer = math.random(Config.maxDifficulty, Config.minDifficulty)
            UiPromptSetEnabled(UsePrompt, false)
            swing = swing + 1
            local ped = PlayerPedId()
            Anim(ped, "amb_work@world_human_tree_chop_new@working@pre_swing@male_a@trans", "pre_swing_trans_after_swing",
                -1, 0)
            local testplayer = exports["syn_minigame"]:taskBar(randomizer, 7)
            if testplayer == 100 then
                TriggerServerEvent('vorp_lumberjack:addItem', swingcount)
            else
                local lumberjack_fail_txt_index = math.random(1, #T)
                local lumberjack_fail_txt = T[lumberjack_fail_txt_index]
                TriggerEvent("vorp:TipRight", lumberjack_fail_txt, 3000)
            end
            Wait(500)
            UiPromptSetEnabled(UsePrompt, true)
        end

        -- if swings  equals max swings then break loop
        if swing == swingcount then
            UiPromptSetEnabled(UsePrompt, false)
            treeFinished(tree)
            break
        end

        Wait(0)
    end
    -- unfreeze and lock prompts
    releasePlayer()
    -- unlock main loop
    active = false
end

CreateThread(function()
    repeat Wait(5000) until LocalPlayer.state.IsInSession
    CreateStartChopPrompt()

    while true do
        local aleep = 1000

        if not active and nearby_tree then
            aleep = 0
            local ChoppingGroupName = VarString(10, 'LITERAL_STRING', T.PromptLabels.cutDesc)
            UiPromptSetActiveGroupThisFrame(TreeGroup, ChoppingGroupName, 0, 0, 0, 0)

            if UiPromptHasHoldModeCompleted(CuttingPrompt) then
                active = true
                local player = PlayerPedId()
                SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true, 0, false, false)
                Wait(500)
                TriggerServerEvent("vorp_lumberjack:axecheck", nearby_tree.vector_coords)
            end
        end

        Wait(aleep)
    end
end)

-- if axe go chop
RegisterNetEvent("vorp_lumberjack:axechecked", function(tree)
    goChop(tree)
end)

-- if no axe reset it
RegisterNetEvent("vorp_lumberjack:noaxe", function()
    active = false
end)


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    removeToolFromPlayer()
    releasePlayer()
    removeCuttingPrompt()
end)
