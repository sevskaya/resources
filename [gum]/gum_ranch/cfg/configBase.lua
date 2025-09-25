Config = {}

-----------------SCRIPT RUN------------------------
Config.Debug = false--The debug version must be disabled when the script is running officially. The debug version handles script loading during runtime for settings, etc.
Config.gumFarming = true--If you have the "gum_farming" script, you can use buckets to fill water in the troughs.
Config.NotifyImage = "ranch"--Notify image
Config.RanchManage = "ranch"--Command for ranch manage
Config.AnimalPosition = "animal"--Command for animal position
Config.Only1Ranch = false--If you want to allow only one ranch per player, set this to "true".
-----------------------------------------------------
Config.BreedDebug = false

-----------------AGE SETTINGS------------------------
Config.updateTime = 15--How often will food and drink consumption be updated, products from animals generated, and age increments applied.
Config.updateAge = 0.018--The age of animals will increase every "Config.updateTime".
Config.DisableDieAnimal = true--If you want to disable animal death due to age, use "true".
-----------------------------------------------------



-------------------PRODUCTS--------------------------
Config.TakeProductIfOld = true--It prevents products from animals if they are old.
Config.BlockRideOnHorses = true--If you want block ride on horses, if not, you can ride on horses after horse get more than 4,5 years
Config.SplitTrought = false--Split troughs means that food and drink will be counted based on the maximum weight of the trough. For example, if you have a trough with a capacity of 200kg, you can place 100 food and 100 drink. If disabled, you can place 200 food and 200 drink.
Config.OnlyRanchCanTake = true--This feature allows only ranch owners/coowners to take products from animals.
Config.OnlyRanchCanTrash = true--This feature allows only ranch owners/coowners to take trash from animals.

Config.trashClean = 30 --How many seconds it takes to clean the trash from the animal area.
Config.trash = "Fertilizer"--Item ID
Config.trashProduct = {--How many trash products will be produced based on the animal satisfaction percentage.
    [5] = {"Fertilizer", 1},--[%+] = {"ItemID", "count"}
    [10] = {"Fertilizer", 1},
    [20] = {"Fertilizer", 1},
    [25] = {"Fertilizer", 2},
    [50] = {"Fertilizer", 2},
    [60] = {"Fertilizer", 3},
    [70] = {"Fertilizer", 3},
    [80] = {"Fertilizer", 3},
    [90] = {"Fertilizer", 4},
}

-----------------------------------------------------







Config.PrepayMax = 4--If Ranch Rentals are enabled, it will be possible to prepay for 4 weeks.
Config.PayDayTax = 7--The rental payment occurs every 7 days.

Config.KeyBinds = {
    refillTroughFood = 0x27D1C284,
    refillTroughWater = 0x26A18F47,
    cleanTrash = 0x27D1C284,
    buyRanch = 0x27D1C284,
    giveEatAnimal = 0x71F89BBC,
    giveDrinkAnimal = 0x760A9C6F,
    giveMedicineAnimal = 0xADEAF48C,
    collectProducts = 0x07B8BEAF,
    cuddleAnimal = 0x8CF90A9D,
    sellAnimalButton = 0x27D1C284,
}

Config.WanderAnimals = 3.0--If you want to enable the wandering of animals, set this to "true". If disabled, animals will not wander and will stay in their designated area. (its not synced with another players)
Config.EnableStorage = true--If you enable this setting, ranches in the ranch menu will have storage.
Config.StorageSize = 500--Size

Config.BlockMenuSell = false--If you want to block the sale of animals from the ranch menu.
Config.EnableSpotMenu = false--If you want to enable the sale of animals at designated locations. This means you must lead the animals to the specified place and sell them there.
Config.SellAnimalSpot = {
    ["Valentine Ranch Sell"] = {
        blipSetting = {
            blipEnabled = true,
            blipSprite = 423351566,
        },
        baseSetting = {
            coords = {-223.98753356933597, 640.5254516601562, 113.21456146240236},
        }
    },
    ["Emerald Ranch Sell"] = {
        blipSetting = {
            blipEnabled = true,
            blipSprite = 423351566,
        },
        baseSetting = {
            coords = {1316.8935546875,292.3488464355469,87.83221435546875},
        }
    },
}

Config.BlipRanchColor = "BLIP_STYLE_AREA_FOW"--Blip color for ranch

Config.expTableForAnimals = {
    -- Recalculating products based on experience. If the animal is satisfied and leveled up, it will produce up to 1.9x more products than an unleveled animal.
    --[lvl] = {expHit, multiplier}
    [0] = {0, 1.0},
    [1] = {500, 1.0},
    [2] = {1000, 1.1},
    [3] = {2000, 1.2},
    [4] = {4000, 1.3},
    [5] = {8000, 1.4},
    [6] = {16000, 1.5},
    [7] = {32000, 1.6},
    [8] = {64000, 1.7},
    [9] = {128000, 1.8},
    [10] = {224000, 1.9},
}

Config.CanPickFertiWithHand = false--If this feature is disabled, the player can only collect trash products with the "Rake" item.
Config.RakeItem = "rake"--Rake item ID
