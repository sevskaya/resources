-------------------------------------------------------------------------------------------------
--------------------------------- ADMIN ACTIONS -------------------------------------------------
local freeze = false
local lastLocation = {}
local T = Translation.Langs[Config.Lang]

function IsAdminAllowed(param)
    local isAllowed = VORP.Callback.TriggerAwait("vorp_admin:CanOpenStaffMenu", param)
    if not isAllowed then
        VORP.NotifyObjective(T.Notify.noperms, 5000)
    end
    return isAllowed
end

function Admin()
    MenuData.CloseAll()
    local num = 0
    if GlobalState.PlayersInSession then
        num = GlobalState.PlayersInSession
    end
    local elements = {
        { label = T.Menus.MainAdminOptions.playersList,    value = 'players', desc = T.Menus.MainAdminOptions.playersList_desc .. "<br><br>" .. (num > 0 and num or "") },
        { label = T.Menus.MainAdminOptions.adminActions,   value = 'actions', desc = T.Menus.MainAdminOptions.adminActions_desc },
        { label = T.Menus.MainAdminOptions.offLineActions, value = 'offline', desc = T.Menus.MainAdminOptions.offLineActions_desc },
        { label = T.Menus.MainAdminOptions.viewReports,    value = 'view',    desc = T.Menus.MainAdminOptions.viewReports_desc },
        { label = T.Menus.MainAdminOptions.searchPlayer,   value = 'search',  desc = T.Menus.MainAdminOptions.searchPlayer_desc },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'Admin',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'OpenMenu', -- Go back
        },
        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "players" then
                local AdminAllowed = IsAdminAllowed('players_list_menu')
                if AdminAllowed then
                    return PlayerList()
                end
            elseif data.current.value == "actions" then
                local AdminAllowed = IsAdminAllowed('admin_actions_menu')
                if AdminAllowed then
                    return Actions()
                end
            elseif data.current.value == "offline" then
                local AdminAllowed = IsAdminAllowed('offline_actions_menu')
                if AdminAllowed then
                    return OffLine()
                end
            elseif data.current.value == "view" then
                local AdminAllowed = IsAdminAllowed('view_reports_menu')
                if AdminAllowed then
                    TriggerEvent("vorp_admin:viewreports")
                end
            elseif data.current.value == "search" then
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.MainAdminOptions.MenuAdminInput.placeholder, T.Menus.MainAdminOptions.MenuAdminInput.title,
                    "number", T.Menus.MainAdminOptions.MenuAdminInput.errorMsg, "[0-9]{10,100}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local id = tonumber(result)
                    if id and id > 0 then
                        VORP.Callback.TriggerAsync("vorp_admin:Callback:getplayersinfo", function(cb)
                            if cb then
                                OpenOnePlayerMenu(cb)
                            else
                                VORP.NotifyObjective(T.Notify.userNotExist, 5000)
                            end
                        end, { search = "search", id = id })
                    end
                end)
            end
        end,
        function(menu)
            menu.close()
        end)
end

function OpenOnePlayerMenu(playersInfo)
    MenuData.CloseAll()
    local elements = {
        {
            label = playersInfo.PlayerName .. "<br>" .. T.Menus.MainPlayerStatus.playerServerID .. playersInfo.serverId,
            value = "players" .. playersInfo.serverId,
            desc = T.Menus.MainPlayerStatus.playerSteamName .. "<span style=color:MediumSeaGreen;> " .. (playersInfo.name or "") ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerServerID .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.serverId or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerGroup .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Group or "") ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerJob .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Job or "") ..
                "</span>" .. T.Menus.MainPlayerStatus.playerGrade .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Grade or "") ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerIdentifier .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.SteamId or "") ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerMoney .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Money or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerGold .. " " .. "<span style=color:Gold;>" .. (playersInfo.Gold or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerWhitelist .. " " .. "<span style=color:Gold;>" .. (playersInfo.WLstatus or "") .. "</span>",
            info = playersInfo
        }
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OpenOnePlayerMenu',
        {
            title      = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext    = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align      = 'top-left',
            elements   = elements,
            lastmenu   = 'Admin',
            itemHeight = "4vh",
        },
        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end
            if data.current.value then
                OpenSubAdminMenu(data.current.info)
            end
        end,
        function(menu)
            menu.close()
        end)
end

