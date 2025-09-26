

---------------------- ░█████╗░░█████╗░████████╗████████╗██╗░░░░░███████╗  ██████╗░██████╗░██╗██╗░░░██╗███████╗----------
---------------------- ██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║░░░░░██╔════╝  ██╔══██╗██╔══██╗██║██║░░░██║██╔════╝----------
---------------------- ██║░░╚═╝███████║░░░██║░░░░░░██║░░░██║░░░░░█████╗░░  ██║░░██║██████╔╝██║╚██╗░██╔╝█████╗░░----------
---------------------- ██║░░██╗██╔══██║░░░██║░░░░░░██║░░░██║░░░░░██╔══╝░░  ██║░░██║██╔══██╗██║░╚████╔╝░██╔══╝░░----------
---------------------- ╚█████╔╝██║░░██║░░░██║░░░░░░██║░░░███████╗███████╗  ██████╔╝██║░░██║██║░░╚██╔╝░░███████╗----------
---------------------- ░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚══════╝  ╚═════╝░╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚══════╝----------
-------------------------------------------------------𝕓𝕪 𝕖𝕣𝕖𝕓𝕦𝕤𝟛𝟚𝟚𝟚----------------------------------------------------
---------------------- ℙ𝕝𝕖𝕒𝕤𝕖 𝕣𝕖𝕒𝕕 𝕥𝕙𝕖 𝕔𝕠𝕞𝕞𝕖𝕟𝕥𝕤 𝕨𝕚𝕥𝕙𝕚𝕟 𝕥𝕙𝕚𝕤 𝕔𝕠𝕟𝕗𝕚𝕘 𝕗𝕚𝕝𝕖 𝕥𝕠 𝕡𝕣𝕠𝕡𝕖𝕣𝕝𝕪 𝕣𝕦𝕟 𝕠𝕟 𝕪𝕠𝕦𝕣 𝕤𝕖𝕣𝕧𝕖𝕣.-----------------
---------------------- 𝕊𝕦𝕡𝕡𝕠𝕣𝕥 𝕚𝕤 𝕡𝕣𝕠𝕧𝕚𝕕𝕖𝕕 𝕚𝕟 𝔻𝕀𝕊ℂ𝕆ℝ𝔻. ----------------------------------------------------------------
---------------------- 𝕌𝕡𝕕𝕒𝕥𝕖𝕤 𝕨𝕚𝕝𝕝 𝕒𝕝𝕨𝕒𝕪𝕤 𝕓𝕖 𝕒𝕟𝕟𝕠𝕦𝕟𝕔𝕖𝕕. --------------------------------------------------------------


Config = {
    debug = true, -- Provides many client side prints to help debug any issues.
    defaultlang = 'en_lang',
    Key = 0x760A9C6F, -- 'G' Key -- Some keys work others dont change this at your own risk.
    ---- By default the more cattle a player has the harder it is and longer it takes to get them to the seller zone. 
    ---- Increasing WanderChance and decreasing MaxFollowDistance will make it even harder, so will decreasing the HerdTimeCheck.
    MaxFollowDistance = 50.0, -- Maximum distance before the cattle stop following.
    WanderChance = 5, -- The chance that the cows will randomly stop following and need to be captured again.
    WaitDistance = 7.0, -- The distance that the cows will "wait" for the player to move.
    PlayerMovementThreshold = 2.0, -- the distance player moves before cows start following again after getting close.
    HerdTimeCheck = 20000, -- the time between distance and wander checks. 1000 = 1 second 

    -- HerdZones Config
    HerdZones = {
        {
            coords = vector3(431.8411, -19.5580, 109.3192), ---coords for the center of the zone
            radius = 25.0, -- radius of the zone
            name = "Herd1", --Name of the herd from HerdSpawn section below, the herd name must match 
            appearanceChance = 9, -- % chance for the herd to spawn when player enters the area
        },
        {
            coords = vector3(1713.02, -213.36, 77.59),
            radius = 35.0,
            name = "Herd2",
            appearanceChance = 6,
        },
        {
            coords = vector3(1263.73, 685.49, 92.27),
            radius = 35.0,
            name = "Herd3",
            appearanceChance = 7,
        },
        {
            coords = vector3(174.39, 802.87, 188.16),
            radius = 35.0,
            name = "Herd4",
            appearanceChance = 8, -- 60% chance
        },
        -- Add more zones as needed
    },
    HerdSpawn = {-- this is where you define each spawn for different zones. 
        Herd1 = {--MUST MATCH NAME IN HERDZONES
            { model = 'A_C_Cow', spawnpoint = vector4(424.6364, -47.6337, 109.1254, 116.2319) },
            { model = 'A_C_Cow', spawnpoint = vector4(413.1532, -57.4077, 110.3754, 67.4843) },
            { model = 'A_C_Cow', spawnpoint = vector4(393.8228, -56.5883, 110.1550, 54.7916) },
            { model = 'A_C_Cow', spawnpoint = vector4(389.2286, -41.9948, 109.9951, 356.2169) },
            { model = 'A_C_Cow', spawnpoint = vector4(388.9354, -16.6511, 108.4244, 333.5460) },
            { model = 'A_C_Cow', spawnpoint = vector4(397.9000, 5.2379, 107.7955, 6.5744) },
            { model = 'A_C_Cow', spawnpoint = vector4(435.44, -45.13, 110.87, 224.59) },
            { model = 'a_c_bull_01', spawnpoint = vector4(423.8056, 16.5907, 108.6001, 262.3212) },
        },
        Herd2 = {--MUST MATCH NAME IN HERDZONES
            { model = 'A_C_Cow', spawnpoint = vector4(1717.92, -230.06, 77.28, 169.04) },
            { model = 'A_C_Cow', spawnpoint = vector4(1696.19, -244.12, 72.69, 117.64) },
            { model = 'A_C_Cow', spawnpoint = vector4(1662.37, -250.26, 75.5, 117.68) },
            { model = 'A_C_Cow', spawnpoint = vector4(1641.07, -224.06, 76.68, 47.46) },
            { model = 'A_C_Cow', spawnpoint = vector4(1635.85, -187.47, 78.23, 19.47) },
            { model = 'A_C_Cow', spawnpoint = vector4(1649.48, -167.73, 80.1, 327.45) },
            { model = 'a_c_bull_01', spawnpoint = vector4(1665.07, -134.01, 80.26, 2.42) },
        },
        Herd3 = {--MUST MATCH NAME IN HERDZONES
            { model = 'A_C_Cow', spawnpoint = vector4(1281.74, 692.26, 90.96, 353.56) },
            { model = 'A_C_Cow', spawnpoint = vector4(1300.22, 713.55, 88.49, 301.21) },
            { model = 'A_C_Cow', spawnpoint = vector4(1301.01, 700.61, 88.07, 175.67) },
            { model = 'A_C_Cow', spawnpoint = vector4(1245.11, 677.81, 92.69, 95.67) },
        },
        Herd4 = {--MUST MATCH NAME IN HERDZONES
            { model = 'A_C_Cow', spawnpoint = vector4(191.46, 793.99, 185.95, 296.4) },
            { model = 'A_C_Cow', spawnpoint = vector4(201.79, 818.08, 186.81, 333.2) },
            { model = 'A_C_Cow', spawnpoint = vector4(200.46, 838.56, 187.71, 353.89) },
            { model = 'A_C_Cow', spawnpoint = vector4(165.98, 863.52, 193.07, 46.92) },
            { model = 'A_C_Cow', spawnpoint = vector4(135.53, 847.69, 195.2, 46.51) },
        },

        -- Zone2 = {
        --     { model = 'A_C_Cow', spawnpoint = vector4(1293.0657, -6869.9204, 43.2063, 226.7794) },
        --     { model = 'A_C_Cow', spawnpoint = vector4(1290.8406, -6860.7803, 43.1331, 180.6018) }
        -- }

        -- Add more spawns as needed
    },
    CurrencyType = 0,  -- Currency type for payment (e.g., "money", "gold", etc.)
    HerdSalePrice = 15,  -- Example value, price per cow sold
    rewardItems = true,
    itemRewards = {
        "beef",
        "milk",
    },
}


