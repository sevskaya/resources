Config = {}

Config.DevMode = false  -- use true to see the Zones perfect to setup!!

local glm = require "glm"

Config.Zones = {
    {
        name = "Test Zone 1", -- name of the zone
        thickness = 10, -- height
        point = glm.polygon.new(
            {
                vec3(2768.877197265625, -1470.9637451171875, 44.40254974365234),
                vec3(2793.24169921875, -1444.8707275390625, 44.39614105224609),
                vec3(2774.920654296875, -1429.750732421875, 44.39285659790039),
                vec3(2746.66650390625, -1459.2442626953125, 44.39260482788086),
            }
        ),
        outerZone = nil, -- defines the outer zone. if nil, then it is generated automatically.
        outerZoneDistance = 200.0, -- size of the distance from the outer zone
        deleteAll = true, -- deletes all objects in the zone. 
        objects = { -- objects in the list will be deleted.
            {
                model = `p_tree_apple_01`,
                coords = vec3(2996.754638, 1396.794067, 43.584380),
                distance = 1.0
            },
        },
    },
    {
        name = "Test Zone 2", -- name of the zone
        thickness = 3, -- height
        point = glm.polygon.new(
            {
                vec3(2417.09521484375, -1078.447998046875, 47.95),
                vec3(2416.97460937500, -1083.461181640625, 47.95),
                vec3(2406.51464843750, -1083.390747070312, 47.95),
                vec3(2406.53027343750, -1080.394409179687, 47.95),
	vec3(2408.4423828125, -1078.449951171875, 47.95),
            }
        ),
        outerZone = nil, -- defines the outer zone. if nil, then it is generated automatically.
        outerZoneDistance = 50.0, -- size of the distance from the outer zone
        deleteAll = true, -- deletes all objects in the zone. 
        objects = { -- objects in the list will be deleted.
            {
                model = `p_tree_apple_01`,
                coords = vec3(2996.754638, 1396.794067, 43.584380),
                distance = 1.0
            },
        },
    },
}