function PlayerList()
    MenuData.CloseAll()
    local elements = {}
    local result = VORP.Callback.TriggerAwait("vorp_admin:Callback:getplayersinfo", { search = "all" })
    if not result then
        return
    end

    local players = result
    local sortedPlayers = {} -- Create a new table to store the sorted player list

    for _, playersInfo in pairs(players) do
        sortedPlayers[#sortedPlayers + 1] = playersInfo
    end

    -- Sort players by serverId in ascending order
    table.sort(sortedPlayers, function(a, b)
        return a.serverId < b.serverId
    end)

    for _, playersInfo in ipairs(sortedPlayers) do
        elements[#elements + 1] = {
            label = playersInfo.PlayerName .. "<br>" .. T.Menus.MainPlayerStatus.playerServerID .. playersInfo.serverId,
            value = "players" .. playersInfo.serverId,
            desc = T.Menus.MainPlayerStatus.playerSteamName .. "<span style=color:MediumSeaGreen;> " .. (playersInfo.name or "") ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerServerID .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.serverId or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerGroup .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Group or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerJob .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Job or "") ..
                "</span>" .. T.Menus.MainPlayerStatus.playerGrade .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Grade or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerIdentifier .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.SteamId or "") ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerMoney .. " " .. "<span style=color:MediumSeaGreen;>" .. (playersInfo.Money or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerGold .. " " .. "<span style=color:Gold;>" .. (playersInfo.Gold or 0) ..
                "</span><br>" .. T.Menus.MainPlayerStatus.playerWhitelist .. " " .. "<span style=color:Gold;>" .. (playersInfo.WLstatus or "") .. "</span>",
            info = playersInfo
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'PlayerList',
        {
            title      = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext    = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align      = 'top-left',
            elements   = elements,
            lastmenu   = 'Admin',
            itemHeight = "4vh",
        },
        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end
            if data.current.value then
                local AdminAllowed = IsAdminAllowed('players_list_submenu')
                if AdminAllowed then
                    local player = data.current.info
                    return OpenSubAdminMenu(player)
                end
            end
        end,
        function(menu)
            menu.close()
        end)
end

function OpenSubAdminMenu(Player)
    MenuData.CloseAll()
    local elements = {
        { label = T.Menus.SubAdminOptions.simpleActions,   value = 'simpleaction',   desc = T.Menus.SubAdminOptions.simpleActions_desc },
        { label = T.Menus.SubAdminOptions.advancedActions, value = 'advancedaction', desc = T.Menus.SubAdminOptions.advancedActions_desc },
        { label = T.Menus.SubAdminOptions.trollActions,    value = 'trollactions',   desc = T.Menus.SubAdminOptions.trollActions_desc },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OpenSubAdminMenu',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'PlayerList',
        },
        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "simpleaction" then
                local AdminAllowed = IsAdminAllowed('simple_actions_menu')
                if AdminAllowed then
                    OpenSimpleActionMenu(Player)
                end
            elseif data.current.value == "advancedaction" then
                local AdminAllowed = IsAdminAllowed('advanced_actions_menu')
                if AdminAllowed then
                    OpenAdvancedActions(Player)
                end
            elseif data.current.value == 'trollactions' then
                local AdminAllowed = IsAdminAllowed('troll_actions_menu')
                if AdminAllowed then
                    OpenTrollActions(Player)
                end
            end
        end,
        function(menu)
            menu.close()
        end)
end

