Config = {}

Config.DevMode = true

--Veg Modifiers Flags
local Debris = 1
local Grass = 2
local Bush = 4
local Weed = 8
local Flower = 16
local Sapling = 32
local Tree = 64
local Rock = 128
local LongGrass = 256
local AllFlags = Debris + Grass + Bush + Weed + Flower + Sapling + Tree + Rock + LongGrass

-- Veg Modifier Types
local VMT_Cull = 1
local VMT_Flatten = 2
local VMT_FlattenDeepSurface = 4
local VMT_Explode = 8
local VMT_Push = 16
local VMT_Decal = 32
local AllModifiers = VMT_Cull + VMT_Flatten + VMT_FlattenDeepSurface + VMT_Explode + VMT_Push + VMT_Decal

Config.VegZones = {
    { -- spooni_sd_farming Hall
        coords = vector3(2683.269, -840.933, 42.300), -- Coords
        radius = 10.0, -- Radius
        distance = 50.0, -- View Distance
        vegmod = { flag = AllFlags, type = AllModifiers } -- Veg Modifiers Flags/Types -1548.163330078125, 3117.413330078125, 476.2898254394531
    },
    { -- spooni_sd_farming Hall
    coords = vector3(-1548.163330078125, 3117.413330078125, 476.2898254394531), -- Coords
    radius = 30.0, -- Radius
    distance = 50.0, -- View Distance
    vegmod = { flag = AllFlags, type = AllModifiers } -- Veg Modifiers Flags/Types             vector3(-5738.432, -4502.987, -7.334)        
    },
    { -- spooni_sd_farming Office
        coords = vector3(-1575.2752685546875, 3153.0068359375, 480.2392578125), 
        radius = 20.0,
        distance = 50.0,
        vegmod = { flag = AllFlags, type = AllModifiers }
    },
    { -- spooni_sd_farming Office
    coords = vector3(-5726.426, -4502.104, -7.036),                                                    
    radius = 10.0,
    distance = 50.0,
    vegmod = { flag = AllFlags, type = AllModifiers }
    },
    { -- spooni_sd_farming Office
    coords = vector3(-5690.003, -4485.723, -7.372),                                                     
    radius = 10.0,
    distance = 50.0,
    vegmod = { flag = AllFlags, type = AllModifiers }
    },
}
