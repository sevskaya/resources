Config = {}

Config.DevMode = false -- Set to false on live servers

Config.lang = {
    PromptText = "Press",
    NotAllowed = "You don't have the right job",
    GradeNotalowed = "You don't have the right grade",
    Notneardoor = "You are not near a door or this door can't be lockpicked",
    Alreadyopen = "The door is already open",
    HackAttempt = "Player %s (ID: %d) was not close to the door, possible hack attempt",
    Opened = "Opened",
    Closed = "Closed",
    Open = "Open",
    Close = "Close",
    Alerts = {
        PoliceAlertTitle = "Police Alert",
        PoliceAlertMessage = "Someone lockpicked a door",
        PoliceAlertIcon = "inventory_items",
        PoliceAlertPicture = "provision_sheriff_star",
        PoliceAlertColor = "COLOR_WHITE",
        PoliceAlertDuration = 5000
    }
}

Config.InteractionDistance = 1.5 -- Distance of interaction with the door

Config.MinAlert = 4              -- alert 4 closest on duty officers

Config.AlertProbability = 0.5    -- 0.5 = 50% chance of alerting police if Config.Doors.Alert is true

-- assing permissions and avoid code repetition it uses jobs and grades
Config.Permissions = {
    -- police
    ValSheriff = {      -- Name must match config.Doors.Perms can be any name it doesnt matter as long is unique in here
        ValSheriff = 2, -- job name + grade if grade is 0 then anything above 0 has permissions if frade is 2 then anything above 2 has permissions
        -- Can add as many jobs as you wish
    },
    BWPolice = {
        BWPolice = 0,
    },
    RhoSheriff = {
        RhoSheriff = 0,
    },
    SDPolice = {
        SDPolice = 2,
    },
    StrSheriff = {
        StrSheriff = 2,
    },
    ArmSheriff = {
        ArmSheriff = 0,
    },
    -- medic
    Doctor = {
        doctor = 0,
        headdoctor = 0,
        shaman = 0,
    },
    -- fort
    FortWallace = {
        ValSheriff = 0,
        BWPolice = 0,
        RhoSheriff = 0,
        SDPolice = 0,
        StrSheriff = 0,
        ArmSheriff = 0,
    },
    -- prison
    Sisika = {
        ValSheriff = 0,
        BWPolice = 0,
        RhoSheriff = 0,
        SDPolice = 0,
        StrSheriff = 0,
        ArmSheriff = 0,
    },

    ---- Bank Doors Permission ----
    ValBank = {
        ValSheriff = 0,
        BWPolice = 0,
        RhoSheriff = 0,
        SDPolice = 0,
        StrSheriff = 0,
        ArmSheriff = 0,
    },
    BWBank = {
        ValSheriff = 0,
        BWPolice = 0,
        RhoSheriff = 0,
        SDPolice = 0,
        StrSheriff = 0,
        ArmSheriff = 0,
    },
    SDBank = {
        ValSheriff = 0,
        BWPolice = 0,
        RhoSheriff = 0,
        SDPolice = 0,
        StrSheriff = 0,
        ArmSheriff = 0,
    },
    RhoBank = {
        ValSheriff = 0,
        BWPolice = 0,
        RhoSheriff = 0,
        SDPolice = 0,
        StrSheriff = 0,
        ArmSheriff = 0,
    },

    -- Add more here to make unique door permissions
}

-- these will be used for unqiue players like doors for houses instead of using a job and grade it uses charidentfier, you can find these in the database under characters table its a unique identifier
-- if you use vorp housing that script already handles doors
-- just add these to the Config.Doors
Config.UniquePermissions = {
    location = {      -- any name this is used to avoid
        [147] = true, -- add char ids here
        -- add more here
    },
    -- create more here for other places
}

-- items you can assign to each door if you which or the same item for various doors
Config.Lockpicks = {
    location = {              -- unique location name to be used at Config.Doors.BreakAble
        lockpick = "lockpick" -- ITEMS HERE CANNOT BE NAMED THE SAME YOU MUST MAKE THEM UNIQUE
    },
    -- Add more here to make unique door lockpicks
}