function OpenTrollActions(PlayerInfo)
    MenuData.CloseAll()
    local elements = {
        {
            label = T.Menus.SubTrollOptions.killPlayer,
            value = 'killplayer',
            desc = T.Menus.SubTrollOptions.killPlayer_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.invisPlayer,
            value = 'invisplayer',
            desc = T.Menus.SubTrollOptions.invisPlayer_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.lightningStrikePlayer,
            value = 'lightningstrikeplayer',
            desc = T.Menus.SubTrollOptions.lightningStrikePlayer_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.setPlayerOnFire,
            value = 'setplayeronfire',
            desc = T.Menus.SubTrollOptions.setPlayerOnFire_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.teleportToHeaven,
            value = 'tptoheaven',
            desc = T.Menus.SubTrollOptions.teleportToHeaven_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.ragdollPlayer,
            value = 'ragdollplayer',
            desc = T.Menus.SubTrollOptions.ragdollPlayer_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.drainPlayerStam,
            value = 'drainplayerstam',
            desc = T.Menus.SubTrollOptions.drainPlayerStam_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.cuffPlayer,
            value = 'cuffplayer',
            desc = T.Menus.SubTrollOptions.cuffPlayer_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubTrollOptions.tempHighPlayer,
            value = 'temphighplayer',
            desc = T.Menus.SubTrollOptions.tempHighPlayer_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OpenTrollActions',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'PlayerList', -- Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == 'killplayer' then
                TriggerServerEvent('vorp_admin:ServerTrollKillPlayerHandler', data.current.info, 'vorp.staff.KillPlayer')
            elseif data.current.value == 'invisplayer' then
                TriggerServerEvent('vorp_admin:ServerTrollInvisibleHandler', data.current.info, 'vorp.staff.InvisPlayer')
            elseif data.current.value == 'lightningstrikeplayer' then
                TriggerServerEvent('vorp_admin:ServerTrollLightningStrikePlayerHandler', data.current.info, 'vorp.staff.LightningStrikePlayer')
            elseif data.current.value == 'setplayeronfire' then
                TriggerServerEvent('vorp_admin:ServerTrollSetPlayerOnFireHandler', data.current.info, 'vorp.staff.SetPlayerOnFire')
            elseif data.current.value == 'tptoheaven' then
                TriggerServerEvent('vorp_admin:ServerTrollTPToHeavenHandler', data.current.info, 'vorp.staff.TPToHeaven')
            elseif data.current.value == 'ragdollplayer' then
                TriggerServerEvent('vorp_admin:ServerTrollRagdollPlayerHandler', data.current.info, 'vorp.staff.RagdollPlayer')
            elseif data.current.value == 'drainplayerstam' then
                TriggerServerEvent('vorp_admin:ServerDrainPlayerStamHandler', data.current.info, 'vorp.staff.DrainPlayerStam')
            elseif data.current.value == 'cuffplayer' then
                TriggerServerEvent('vorp_admin:ServerHandcuffPlayerHandler', data.current.info, 'vorp.staff.CuffPlayer')
            elseif data.current.value == 'temphighplayer' then
                TriggerServerEvent('vorp_admin:ServerTempHighPlayerHandler', data.current.info, 'vorp.staff.PlayerTempHigh')
            end
        end,
        function(menu)
            menu.close()
        end)
end

function OpenSimpleActionMenu(PlayerInfo)
    MenuData.CloseAll()
    local elements = {
        {
            label = T.Menus.SubSimpleActionOptions.playerSpectate,
            value = 'spectate',
            desc = T.Menus.SubSimpleActionOptions.playerSpectate_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerFreeze,
            value = 'freeze',
            desc = T.Menus.SubSimpleActionOptions.playerFreeze_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerRevive,
            value = 'revive',
            desc = T.Menus.SubSimpleActionOptions.playerRevive_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerHeal,
            value = 'heal',
            desc = T.Menus.SubSimpleActionOptions.playerHeal_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerGoTo,
            value = 'goto',
            desc = T.Menus.SubSimpleActionOptions.playerGoTo_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerGoBack,
            value = 'goback',
            desc = T.Menus.SubSimpleActionOptions.playerGoBack_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerBring,
            value = 'bring',
            desc = T.Menus.SubSimpleActionOptions.playerBring_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
        {
            label = T.Menus.SubSimpleActionOptions.playerSendBack,
            value = 'sendback',
            desc = T.Menus.SubSimpleActionOptions.playerSendBack_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId
        },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'OpenSimpleActionMenu',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'PlayerList', -- Go back
        },

        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value == "freeze" then
                local target = data.current.info
                if target then
                    if not freeze then
                        freeze = true
                        TriggerServerEvent("vorp_admin:freeze", target, freeze, 'vorp.staff.Frezee', PlayerInfo.PlayerName)
                        TriggerEvent("vorp:TipRight", T.Notify.switchedOn, 3000)
                    else
                        freeze = false
                        TriggerServerEvent("vorp_admin:freeze", target, freeze, 'vorp.staff.Frezee')
                        TriggerEvent("vorp:TipRight", T.Notify.switchedOff, 3000)
                    end
                end
            elseif data.current.value == "bring" then
                local target = data.current.info
                local adminCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("vorp_admin:Bring", target, adminCoords, 'vorp.staff.Bring', PlayerInfo.PlayerName)
            elseif data.current.value == "sendback" then
                local target = data.current.info
                if lastLocation then
                    TriggerServerEvent("vorp_admin:TeleportPlayerBack", target, 'vorp.staff.Bring')
                end
            elseif data.current.value == "goto" then
                local target = data.current.info
                TriggerServerEvent("vorp_admin:TpToPlayer", target, 'vorp.staff.GoTo', PlayerInfo.PlayerName)
            elseif data.current.value == "goback" then
                if lastLocation then
                    TriggerServerEvent("vorp_admin:sendAdminBack", 'vorp.staff.GoTo')
                end
            elseif data.current.value == "revive" then
                local target = data.current.info
                TriggerServerEvent('vorp_admin:revive', target, 'vorp.staff.Revive', PlayerInfo.PlayerName)
            elseif data.current.value == "heal" then
                local target = data.current.info
                TriggerServerEvent('vorp_admin:heal', target, 'vorp.staff.Heal', PlayerInfo.PlayerName)
            elseif data.current.value == "spectate" then
                local target = data.current.info
                TriggerServerEvent("vorp_admin:spectate", target, 'vorp.staff.Spectate', PlayerInfo.PlayerName)
            end
        end,

        function(menu)
            menu.close()
        end)
end

function OpenAdvancedActions(Player)
    MenuData.CloseAll()
    local elements = {
        {
            label = T.Menus.SubAdvancedActionOptions.playerKick,
            value = 'kick',
            desc = T.Menus.SubAdvancedActionOptions.playerKick_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.Group,
            info2 = Player.serverId
        },
        {
            label = T.Menus.SubAdvancedActionOptions.playerBan,
            value = 'ban',
            desc = T.Menus.SubAdvancedActionOptions.playerBan_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.staticID,
            info2 = Player.Group,
            info3 = Player.serverId
        },
        {
            label = T.Menus.SubAdvancedActionOptions.playerUnBan,
            value = 'unban',
            desc = T.Menus.SubAdvancedActionOptions.playerUnBan_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.staticID
        },
        {
            label = T.Menus.SubAdvancedActionOptions.playerRespawn,
            value = 'respawn',
            desc = T.Menus.SubAdvancedActionOptions.playerRespawn_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId
        },
        {
            label = T.Menus.SubAdvancedActionOptions.playerUnWhitelist,
            value = 'unwhitelist',
            desc = T.Menus.SubAdvancedActionOptions.playerUnWhitelist_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId,
            info2 = Player.SteamId
        },
        {
            label = T.Menus.SubAdvancedActionOptions.playerSetJob,
            value = 'setjob',
            desc = T.Menus.SubAdvancedActionOptions.playerSetJob_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId
        },
        {
            label = T.Menus.SubAdvancedActionOptions.playerSetGroup,
            value = 'setgroup',
            desc = T.Menus.SubAdvancedActionOptions.playerSetGroup_desc .. " " .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId
        },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OpenAdvancedActions',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = Player.PlayerName, -- Char player name
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'PlayerList',
        },

        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value == "respawn" then
                local target = data.current.info
                TriggerServerEvent("vorp_admin:respawnPlayer", target, 'vorp.staff.Respawn', Player.PlayerName)
            elseif data.current.value == "kick" then
                local targetGroup = data.current.info
                local targetID = data.current.info2
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubAdvancedActionOptions.KickInput.placeholder, T.Menus.SubAdvancedActionOptions.KickInput.title, "text", T.Menus.SubAdvancedActionOptions.KickInput.errorMsg, "[A-Za-z0-9 ]{10,100}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local reason = tostring(result)
                    if reason ~= "" then
                        if targetGroup ~= "user" then
                            TriggerEvent("vorp:TipRight", T.Notify.cantKickStaff, 4000)
                        else
                            TriggerServerEvent("vorp_admin:kick", targetID, reason, 'vorp.staff.Kick', Player.PlayerName)
                        end
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            elseif data.current.value == "ban" then
                local group = data.current.info2
                local staticID = data.current.info
                local target = data.current.info3
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubAdvancedActionOptions.BanInput.placeholder, T.Menus.SubAdvancedActionOptions.BanInput.title, "text", T.Menus.SubAdvancedActionOptions.BanInput.errorMsg, "[A-Za-z0-9 ]{2,2}")

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local time = tostring(result)
                    if time ~= "" then
                        if group ~= "user" then
                            TriggerEvent("vorp:TipRight", T.Notify.cantBanStaff, 4000)
                        else
                            TriggerServerEvent("vorp_admin:BanPlayer", target, staticID, time, 'vorp.staff.Ban', Player.PlayerName)
                        end
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            elseif data.current.value == "unban" then
                local staticID = data.current.info
                TriggerServerEvent("vorp_admin:UnBan", staticID, 'vorp.staff.Unban', Player.PlayerName)
            elseif data.current.value == "unwhitelist" then
                local target = data.current.info
                local steam = data.current.info2
                local type = "removewhitelist"
                TriggerServerEvent("vorp_admin:Whitelist", target, steam, type, 'vorp.staff.Unwhitelist', Player.PlayerName)
                VORP.NotifyObjective(T.Notify.whiteRemoved, 5000)
            elseif data.current.value == "setgroup" then
                local target = data.current.info
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubAdvancedActionOptions.GroupInput.placeholder, T.Menus.SubAdvancedActionOptions.GroupInput.title, "text", T.Menus.SubAdvancedActionOptions.GroupInput.errorMsg, "[A-Za-z]{3,20}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tostring(cb)
                    if result ~= "" then
                        TriggerServerEvent("vorp_admin:setGroup", target, result, 'vorp.staff.Setgroup', Player.PlayerName)
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            elseif data.current.value == "setjob" then
                local target = data.current.info
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubAdvancedActionOptions.JobInput.placeholder, T.Menus.SubAdvancedActionOptions.JobInput.title, "text", T.Menus.SubAdvancedActionOptions.JobInput.errorMsg, "[A-Za-z0-9 ]{3,40}")

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tostring(cb)

                    if result ~= "" then
                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end

                        local jobname = splitstring[1]
                        local jobgrade = tonumber(splitstring[2])
                        local joblabel = splitstring[3] or ""
                        local joblabel1 = splitstring[4] and joblabel .. " " .. splitstring[4] or joblabel

                        if jobname and jobgrade and joblabel or joblabel ~= "" then
                            TriggerServerEvent("vorp_admin:setJob", target, jobname, jobgrade, joblabel1, 'vorp.staff.Setjob', Player.PlayerName)
                        end
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            end
        end,

        function(menu)
            menu.close()
        end)