Config.HerdLocations = {
    [1] = {
        -- Buyer Ped Config
        SpawnBuyerPed = true, -- Enable or Disable NPC
        buyerPed = "u_f_m_tumgeneralstoreowner_01", -- NPC for the sell zone
        buyerBlip = 423351566, -- Blip for the sell zone
        HerdBuyer = vector4(2641.67, -864.76, 42.29, 28.57), -- NPC coordinates 
        SellZoneCircle = vector3(2641.67, -864.76, 42.29), -- The Circle that will sell the herded cattle
        SellZoneRadius = 7.5, -- Radius around NPC where selling occurs (in meters)
        SellZoneCircleGlow = true, -- Enable or Disable The glowing circle around the sell zone
        SellZoneCircleDrawDistance = 50.0, -- Draw distance for the circle
        GlowRed = 255,           -- Range 0 - 255
        GlowGreen = 241,         -- Range 0 - 255
        GlowBlue = 143,         -- Range 0 - 255    GlowTransparency = 50, -- Range 0 - 255
        GlowTransparency = 150, -- Range 0 - 255
    },
    [2] = {
        -- Buyer Ped Config
        SpawnBuyerPed = true, -- Enable or Disable NPC
        buyerPed = "u_f_m_tumgeneralstoreowner_01", -- NPC for the sell zone
        buyerBlip = 423351566, -- Blip for the sell zone
        HerdBuyer = vector4(-63.29, -409.76, 70.64, 7.49), -- NPC coordinates 
        SellZoneCircle = vector3(-63.29, -409.76, 70.64), -- The Circle that will sell the herded cattle
        SellZoneRadius = 7.5, -- Radius around NPC where selling occurs (in meters)
        SellZoneCircleGlow = true, -- Enable or Disable The glowing circle around the sell zone
        SellZoneCircleDrawDistance = 50.0, -- Draw distance for the circle
        GlowRed = 255,           -- Range 0 - 255
        GlowGreen = 241,         -- Range 0 - 255
        GlowBlue = 143,         -- Range 0 - 255    GlowTransparency = 50, -- Range 0 - 255
        GlowTransparency = 150, -- Range 0 - 255
    },
    [3] = {
        -- Buyer Ped Config
        SpawnBuyerPed = true, -- Enable or Disable NPC
        buyerPed = "u_f_m_tumgeneralstoreowner_01", -- NPC for the sell zone
        buyerBlip = 423351566, -- Blip for the sell zone
        HerdBuyer = vector4(-1143.77, -1787.03, 61.24, 198.55), -- NPC coordinates 
        SellZoneCircle = vector3(-1143.77, -1787.03, 61.24), -- The Circle that will sell the herded cattle
        SellZoneRadius = 7.5, -- Radius around NPC where selling occurs (in meters)
        SellZoneCircleGlow = true, -- Enable or Disable The glowing circle around the sell zone
        SellZoneCircleDrawDistance = 50.0, -- Draw distance for the circle
        GlowRed = 255,           -- Range 0 - 255
        GlowGreen = 241,         -- Range 0 - 255
        GlowBlue = 143,         -- Range 0 - 255    GlowTransparency = 50, -- Range 0 - 255
        GlowTransparency = 150, -- Range 0 - 255
    },

    -- Add more locations as needed
}