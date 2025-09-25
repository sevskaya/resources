Config = {}

Config.EyeKey = 0x7C0162C0--Nil is disabled
Config.EyeCommand = "target"--Command for open Eye targeting
Config.EyePromptOnly = false--Prompt react only if you have opened Eye targeting

Config.Framework = "VORP"
--GUM, VORP, REDEM, REDEMREBOOT, QBR, RSG, RSG2, CUSTOM

-- If you use CUSTOM framework, open serverData/serverCompCustom.lua
-- And change natives for function

if Config.Framework == "GUM" then
    Config.FolderWithIcons = "gum_inventory/html/images/items/"
elseif Config.Framework == "VORP" then
    Config.FolderWithIcons = "vorp_inventory/html/img/items/"
elseif Config.Framework == "REDEM" then
    Config.FolderWithIcons = "redemrp_inventory/html/items/"
elseif Config.Framework == "REDEMREBOOT" then
    Config.FolderWithIcons = "redemrp_inventory/html/items/"
elseif Config.Framework == "QBR" then
    Config.FolderWithIcons = "qbr-inventory/html/images/"
elseif Config.Framework == "RSG" then
    Config.FolderWithIcons = "rsg-inventory/html/images/"
elseif Config.Framework == "RSG2" then
    Config.FolderWithIcons = "rsg-inventory/html/images/"
else
    Config.FolderWithIcons = "custom/traceToInventoryIcons/Items/"
end

--Discord hook language
Config.Language = {
    [1] = "**Info**",
    [2] = "**Name**",
    [3] = "**CharID** : ",
    [4] = "**Steam** : ",
    [5] = "**Firstname** : ",
    [6] = "**Lastname** : "
}