end

-------------------------------------------------------------------------------------------------------------
---------------------------------------- Actions ------------------------------------------------------------


function Actions()
    MenuData.CloseAll()
    local elements = {
        { label = T.Menus.SubActionsAdminOptions.deleteMountHorse,    value = 'delhorse',       desc = T.Menus.SubActionsAdminOptions.deleteMountHorse_desc },
        { label = T.Menus.SubActionsAdminOptions.deleteMountWagon,    value = 'delwagon',       desc = T.Menus.SubActionsAdminOptions.deleteMountWagon_desc },
        { label = T.Menus.SubActionsAdminOptions.deleteWagonInRadius, value = 'delwagonradius', desc = T.Menus.SubActionsAdminOptions.deleteWagonInRadius_desc },
        { label = T.Menus.SubActionsAdminOptions.getCoords,           value = 'getcoords',      desc = T.Menus.SubActionsAdminOptions.getCoords_desc },
        { label = T.Menus.SubActionsAdminOptions.adminAnnounce,       value = 'announce',       desc = T.Menus.SubActionsAdminOptions.adminAnnounce_desc },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'Actions',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'Admin', -- Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end

            if data.current.value == "delhorse" then
                local AdminAllowed = IsAdminAllowed('delete_horse')
                if AdminAllowed then
                    TriggerEvent("vorp:delHorse") -- TODO Make Server Side
                end
            elseif data.current.value == "delwagon" then
                local AdminAllowed = IsAdminAllowed('delete_wagon')
                if AdminAllowed then
                    Delwagon()
                end
            elseif data.current.value == "delwagonradius" then
                local AdminAllowed = IsAdminAllowed('delete_wagons_radius')
                if AdminAllowed then
                    local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubActionsAdminOptions.DelWagonRadiusInput.placeholder, T.Menus.SubActionsAdminOptions.DelWagonRadiusInput.title, "number", T.Menus.SubActionsAdminOptions.DelWagonRadiusInput.errorMsg, "[0-9]{1,2}")
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                        local radius = result
                        if radius ~= "" then
                            TriggerEvent("vorp:deleteVehicle", radius) -- TODO Make Server Side
                        else
                            VORP.NotifyObjective(T.Notify.empty, 5000)
                        end
                    end)
                end
            elseif data.current.value == "getcoords" then
                local AdminAllowed = IsAdminAllowed('get_coords')
                if AdminAllowed then
                    OpenCoordsMenu()
                end
            elseif data.current.value == "announce" then
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubActionsAdminOptions.AnnounceInput.placeholder, T.Menus.SubActionsAdminOptions.AnnounceInput.title, "text",
                    T.Menus.SubActionsAdminOptions.AnnounceInput.errorMsg, "[A-Za-z0-9 ]{5,100}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local announce = result
                    if announce ~= "" and announce then
                        TriggerServerEvent("vorp_admin:announce", announce)
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            end
        end,

        function(menu)
            menu.close()
        end)