-- permissions for job or charid will try to get one or the other so you can use both jobs and char ids in one door
-- https://github.com/femga/rdr3_discoveries/blob/master/doorHashes/doorhashes.lua to look for door ids go to this link , with spooner you can check the coords of the door and use those coords in the link to get the door id
Config.Doors = {
    -- Valentine Sheriff Doors
    [1988748538] = {
        Pos = vector3(-276.01260375977, 802.59106445313, 118.41165161133), -- Door Position
        Name = "Front Door",                                               -- Door Name
        DoorState = 0,                                                     -- Default door State 0 is open 1 is close
        Permissions = Config.Permissions.ValSheriff,                       -- Will use the jobs for this location if false everyone can open and close doors
        BreakAble = Config.Lockpicks.location.lockpick,                    -- Will use the lockpick item for this location, if false it will not use lockpick and cant be lockpicked
        Difficulty = 3,                                                    -- Lockpick Difficulty, how many tries
        Alert = true,
        --UniquePermissions = Config.UniquePermissions.location,              -- remove if you dont want to use charid permissions
        -- DoubleDoor = 1988748538, -- if is double door just add the door next to it here so it open both at the same time
    },
    [395506985]  = {
        Pos = vector3(-275.84475708008, 812.02703857422, 118.41483306885),
        Name = "Back Door",
        DoorState = 0,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [1508776842] = {
        Pos = vector3(-270.76641845703, 810.02648925781, 118.39580535889),
        Name = "Back Jail Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [193903155]  = {
        Pos = vector3(-272.05209350586, 808.25830078125, 118.36851501465),
        Name = "Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [295355979]  = {
        Pos = vector3(-273.46432495117, 809.96606445313, 118.36823272705),
        Name = "Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [535323366]  = {
        Pos = vector3(-275.02328491211, 808.27404785156, 118.36856842041),
        Name = "Door 3",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Valentine Doctor/Medic Doors
    -- Doors ID
    [3588026089] = {
        Pos = vector3(-282.8079528808594, 803.954833984375, 118.39317321777344),
        Name = "Front Door",
        DoorState = 0,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [4067537969] = {
        Pos = vector3(-286.6419982910156, 809.7845458984375, 118.42121887207031),
        Name = "Front Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [925575409]  = {
        Pos = vector3(-290.8585510253906, 813.3575439453125, 118.41549682617188),
        Name = "Iron Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3439738919] = {
        Pos = vector3(-281.0743408203125, 815.23779296875, 118.41590118408203),
        Name = "Iron Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Blackwater Police Doors
    -- Doors ID
    [3821185084] = {
        Pos = vector3(-757.0423583984375, -1269.92333984375, 43.06862640380859),
        Name = "Front Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 3410720590, -- if is double door just add the door next to it here so it open both at the same time
    },
    [3410720590] = {
        Pos = vector3(-757.0423583984375, -1268.4853515625, 43.06859970092773),
        Name = "Front Door 1 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1988748538, -- if is double door just add the door next to it here so it open both at the same time
    },
    [2810801921] = {
        Pos = vector3(-769.1376342773438, -1268.745361328125, 43.04003143310547),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [2514996158] = {
        Pos = vector3(-765.8612060546875, -1264.703857421875, 43.02326965332031),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2167775834] = {
        Pos = vector3(-763.5278930664062, -1262.4609375, 43.02326583862305),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Rhodes Sheriff Doors
    -- Doors ID
    [349074475]  = {
        Pos = vector3(1359.7095947265625, -1305.9598388671875, 76.76844787597656),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1614494720] = {
        Pos = vector3(1359.0985107421875, -1297.53466796875, 76.7876205444336),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Cell
    [1878514758] = {
        Pos = vector3(1357.333740234375, -1302.453857421875, 76.76018524169922),
        Name = "Cell Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3723126486] = {
        Pos = vector3(2715.9943847656, -1230.2332763672, 49.371280670166),
        Name = "Front Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [79213682]   = {
        Pos = vector3(2715.9943847656, -1228.5042724609, 49.371234893799),
        Name = "Front Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [82263429]   = {
        Pos = vector3(2726.5541992188, -1234.8221435547, 49.363960266113),
        Name = "side Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [994323006]  = {
        Pos = vector3(2724.8232421875, -1234.8221435547, 49.363960266113),
        Name = "side Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1289094734] = {
        Pos = vector3(2727.4340820313, -1229.1629638672, 49.367797851563),
        Name = "office Door",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [586229709]  = {
        Pos = vector3(2723.953125, -1227.0920410156, 49.367786407471),
        Name = "inner Door",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1104407261] = {
        Pos = vector3(2725.1469726563, -1221.6247558594, 49.367805480957),
        Name = "back Door",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Saint Denis Police Doors
    -- Doors ID
    [1674105116] = {
        Pos = vector3(2493.37255859375, -1305.68701171875, 47.95257186889648),
        Name = "Front Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1979938193, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1979938193] = {
        Pos = vector3(2493.37255859375, -1307.41845703125, 47.95257186889648),
        Name = "Front Door 1 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1674105116, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1694749582] = {
        Pos = vector3(2493.37255859375, -1310.2252197265625, 47.95257186889648),
        Name = "Front Door 2 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1992193795, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1992193795] = {
        Pos = vector3(2493.37255859375, -1311.95654296875, 47.95257186889648),
        Name = "Front Door 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1694749582, -- if is double door just add the door next to it here so it open both at the same time
    },
    [2503834054] = {
        Pos = vector3(2495.953369140625, -1317.28271484375, 47.95257186889648),
        Name = "Front Door 3 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 305296302, -- if is double door just add the door next to it here so it open both at the same time
    },
    [305296302]  = {
        Pos = vector3(2497.684814453125, -1317.28271484375, 47.95257186889648),
        Name = "Front Door 3 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 2503834054, -- if is double door just add the door next to it here so it open both at the same time
    },
    [603068205]  = {
        Pos = vector3(2506.606201171875, -1317.2796630859375, 47.95257186889648),
        Name = "Front Door 4 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1020479727, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1020479727] = {
        Pos = vector3(2508.337646484375, -1317.2796630859375, 47.95257186889648),
        Name = "Front Door 4 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 603068205, -- if is double door just add the door next to it here so it open both at the same time
    },
    [417663242]  = {
        Pos = vector3(2516.144287109375, -1309.9276123046875, 47.95257186889648),
        Name = "Back Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1611175760, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1611175760] = {
        Pos = vector3(2516.14453125, -1307.724853515625, 47.95257186889648),
        Name = "Back Door 1 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 417663242, -- if is double door just add the door next to it here so it open both at the same time
    },

    --[[ -- You can open them if you want to deal with a bit more doors (more security) at entrances and exits
    [1879655431]  = {
        Pos = vector3(2510.90771484375, -1305.41162109375, 47.95716857910156),
        Name = "In Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3124713594]  = {
        Pos = vector3(2510.90771484375, -1307.141357421875, 47.95716857910156),
        Name = "In Door 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3430284519]  = {
        Pos = vector3(2510.90771484375, -1310.4840087890625, 47.95257186889648),
        Name = "In Door 3 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3601535313]  = {
        Pos = vector3(2510.90771484375, -1312.2154541015625, 47.95257186889648),
        Name = "In Door 4 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    --]]

    -- Cells
    [2515591150] = {
        Pos = vector3(2503.638671875, -1309.8763427734375, 47.95327377319336),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1995743734] = {
        Pos = vector3(2499.752197265625, -1309.8763427734375, 47.95327377319336),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3365520707] = {
        Pos = vector3(2498.5, -1307.85595703125, 47.95327377319336),
        Name = "Cell Door 3",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1711767580] = {
        Pos = vector3(2502.427734375, -1307.85498046875, 47.95326995849609),
        Name = "Cell Door 4",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Strawberry doctor
    [2543619259] = {
        Pos = vector3(-1802.1118164063, -429.39251708984, 157.83195495605),
        Name = "Strawberry Doctors",
        DoorState = 1,
        Permissions = Config.Permissions.Doctor,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Strawberry Sheriff Doors
    -- Doors ID
    [1821044729] = {
        Pos = vector3(-1806.6751708984375, -350.31280517578125, 163.64759826660156),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1514359658] = {
        Pos = vector3(-1812.669189453125, -345.08489990234375, 163.64759826660156),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [1207903970] = {
        Pos = vector3(-1812.0101318359375, -351.92095947265625, 160.46839904785156),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [902070893]  = {
        Pos = vector3(-1814.400390625, -353.1470947265625, 160.44180297851562),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Armadillo Sheriff Doors
    -- Doors ID
    [66424668]   = {
        Pos = vector3(-3624.6982421875, -2605.415771484375, -14.35151767730712),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.ArmSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [4016307508] = {
        Pos = vector3(-3620.9931640625, -2600.2490234375, -14.35159301757812),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.ArmSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [4235597664] = {
        Pos = vector3(-3619.148193359375, -2604.20654296875, -14.35159301757812),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.ArmSheriff,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Valentine Bank Doors
    -- Doors ID
    [2642457609] = {
        Pos = vector3(-309.05206298828125, 779.7301025390625, 117.72991180419922),
        Name = "Front Door 1 (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 3886827663, -- if is double door just add the door next to it here so it open both at the same time
    },
    [3886827663] = {
        Pos = vector3(-306.8853454589844, 780.1154174804688, 117.72991180419922),
        Name = "Front Door 1 (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 2642457609, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1340831050] = {
        Pos = vector3(-311.7406311035156, 774.6756591796875, 117.72991180419922),
        Name = "Gate to Tellers",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3718620420] = {
        Pos = vector3(-311.0597839355469, 770.1240234375, 117.70217895507812),
        Name = "Door Behind Tellers",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [576950805]  = {
        Pos = vector3(-307.7537536621094, 766.3489990234375, 117.70159149169922),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2343746133] = {
        Pos = vector3(-301.9361877441406, 771.751953125, 117.72990417480469),
        Name = "Door to Backrooms",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2307914732] = {
        Pos = vector3(-301.510009765625, 762.9834594726562, 117.77313232421875),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [334467483]  = {
        Pos = vector3(-302.9228210449219, 767.6043090820312, 117.69805145263672),
        Name = "Door to Hall in Vault Antechamber",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Blackwater Bank Doors
    -- Doors ID
    [531022111]  = {
        Pos = vector3(-809.141845703125, -1279.1900634765625, 42.6614990234375),
        Name = "Front Door",
        DoorState = 0,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2817192481] = {
        Pos = vector3(-817.8110961914062, -1277.66845703125, 42.65194320678711),
        Name = "Office Door",
        DoorState = 1,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2117902999] = {
        Pos = vector3(-816.7252807617188, -1276.7509765625, 42.6412353515625),
        Name = "Teller Gate",
        DoorState = 1,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1462330364] = {
        Pos = vector3(-817.7865600585938, -1274.38525390625, 42.66213226318359),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Saint Denis Bank Doors
    -- Doors ID
    [2158285782] = {
        Pos = vector3(2637.7978515625, -1298.036376953125, 51.24600982666015),
        Name = "West Entrance (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1733501235, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1733501235] = {
        Pos = vector3(2638.72216796875, -1300.0184326171875, 51.24600982666015),
        Name = "West Entrance (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 2158285782, -- if is double door just add the door next to it here so it open both at the same time
    },
    [965922748]  = {
        Pos = vector3(2648.98046875, -1300.0491943359375, 51.24539184570312),
        Name = "Manager's Office (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1634115439, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1634115439] = {
        Pos = vector3(2646.980224609375, -1300.983154296875, 51.24538421630859),
        Name = "Manager's Office (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 965922748, -- if is double door just add the door next to it here so it open both at the same time
    },
    [2817024187] = {
        Pos = vector3(2642.15673828125, -1285.4188232421875, 51.24600982666015),
        Name = "North Entrance (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 2089945615, -- if is double door just add the door next to it here so it open both at the same time
    },
    [2089945615] = {
        Pos = vector3(2640.175537109375, -1286.342529296875, 51.24600982666015),
        Name = "North Entrance (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 2817024187, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1751238140] = {
        Pos = vector3(2643.300537109375, -1300.4267578125, 51.25582504272461),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Rhodes Bank Doors
    -- Doors ID
    [3317756151] = {
        Pos = vector3(1296.27197265625, -1299.0120849609375, 76.03963470458984),
        Name = "Front Door 1 (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 3088209306, -- if is double door just add the door next to it here so it open both at the same time
    },
    [3088209306] = {
        Pos = vector3(1294.595703125, -1297.583740234375, 76.03963470458984),
        Name = "Front Door 1 (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 3317756151, -- if is double door just add the door next to it here so it open both at the same time
    },
    [2058564250] = {
        Pos = vector3(1285.1475830078125, -1303.1185302734375, 76.04006958007812),
        Name = "Door to Backrooms",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1634148892] = {
        Pos = vector3(1295.734130859375, -1305.474853515625, 76.03300476074219),
        Name = "Teller Gate",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3483244267] = {
        Pos = vector3(1282.536376953125, -1309.31591796875, 76.03642272949219),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3142122679] = {
        Pos = vector3(1278.85595703125, -1310.403076171875, 76.03964233398438),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2513778780] = {
        Pos = vector3(1279.4113769531, -1311.4263916016, 76.03205871582),
        Name = "Back Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Fort Wallace Doors
    -- Doors ID
    [385812466]  = {
        Pos = vector3(356.9841003417969, 1463.7022705078125, 178.72654724121094),
        Name = "Front Gate 1 (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 3093514944, -- if is double door just add the door next to it here so it open both at the same time
    },
    [3093514944] = {
        Pos = vector3(360.2287292480469, 1465.9957275390625, 178.7265625),
        Name = "Front Gate 1 (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 385812466, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1163537966] = {
        Pos = vector3(347.78607177734375, 1471.0980224609375, 178.77976989746094),
        Name = "1th Office Door",
        DoorState = 0,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [3489664864] = {
        Pos = vector3(337.17095947265625, 1501.4638671875, 180.9113006591797),
        Name = "2th Office Door",
        DoorState = 0,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [4248740658] = {
        Pos = vector3(346.23724365234375, 1468.9339599609375, 178.72691345214844),
        Name = "Cell Door",
        DoorState = 1,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [1223148325] = {
        Pos = vector3(363.3249206542969, 1488.7296142578125, 179.66148376464844),
        Name = "Armory Door",
        DoorState = 1,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2977782592] = {
        Pos = vector3(359.58148193359375, 1510.486328125, 179.16412353515625),
        Name = "Stable Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.FortWallace,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },

    -- Sisika Doors
    -- Doors ID
    [3158090902] = {
        Pos = vector3(3349.908935546875, -645.2470703125, 44.35463714599609),
        Name = "Front Gate 1",
        DoorState = 0,
        Permissions = Config.Permissions.Sisika,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2381465602] = {
        Pos = vector3(3350.638671875, -647.97021484375, 44.35463714599609),
        Name = "Front Gate 2",
        DoorState = 0,
        Permissions = Config.Permissions.Sisika,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
    },
    [2617210026] = {
        Pos = vector3(3325.8056640625, -705.5444946289062, 43.38306045532226),
        Name = "Back Gate 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.Sisika,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 1121239638, -- if is double door just add the door next to it here so it open both at the same time
    },
    [1121239638] = {
        Pos = vector3(3327.572265625, -707.517822265625, 43.38306045532226),
        Name = "Back Gate 1 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.Sisika,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 2617210026, -- if is double door just add the door next to it here so it open both at the same time
    },
    [3984556459] = {
        Pos = vector3(3331.8154296875, -700.0858764648438, 43.06853103637695),
        Name = "Back Gate 2 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.Sisika,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 906662604, -- if is double door just add the door next to it here so it open both at the same time
    },
    [906662604]  = {
        Pos = vector3(3333.580810546875, -702.0559692382812, 43.06853103637695),
        Name = "Back Gate 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.Sisika,
        BreakAble = Config.Lockpicks.location.lockpick,
        Difficulty = 3,
        Alert = true,
        DoubleDoor = 3984556459, -- if is double door just add the door next to it here so it open both at the same time
    },

    -- ADD MORE DOORS HERE
}
