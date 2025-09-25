Config = {}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
Base
*/

Config.DebugAndBaseOption = {
    debug = false,
    debugLegendaryAnimals = false,
    blipSwapTime = true,  -- This Option will change the color of the Blip when a Stables is open/closed
    enableMarkers = false, 
    RGBAMarkers = {255, 255, 100, 30}, -- Marker Color
    mainStables = 1, 
    administrationCommand = "trainer", -- Command for open menu (nil is disabled)
    deleteHorseCartCommand = "dv",-- Job for delete horse and cart
    defaultUnemployedJob = "unemployed", -- Default job for unemployed players

    adminCommand = "delHorseCart",
    ["deleteAdmin"] = {
        "admin",
        "mod"
    },
}

-- If you need to despawn horse or wagon from another script add only this to script For example : Using a different housing script or a clothing script that instances the player, you would want to trigger the flee event in order to avoid a duplicate horse
-- TriggerEvent("gum_stables:fleeHorseInstant")
-- TriggerEvent("gum_stables:fleeCartInstant")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
Stables logic for horses
*/

Config.HorseStablesLogic = {
    -- If you enable this, you can call horses only from stables
    callFromStables = false,
    
    respawnAfterLogin = true, -- If enabled, after you connect back to the server, your horse is respawned on same position
    sellOldHorseForMoney = false, -- If enabled, you can sell old horses for their normal price, if you disable, you can sell horse for 0$
    loseSomeExps = false, -- If you have enabled, you can lose some exps for horses after sell
    loseSomeExpsValues = {0.1, 0.2}, -- {min, max} % for lose exps after server restart

    horseScale = {-7, 2}, -- Its scale for coloring horses. This increase/decrease values for horses in color customizatioon
    horseBlackmarketDelay = 60, -- 60 sec for again sell horses on blackmarket (0 is disabled)

    ["healPrice"] = {
        calculate = true,--If you have enabled you can calculate price for heal horses from default horses price. (price is %)
        price = 10,--If you have disabled calculate price you can set price for heal horses (0 is disabled) (price = fixed $ price)
    },

    -- If you enable this, if you save horse to stables in Valentine, you can see only in Valentine not in another stables
    ["whereTheyAreKept"] = {
        enabled = false,
        transferPrice = 150,--Price to transfer horses between stables  (0 is disabled)
    },
    
    -- If you enable this, you can increase base stats for horses (acceleration, turn, speed)
    ["shoes"] = {
        shoeItem = "Horse_Shoe", -- Item for increase base stats
        perLevel = 1, -- Per 1 shoes per 1 level
        maxLevel = 9, -- Max level for horse shoes
        degradeWhileRide = 0, -- If you have enabled, shoes degrade while you ride on horse (0 = Disabled / Value is % chance) and can be used 1.2% or 0.2% values
        degradeWhileLead = 0, -- If you have enabled, shoes degrade while you lead horse (0 = Disabled / Value is % chance) and can be used 1.2% or 0.2% values
        degradeEverySecond = 10, -- Every 10 second shoes try degrade shoe (if you have enabled)
    },
    -- If you enable this, you can mate horses with each other
    ["mating"] = {
        priceCalculate = true,--If you have enabled you can calculate price for mating horses from default horses price.
        priceForPay = 100,--If you have disabled priceCalculate you can set price for mating horses if you have enabled priceCalculate you can set % value for split both price to your price
        priceDistance = 60,-- If you have enabled you can mate horses in price range +- from first horse (if you have disabled you can mate all horses without range)
        time = 57600,-- 16h

        chanceAfterBuy = 50, -- 50% chance for mating state after buy horse
        chanceAfterSaveWild = 50,-- 50% chance for mating state after save wild horse
        chanceAfterMating = 50,-- 50% chance for mating state after mating horse

        giveMatingToMaleHorse = "BreederFix",-- If you have enabled, you can enable mating for male gender where is "Disabled mating". (nil is disabled)
        giveMatingToFemaleHorse = "BreederFix",-- If you have enabled, you can enable mating for female gender where is "Disabled mating". (nil is disabled)

        txAdminMatingCalculator = true,--If you have enabled, you can use TX Admin for mating calculator, if not use number. For time for save mating data
        txAdminDisabledTimer = 60,--Time for save mating data
    },

    ["componentPrices"] = {
        blanketUnderSaddle = 1.29,
        pearOnSaddle = 0.20,
        sleepingBag = 0.55,
        bridle = 5.55,
        saddle = 12.50,
        holster = 0.10,
        bags = 10.00,
        stirrups = 0.55,
        lantern = 5.90,
        mask = 0.10,
        mustache = 0.10,
        mane = 0.20,
        tail = 0.20,
        props = 5.55,
        headProps = 0.10,
        horseColorPrice = 0.10,--0 is disabled
        
        enabledColorTailAndMane = true,
        horseTransformation = true, -- If you have enabled, you can transform horses like size hoof etc.
    },
    
    ["storeHorseAge"] = {
        smallHorses = {1, 5}, -- Small horses (cub) age range
        normalHorses = {5, 20}, -- Normal horses age range
        wildHorses = {5, 20}, -- Wild horses age range
    },
    
    ["wildHorses"] = {
        cooldownForTameAgain = 30, -- min for again tame horse (0 is disabled)
        cooldownForSellTameAgain = 30, -- min for again sell horse (0 is disabled)
        canSellWildHorses = true, -- If you have enabled, you can sell wild horses
        canSaveWildHorses = true, -- If you have enabled, you can save wild horses
        fixAnimation = true, -- This trigger animation if you tame horses (some peds have problem with bad animation)
        payForSavePercent = 10, -- Pay % for save wild horse from original price from stables (0 is disabled)
        ["minigames"] = {--You can choise only 1 minigame (keypress or dragging)
            ["KeyPress"] = {--Random keypress while you tame horse
                enabled = false,
                minigameTimePress = 150, -- Time for press key
                ["KeyTable"] = {
                    [1] = {0xE6F612E4, "1"},
                    [2] = {0x1CE6D9EB, "2"},
                    [3] = {0x4F49CC4C, "3"},
                    [4] = {0x8F9F9E58, "4"},
                    [5] = {0xAB62E997, "5"},
                    [6] = {0xA1FDE2A6, "6"},
                },
            },
            ["Dragging"] = {--Press space and try drag horse on slider
                enabled = true,
                minigameDifficulty = 1.0, -- Difficulty for drag horse. Smaller value is more easy, higher is more hard.
            },
        }
    },
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
Logic centered on horses
*/

Config.HorseLogic = {
    renameItem = "HorseTag", -- Item for rename horse
    peltsOnHorse = true,--Enable option add pelts from animals on horse. (false is disabled)
    allHaveSameStats = false, -- If you have enabled, all horses have same stats
    cooldownForAgainWhistle = 5, -- 5 sec for again call horse (0 is disabled)
    horseWhistleDistance = 100.0, -- Distance for horse whistle where come to you
    comeToYouIfOutOfRange = 80.0, -- Horse come to you if you are out of range (0 is disabled)
    despawnOnRange = 100.0, -- If you have enabled, horse is despawned if you are out of range (0 is disabled)
    spawnRangeAfterWhistle = {30, 40}, -- Random range for spawn horse if you are not near node
    horseFollowYou = 6.0, -- If you whistle your horse in this range horse start follow you (0 is disabled)
    accessToStorage = true,--If you have enabled you can access to storage in stables
    accessOnlyById = true,--If you have enabled player can see your storage only if you add him via ID (if you have disabled you have access to all players storage)
    changeSitCommand = "changeSit",--Command for change how you sit on horse
    commandHitPlayer = "shotHim",  -- "shotHim" is command for hogtied hit player on horse


    ["ageingSetup"] = {
        realTime = true, -- If you have enabled, horses age in real time, if you disable, horses age in game time
        ageUpdateTime = 30, -- 30 min for check age
        ageUpdate = {0.009, 0.009}, -- Calculation   24hours ==== (day have 30min 58x) =  58 * 0.009 = 0.522 ages for 24 Hours (small/big horses)
        maxAge = 30, -- Max age for horses where go to state old
        deadOnOld = 10, -- If horse old you have chance for "dead" (10% chance and 0 is disabled)
        ageCheck = 30, -- 30 sec for check age
        resetItem = nil, -- Item for reset age (nil is disabled)
        resetAgeTo = 1, -- Reset age to 1 year
    },

    ["hitchProps"] = {
        enabled = true, -- If you have enabled, you can hitch horses to props (like default game, this only check near props and disable prompts if you are near to hitch post)
        props = {
            [GetHashKey("p_hitchingpost01x")] = true,
            [GetHashKey("p_horsehitchnbd01x")] = true,
        }
    },
    ["statusSetup"] = {
        brushItem = "Brush", -- For cleaning horse
        
        saveStatus = true, -- Save status sprint, health etc.

        eatSpamProtect = 10, -- 10 sec delay for spamming eat
        horseKick = false, -- If you enable, your horse can kick you

        trainTrackCheck = 15, -- Check every 15 second if you ride on train track (0 is disabled)
        trainTrackChance = 10, -- 10% chance for ragdoll state for your horse
        
        ["dirt"] = {
            enabled = true, -- If you want save dirty level for your horse, with thsi you can reduce "dirty level" horse
            updateTime = 5, -- Every 5 second update dirty status
            valueDowngrade = 10, -- Every 10 second +1 dirty value
            
            downInWater = 500, -- Dirty down is horse in water. Dirty go down every DirtyUdpate  -> (Max value of dirty is 10000)
            downInRain = 500, -- Dirty down is weather rainy. Dirty go down every DirtyUdpate  -> (Max value of dirty is 10000)
            downWithBrush = 2000, -- Down with brush
            
            onlyWhileRide = true, -- Dirty is only while ride
        },
        
        ["metabolism"] = {
            enabled = true, -- If you want save hunger and thirst level for your horse, with thsi you can reduce "hunger and thirst" horse
            updateTime = 15, -- Every 15 second go down hunger and thirst (0 is disabled metabolism)
            
            healthStaminaTimeDown = 15, -- Every 15 second go down health and stamina if health is under 5%
            healthStaminaDown = {5, 5}, -- {Health, stamina} - down every healthStaminaTimeDown second if horse have under 5% hunger and thirst

            ["downgradeThirstHunger"] = {
                idle = {0.01, 0.05}, -- {hunger, thirst} - down every updateTime second if horse is idle
                walk = {0.01, 0.06}, -- {hunger, thirst} - down every updateTime second if horse is walk
                run = {0.02, 0.07}, -- {hunger, thirst} - down every updateTime second if horse is run
                sprint = {0.03, 0.08}, -- {hunger, thirst} - down every updateTime second if horse is sprint
                jump = {0.50, 0.50}, -- {hunger, thirst} - down every updateTime second if horse is jump

                wallow = {0.10, 0.10}, -- {hunger, thirst} - down every updateTime second if horse is wallow
                longingJump = {0.50, 0.50}, -- {hunger, thirst} - down every updateTime second if horse is jump on longing
                rearHorse = {0.20, 0.05}, -- {hunger, thirst} - down every updateTime second if horse is rear
                footScratch = {0.20, 0.05}, -- {hunger, thirst} - down every updateTime second if horse is foot scratch
                dance = {0.20, 0.05}, -- {hunger, thirst} - down every updateTime second if horse is dance
                jumpPos = {0.20, 0.05}, -- {hunger, thirst} - down every updateTime second if horse is jump on position
            },

            ["drinkProps"] = { -- This abble skill for "drink from water but for troughts (must be front side)"
                [GetHashKey("p_watertrough02x")] = {
                    front = {0.0, -1.1, 0.0},
                    back = {0.0, 1.1, 0.0},
                },
                [GetHashKey("p_watertrough01x")] = {
                    front = {0.0, -1.1, 0.0},
                    back = {0.0, 1.1, 0.0},
                }
            },
            ["gainWhileDrink"] = {
                health = 0.05,
                stamina = 0.0,
                hunger = 0.0,
                thirst = 0.05,
            },

            ["eatProps"] = { -- This abble skill for "eat froms troughts/trought (must be front side)"
                [GetHashKey("p_haybale03x")] = {0.0, 0.0, 0.0},
                [GetHashKey("p_haypile02x")] = {0.0, 0.0, 0.0},
                [GetHashKey("p_haypile01x")] = {0.0, 0.0, 0.0},
            },

            ["grazeBlockLocations"] = {
                {name = "Valentine", coords = vector3(-299.9077453613281, 790.55078125, 118.2311019897461), radius = 100.0},
                {name = "Saint Denis", coords = vector3(2644.359619140625,-1281.004638671875,52.3095588684082), radius = 400.0},
                {name = "Blackwater", coords = vector3(-808.0335083007812, -1314.989013671875, 43.68943405151367), radius = 150.0},
                {name = "Rhodes", coords = vector3(1328.167724609375,-1316.4310302734375,77.97126007080078), radius = 150.0},
                {name = "Annesburg", coords = vector3(2931.454833984375,1333.7122802734375,44.14835739135742), radius = 170.0},
                {name = "Strawberry", coords = vector3(-1785.322265625,-394.0451965332031,157.58975219726565), radius = 80.0},
                {name = "Armadillo", coords = vector3(-3685,-2602.500244140625,-13.84037494659423), radius = 85.0},
                {name = "Tumbleweed", coords = vector3(-5510.14306640625,-2944.08154296875,-1.77733123302459), radius = 70.0},
                {name = "Van Horn", coords = vector3(3018.74951171875,513.6425170898438,44.07705688476562), radius = 140.0},
            },
            
            ["gainWhileEat"] = {
                health = 0.0,
                stamina = 0.05,
                hunger = 0.05,
                thirst = 0.0,
            },
            
            ["itemsForUse"] = {
                -- ItemID = {type, propInHand, baseHealth, goldHealth, baseStamina, goldStamina, hunger, thirst, useFromOtherScript(it mean if you use item in another script)}
                Apple = { type="eat", propInHand="p_apple01x", baseHealth=40, healthOuter=20, goldHealth=0.0, baseStamina=0, staminaOuter=20.0, goldStamina=0.0, hunger=20.0, thirst=5.0, useFromOtherScript=false },
                Hay = { type="eat", propInHand="p_haypilepitchfork01x", baseHealth=30, healthOuter=20, goldHealth=0.0, baseStamina=10, staminaOuter=20.0, goldStamina=0.0, hunger=20.0, thirst=0.0, useFromOtherScript=false },
                Sugar = { type="eat", propInHand="p_haypilepitchfork01x", baseHealth=20, healthOuter=20, goldHealth=0.0, baseStamina=15, staminaOuter=20.0, goldStamina=0.0, hunger=30.0, thirst=-5.0, useFromOtherScript=false },
                Wild_Carrot = { type="eat", propInHand="p_haypilepitchfork01x", baseHealth=0, healthOuter=20, goldHealth=0.0, baseStamina=30, staminaOuter=20.0, goldStamina=0.0, hunger=30.0, thirst=5.0, useFromOtherScript=false },

                Heal_For_Horse = { type="stimulant", baseHealth=0, healthOuter=20, goldHealth=0.0, baseStamina=0, staminaOuter=20.0, goldStamina=0.0, hunger=50.0, thirst=50.0, useFromOtherScript=false, healItem=true },
                Boost_For_Horse = { type="stimulant", baseHealth=0, healthOuter=20, goldHealth=0.0, baseStamina=100, staminaOuter=20.0, goldStamina=0.0, hunger=50.0, thirst=50.0, useFromOtherScript=false },
                Gold_For_Horse = { type="stimulant", baseHealth=100, healthOuter=20, goldHealth=1000.0, baseStamina=100, staminaOuter=20.0, goldStamina=1000.0, hunger=50.0, thirst=50.0, useFromOtherScript=false },
            },
        },
        ["hoofHook"] = {
            enabled = true, -- If you have enabled status, and enabled this, your hoof need cleaning
            item = "Hoof_Hook", -- For cleaning hoof on horses
            removeAfterUse = true, -- Remove item after use
            timer = 30, -- Every 30 second go down dirty hoof

            ["reductionDirt"] = {
                sprint = 0.03,
                run = 0.02,
                walk = 0.01,
            },

            ["reductionSpeed"] = {
                [1] = {100, 0.0},
                [2] = {80, 0.1},
                [3] = {60, 0.2},
                [4] = {40, 0.3},
                [5] = {20, 0.4},
                [6] = {10, 0.5},
                [7] = {0, 0.6},
            }
        },
    },
    
    ["experienceSystem"] = {
        maxHorseLevel = 4, -- Max level for horse
        blockExpWhileCinematicCamera = true, -- If you want this block exping while user use cinematic camera

        -- type {level, event, command, enabledCommand}
        horseRest = {4, "gum_stables:restHorse", "horseRest", true}, -- Horse rest
        horseSleep = {3, "gum_stables:sleepHorse", "horseSleep", true}, -- Horse sleep
        horseWallow = {2, "gum_stables:wallowHorse", "horseWallow", true}, -- Horse play
        horseDrink = {0, "gum_stables:drinkHorse", "horseDrink", true}, -- Drink from water/trought
        horseEat = {0, "gum_stables:eatHorse", "horseEat", true}, -- Eat from hay etc.

        drainStamina = {[1] = 0.90, [2] = 0.80, [3] = 0.70, [4] = 0.60}, -- Drain stamina by level ([Level] = HowMuch)
        
        ["experienceGain"] = {
            expTimer = 10, -- Every 10 second add Exp to horse if player lead, or walk with horse etc.

            ifIsSmallHorse = 3, -- If horse is small horse (cub)
            ifIsBigHorse = 1, -- If horse is adult horse

            whileWalking = 1,
            whileRunning = 2,
            whileSprinting = 3,
            whileLeading = 4,
            whileNormalJump = 7,
            whileJumpingOnHorseSpamProtect = 10,--This protect gain exp if you spamming jump on horse (in second)
            
            whileFeed = 1,
            whileBrush = 1,
            
            --Exps table for trainers
            whileCommand = 5,
            whileDancing = 20,
            whileRearUp = 5,
            whileFootScrats = 5,
            whileLongingJump = 10,
            whileJumpingOnLongingSpamProtect = 10,
            whileSwitchSide = 5,
            whileSwitchSideLongingSpamProtect = 10,
            
            ["commandExps"] = {
                cmdRest = 10,
                cmdSleep = 10,
                cmdWallow = 10,
                cmdDrink = 10,
            },

            ["advancedPoints"] = {
                [1] = {
                    --- First and last is without experience (start/end) other have 10 experiences for hit points
                    [1] = {-388.2054138183594,773.63037109375,114.78234100341795,144.97723388671875},
                    [2] = {-391.1778259277344,766.098388671875,116.91128540039064,181.2207183837891, 10},
                    [3] = {-400.031005859375,766.2957763671875,116.91128540039064, 151.73672485351565, 10},
                    [4] = {-403.2525329589844,779.0784301757812,116.91128540039064, 95.52924346923828, 10},
                    [5] = {-391.3192138671875,791.64794921875,116.91128540039064,181.2207183837891, 10},
                    [6] = {-390.4527587890625,787.0637817382812,114.87767791748048,188.95091247558597}
                }, 
            }
        },
    },

    
    ["bondingSystem"] = {--Bonding system how much is horse friend with you.
        enabled = true,
        chanceGainLevel = {50, 80}, -- 50% is chance for gain bonding level for users, 80% is chance for gain bonding level for trainers
        tickTime = 10, -- Every 10 second try horse made interaction for bonding level

        badSituation = "random", -- If you have enabled, you can set "random" or "fixed" bad situation random is from time to time, and fixed is every same time
        badSituationTimer = {10, 15}, -- 10-15 min randomly (first number is if you have "fixedů bad situation)

        -- Its timer for bad situations. Like horse shot you down, or horse is scarry from you.
        -- Format is : [Level] = Chance
        badSituationChance = { [10] = 0, [9] = 10, [8] = 15, [7] = 20, [6] = 25, [5] = 30, [4] = 35, [3] = 40, [2] = 45, [1] = 50, [0] = 70}
    },
    
    ["courageSystem"] = {--Courage system how much is horse scarred from fire, snakes etc.
        enabled = true,
        
        maxCourage = 9, -- Max courage level (9 is max. You can downgrade value, but cant increase)
        chanceGainLevel = 70, -- 50% is chance for gain courage level for users, 80% is chance for gain courage level for trainers

        shockScaryLevel = {true, 9}, -- If you have enabled, you can disable scarry shock level for horses
        gunshotScaryLevel = {true, 9}, -- If you have enabled, you can disable gunshot scarry for horses
    },
    
    ["transferComponents"] = {
        enabled = true,
        command = "transferSaddle",
        ["components"] = {
            blanketUnderSaddle = true,
            pearOnSaddle = true,
            sleepingBag = true,
            bridle = true,
            saddle = true,
            holster = true,
            bags = true,
            stirrups = true,
            lantern = true,
            mask = true,
        },
        
        ["saddleStands"] = {-- for save saddles on saddle-stand  ["ModelName"] = "itemId",
            ["p_saddlestand01x"] = "saddleStand_1",
            ["p_saddlestand02x"] = "saddleStand_2",
            ["p_saddlestand03x"] = "saddleStand_3",
        },
    },

}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
Stables logic for carts
*/

Config.CartStablesLogic = {
    callFromStables = true, -- If you enable this, you can call carts only from stables
    callDelay = 5, -- 5 sec for call horse (0 is disabled)
    respawnAfterLogin = true, -- If enabled, after you connect back to the server, your cart is respawned on same position
    despawnOnRange = 100.0, -- If you have enabled, cart is despawned if you are out of range (0 is disabled)
    spawnRangeAfterWhistle = {30, 40}, -- Random range for spawn cart if you are not near node
    cooldownForAgainWhistle = 5, -- 5 sec for again call cart (0 is disabled)
    accessToStorage = true,--If you have enabled you can access to storage in stables
    accessOnlyById = true,--If you have enabled player can see your storage only if you add him via ID (if you have disabled you have access to all players storage)
    disableGreenColor = true, -- If you have enabled, you can disable green color(default color) for carts

    ["whereTheyAreKept"] = {
        enabled = true, -- If you enable this, if you save carts to stables in Valentine, you can see only in Valentine not in another stables
        transferPrice = 150, -- Price for transfer carts between stables  (0 is disabled)
    },

}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Logic centered on carts
*/

Config.CartLogic = {
    renameItem = "CartTag", -- Item for rename cart
    fleeWagon = true,
    debugWagon = false,
    buildCartIcons = true,

    ["statusSetup"] = {
        saveHealth = true, -- Save cart health every 15 second
        affectDirty = true, -- Clean / under 600Hp more dirty and every 100 -> more and more dirty
        affectDamage = true, -- This affect damage on cart to your vehicle
        affectRiding = true, -- Under 100 HP -> undriveble cart you are kicked from cart with notify "Your cart is much broken"
        
        destroyWheelChance = 30, -- 30% every 10 second for destroy wheel (0 is disabled)

        repairWheelNeedItem = true, -- If you have enabled, you need repair kit for repair wheel
        repairWheelItem = "Repair_Kit", -- For fix item for wheel health 
        repairWheelRemove = true, -- Remove repair kit after use

        repairCartItem = "Repair_Kit", -- For fix item for cart health
        repairCartRemove = true, -- Remove repair kit after use
    },
    
    ["componentPrices"] = {
        extras = 0.1,
        tint = 0.5,
        livery = 0.5,
        lantern = 0.5,
        propset = 2.5,
        horses = 2.5,
    },
    
    ["woodCart"] = {
        -- Item = {"Item name", "Weight"}
        Wood = {"Wood", 1.0},
        Wood_Branch = {"Wood Branch", 0.1},
        Wood_Bark = {"Wood bark", 0.5},
        Wood_Chord = {"Wood Chord", 0.5},
        Wood_Branch = {"Wood Branch", 0.5},
        Wood_Plank = {"Wood Plank", 0.5},
    },

    ["stoneCart"] = {
        Stone = {"Stone", 1.0},
        Charcoal = {"Charcoal stone", 0.5},
    },
}

/* 
Keyes setting 
*/
Config.KeySetting = {
    ["horseComponents"] = 0x8CF90A9D,
    ["horseFlee"] = 0x3B24C470,
    ["horseLead"] = 0x018C47CF,
    ["horseCalm"] = 0x760A9C6F,
    ["horseBags"] = 0x71F89BBC,
    ["horseTransfer"] = 0xD8CF0C95,
    ["horseCheckHoof"] = 0x811F4A1A,
    ["horseWhistle"] = 0x24978A28,
    ["horsePutPelt"] = 0x27D1C284,
    ["horseTakePelt"] = 0xA1ABB953,

    ["cartWhistle"] = 0xF3830D8E,
    ["cartTransfer"] = 0xA1ABB953,
    ["cartFixWheel"] = 0x07B8BEAF,
    ["cartFlee"] = 0x0522B243,
    ["cartDebug"] = 0x156F7119,
    ["openStorage"] = 0x27D1C284,
    ["openAnimals"] = 0x8CF90A9D,
    ["putAnimalOnCart"] = 0x27D1C284,
    ["saveWildHorse"] = 0x27D1C284,
    ["saveToSpotOrStables"] = 0x27D1C284,
    
    ["cameraRotate"] = 0x53296B75,
    ["cameraZoom"] = 0xCEE12B50,
    ["cameraRotatePed"] = 0x877F1027,

    ["openStable"] = 0x018C47CF,
    ["openSpot"] = 0x018C47CF,
    ["openPlayerStore"] = 0x018C47CF,

    ["openBuild"] = 0x27D1C284,

    -- cover on horse
    ["jumpToCover"] = 0x8AAA0AD4,--Player must hodl this key and combine with left/right
    ["jumpToLeft"] = 0x7065027D, -- This [A]
    ["jumpToRight"] = 0x4D8FB4C1, -- or this [D]

    ["sellBlackmarket"] = 0x71F89BBC,
}