end

function OpenCoordsMenu()
    MenuData.CloseAll()
    local elements = {
        { label = T.Menus.SubCoordsMenu.getCoordsXYZ,  value = 'v2',      desc = T.Menus.SubCoordsMenu.getCoordsXYZ_desc },
        { label = T.Menus.SubCoordsMenu.getCoordsVec3, value = 'v3',      desc = T.Menus.SubCoordsMenu.getCoordsVec3_desc },
        { label = T.Menus.SubCoordsMenu.getCoordsVec4, value = 'v4',      desc = T.Menus.SubCoordsMenu.getCoordsVec4_desc },
        { label = T.Menus.SubCoordsMenu.getHeading,    value = 'heading', desc = T.Menus.SubCoordsMenu.getHeading_desc },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OpenCoordsMenu',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleCoords,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'Actions', -- Go back
        },

        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value then
                local DataCoords = data.current.value
                CopyToClipboard(DataCoords)
            end
        end,

        function(menu)
            menu.close()
        end)
end

--to test
function OffLine()
    MenuData.CloseAll()
    local elements = {
        {
            label = T.Menus.SubOfflineOptions.banOrUnban,
            value = 'bans',
            desc = T.Menus.SubOfflineOptions.banOrUnban_desc
        },
        {
            label = T.Menus.SubOfflineOptions.whiteOrUnwhite,
            value = 'whites',
            desc = T.Menus.SubOfflineOptions.whiteOrUnwhite_desc
        },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OffLine',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleAdmin,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'Admin',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end

            if data.current.value == "bans" then
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubOfflineOptions.BanTypeInput.placeholder, T.Menus.SubOfflineOptions.BanTypeInput.title, "text", T.Menus.SubOfflineOptions.BanTypeInput.errorMsg, "[A-Za-z0-9 ]{5,100}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = cb
                    if result ~= "" then
                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end
                        local type, StaticID, time = tostring(splitstring[1]), tonumber(splitstring[2]), tostring(splitstring[3])
                        if type and StaticID and time then
                            if type == "ban" then
                                if StaticID and time then
                                    TriggerServerEvent("vorp_admin:BanOffline", StaticID, time, 'vorp.staff.Ban')
                                end
                            elseif type == "unban" then
                                TriggerServerEvent("vorp_admin:UnBan", StaticID, 'vorp.staff.Unban')
                            else
                                VORP.NotifyObjective(T.Notify.incorrectType, 5000)
                            end
                        else
                            VORP.NotifyObjective(T.Notify.missingArgument, 5000)
                        end
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            elseif data.current.value == "whites" then
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.SubOfflineOptions.WhiteTypeInput.placeholder, T.Menus.SubOfflineOptions.WhiteTypeInput.title, "text", T.Menus.SubOfflineOptions.WhiteTypeInput.errorMsg, "[A-Za-z0-9 ]{5,100}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = cb
                    if result ~= "" then
                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end
                        local type, steam = tostring(splitstring[1]), tostring(splitstring[2])
                        if type and steam then -- If empty dont run
                            if type == "whitelist" then
                                TriggerServerEvent("vorp_admin:Whitelistoffline", steam, type)
                            else
                                VORP.NotifyObjective(T.Notify.incorrectType, 5000)
                            end
                        else
                            VORP.NotifyObjective(T.Notify.missingArgument, 5000)
                        end
                    else
                        VORP.NotifyObjective(T.Notify.empty, 5000)
                    end
                end)
            end
        end,

        function(menu)
            menu.close()
        end)
end
