------------------------- Setting models for a given animal. You can also add your own animals.-------------------------
Config.MaleModel = {
    cow = "a_c_bull_01",
    chicken = "a_c_rooster_01",
    horse = "a_c_horse_breton_steelgrey",
    pig = "a_c_pig_01",
    goat = "a_c_goat_01",
    sheep = "mp_a_c_bighornram_01"
}

Config.FemaleModel = {
    cow = "a_c_cow",
    chicken = "a_c_chicken_01",
    horse = "a_c_horse_breton_redroan",
    pig = "a_c_pig_01",
    goat = "a_c_goat_01",
    sheep = "a_c_sheep_01"
}
---------------------------------------------------------------------------------------------------------------------------

Config.animalSetup = {
    cow = {--Setting the key to the model, database column, etc.
        label = "Cow",--Basic animal name.
        isSmall = false,--Whether it is small or large.

        chanceOnTrash = 1,--1% Chance of creating a trash item.

        sleepTimeChance = 2,--2% Chance that the animal will sleep.
        sleepTime = 5,--How long the animal will sleep. (It's based on ticks, so it's Config.updateTime * 5).
        sleepAnimation = {"amb_creature_mammal@world_cow_resting@base","base",-1,1},--Animation for sleeping.
        eatScenario = "WORLD_ANIMAL_COW_GRAZING",--Scenario for eating.
        drinkScenario = "WORLD_ANIMAL_COW_DRINK_TROUGH",--Scenario for drinking.
        expModifier = 1,--How much experience will be gained while exp.

        buyPrice = 50,--How much will the purchase of an animal cost.
        maxBuyCount = 2,--How many can you buy at most.
        maxBreedCount = 20,--How many animals of this type you can have at most.
        animalStyles = 4,--How many appearance styles the script should generate when purchasing an animal.
        manualSellPrice = 50,--How much will the sale of an animal from the menu cost. (Exp calculate too)
        autoSellPrice = 50,--How much will the automatic sale of an animal cost if you have a full ranch and a baby animal is born.

        breedState = 2,--2% Percentage chance of breeding.
        breedChance = 25,--25% chance of finding a mate of the opposite gender for breeding.
        breedTime = 60,--How long does the breeding process last.
  
        maxProduct = 50,--How many products can the animal store at most.
        countProduct = 2,--How much product was calculated for 100% satisfaction
        ageForProduct = 5,--From which year products are generated.
        productFemale = "Milk",--What is the item ID for products.
        productMale = nil,--What is the item ID for products.
        productFor100 = 0.5,--Modifier for calculating products if the animal is at maximum satisfaction.
        takeProduct = 20,--At what minimum number of products on the animal can they be taken.

        happiesUpAfterWalk = 0.15,--How much satisfaction increases when leading animals.
        expUpAfterWalk = 0.05,--How many experience points are gained when leading animals. (every 200ms)
        underHungerThirst = 50,--At what percentage of food and drink does the satisfaction decrease faster.
        healthDownUnderHappy = 30,--At what percentage of satisfaction does the animal's health start to decrease.

        ageMax = 20,--What is the maximum age of the animal.
        deadOnOld = 2,--Chance of the animal's death every Config.updateTime.
 
        blockTroughForSmall = 5,--From what age can the young animals eat from the troughs.
        blockEatForSmall = 3,--Until 3 years old, the animal is fed by its mother.
        drainForSmall = 20,--ow much food is consumed if the animal is small. (For adults was drain like 0.50/10)

        troughPrice = 100,--The price of troughs in the menu.
        maxTroughCapacity = 200,--The maximum capacity of the troughs.
        eatFromTrough = 40,--At what percentage of hunger and thirst do animals eat or drink from the troughs.
        bucketTrough= 20,--How much drink does the trough receive when filled with a bucket.
        minSellAge = 3,--From what age can animals be sold.

        troughDataFood = {
            -- [ID] = {Number of items, food for the trough, Item name}
            ["cattle_feed"] =  {5, 20, "Ração para Gado", "cloth_bag", 5},
            ["cattle_feed_vet"] = {3, 30, "Ração Veterinária para Gado", "cloth_bag", 3},    --- cattle_feed
        },
        troughDataDrink = {
            -- [ID] = {Number of items, drink for the trough, Item name, GiveBackItem}
            ["Clean_Water_Bottle"] = {3, 30, "Balde de Água Purificada", "Empty_Water_Bucket", 3},
            ["Water_Bucket"] = {5, 20, "Balde com Água", "Empty_Water_Bucket", 5}, 
        },

        hungerDrain = {0.50, 1.50},--How much food is consumed every updateTime.
        foodData = {--Animal takes from hand
            -- [ID] = {Number of items, food, Item name}
            ["hay_cube"] = {4, 20, "Cubo de Feno"},
        },

        thirstDrain = {0.50, 1.50},--Thirst drain from 0.50 to 1.50 (random)
        waterData = {--Animal takes from hand
            -- [ID] = {Number of items, drink, Item name, GiveBackItem}
            ["Clean_Water_Bottle"] = {1, 30, "Balde de Água Purificada", "Empty_Water_Bucket", 3},
            ["Water_Bucket"] = {1, 10, "Balde com Água", "Empty_Water_Bucket", 1}, 
        },

        healthDrain = {0.0005, 0.0015},--Health drain from 0.0005 to 0.0015 (random)
        healthData = {
            -- [ID] = {Number of items, health, Item name, GiveBackItem}
            ["Health_For_Dog"] = {1, 100, "Medicina para Gado"},
        },

        satisfactionDrain = {0.005, 0.010},--How quickly does animal satisfaction decrease every updateTime.

        minigameAnim = {
            --Animation for mini-games and collecting products.
            [1] = {"mini_games@story@mar5@milk_cow","milk_left_start",1800,25},
            [2] = {"mini_games@story@mar5@milk_cow","milk_right_start",1800,25},
        }
    }, 
    chicken = {
        label = "Kuře",
        isSmall = true,
        
        chanceOnTrash = 1,

        sleepAnimation = {"amb_creatures_bird@world_chicken_resting@base","base",-1,1},
        eatScenario = "WORLD_ANIMAL_CHICKEN_EATING",
        drinkScenario = "WORLD_ANIMAL_CHICKEN_EATING_SITTING",
        expModifier = 2.0,

        sleepTimeChance = 2,
        sleepTime = 5,
  
        buyPrice = 50,
        maxBuyCount = 4,
        maxBreedCount = 8,
        animalStyles = 4,
        manualSellPrice = 50,
        autoSellPrice = 50,
   
        breedState = 2,
        breedChance = 25,
        breedTime = 60,
  
        maxProduct = 50,
        countProduct = 2,
        ageForProduct = 5,
        productFemale = "Egg",
        productMale = nil,
        productFor100 = 0.5,
        takeProduct = 20,

        happiesUpAfterWalk = 0.15,
        expUpAfterWalk = 0.05,
        underHungerThirst = 50,
        healthDownUnderHappy = 30,

        ageMax = 20,
        deadOnOld = 2,

        blockTroughForSmall = 5,
        blockEatForSmall = 3,
        drainForSmall = 20,


        troughPrice = 100,
        maxTroughCapacity = 200,
        eatFromTrough = 40,
        bucketTrough= 20,
        minSellAge = 3,--Min age for sell animal

        troughDataFood = {
            ["Grain"] = {40, 40, "Grain"},
        },
        troughDataDrink = {
            ["Clean_Water_Bottle"] = {10, 20, "Water in bottle"},
        },

        hungerDrain = {0.50, 1.50},
        foodData = {
            ["Grain"] = {4, 40, "Grain"},
        },
        
        thirstDrain = {0.50, 1.50},
        waterData = {
            ["Clean_Water_Bottle"] = {1, 40, "Water in bottle"},
        },
        
        healthDrain = {0.010, 0.050},
        healthData = {
            ["Health_For_Dog"] = {1, 100, "Health injections"},
        },

        satisfactionDrain = {0.005, 0.010},

        minigameAnim = {
            [1] = {"mech_pickup@gator_eggs","base_five",3000,25},
        }
    },
    sheep = {
        label = "Ovce",
        isSmall = true,

        chanceOnTrash = 1,

        sleepTimeChance = 2,
        sleepTime = 5,

        sleepAnimation = {"amb_creature_mammal@world_sheep_resting@base","base",-1,1},
        eatScenario = "WORLD_ANIMAL_SHEEP_EATING_GROUND",
        drinkScenario = "WORLD_ANIMAL_SHEEP_DRINKING",
        expModifier = 1.3,

        buyPrice = 50,
        maxBuyCount = 4,
        maxBreedCount = 8,
        animalStyles = 4,
        manualSellPrice = 50,
        autoSellPrice = 50,

        breedState = 2,
        breedChance = 25,
        breedTime = 60,
  
        maxProduct = 50,
        countProduct = 2,
        ageForProduct = 5,
        productFemale = "Wool",
        productMale = "Leather",
        productFor100 = 0.5,
        takeProduct = 20,

        happiesUpAfterWalk = 0.15,
        expUpAfterWalk = 0.05,
        underHungerThirst = 50,
        healthDownUnderHappy = 30,

        ageMax = 20,
        deadOnOld = 2,

        blockTroughForSmall = 5,
        blockEatForSmall = 3,
        drainForSmall = 20,

        troughPrice = 100,
        maxTroughCapacity = 200,
        eatFromTrough = 40,
        bucketTrough= 20,
        minSellAge = 3,--Min age for sell animal

        troughDataFood = {
            ["Corn"] = {40, 40, "Corn"},
        },
        troughDataDrink = {
            ["Clean_Water_Bottle"] = {10, 20, "Water in bottle"},
        },

        hungerDrain = {0.50, 1.50},
        foodData = {
            ["Corn"] = {4, 40, "Corn"},
        },
        
        thirstDrain = {0.50, 1.50},
        waterData = {
            ["Clean_Water_Bottle"] = {1, 40, "Water in bottle"},
        },
        
        healthDrain = {0.010, 0.050},
        healthData = {
            ["Health_For_Dog"] = {1, 100, "Health injections"},
        },

        satisfactionDrain = {0.005, 0.010},


        minigameAnim = {
            [1] = {"script_common@barber_shop@hair_cut","back_right_barber",3000,25},
        }
    },
    goat = {
        label = "Koza",
        isSmall = true,

        sleepTimeChance = 2,
        sleepTime = 5,

        chanceOnTrash = 1,

        sleepAnimation = {"amb_creature_mammal@world_goat_resting@base","base",-1,1},
        eatScenario = "WORLD_ANIMAL_GOAT_GRAZING",
        drinkScenario = "WORLD_ANIMAL_GOAT_DRINK_GROUND",
        expModifier = 1.3,

        buyPrice = 50,
        maxBuyCount = 4,
        maxBreedCount = 8,
        animalStyles = 4,
        manualSellPrice = 50,
        autoSellPrice = 50,

        breedState = 2,
        breedChance = 25,
        breedTime = 60,
  
        maxProduct = 50,
        countProduct = 2,
        ageForProduct = 5,
        productFemale = "Goat_Milk",
        productMale = "Leather",
        productFor100 = 0.5,
        takeProduct = 20,

        happiesUpAfterWalk = 0.15,
        expUpAfterWalk = 0.05,
        underHungerThirst = 50,
        healthDownUnderHappy = 30,

        ageMax = 20,
        deadOnOld = 2,

        blockTroughForSmall = 5,
        blockEatForSmall = 3,
        drainForSmall = 20,

        troughPrice = 100,
        maxTroughCapacity = 200,
        eatFromTrough = 40,
        bucketTrough= 20,
        minSellAge = 3,--Min age for sell animal

        troughDataFood = {
            ["Apple"] = {40, 40, "Apples"},
        },
        troughDataDrink = {
            ["Clean_Water_Bottle"] = {10, 20, "Water with bottle"},
        },

        hungerDrain = {0.50, 1.50},
        foodData = {
            ["Apple"] = {4, 40, "Apples"},
        },
        
        thirstDrain = {0.50, 1.50},
        waterData = {
            ["Clean_Water_Bottle"] = {1, 20, "Water with bottle"},
        },
        
        healthDrain = {0.010, 0.050},
        healthData = {
            ["Health_For_Dog"] = {1, 100, "Heath Injection"},
        },

        satisfactionDrain = {0.005, 0.010},


        minigameAnim = {
            [1] = {"mini_games@story@mar5@milk_cow","milk_left_start",1800,25},
            [2] = {"mini_games@story@mar5@milk_cow","milk_right_start",1800,25},
        }
    },
    
    horse = {
        label = "Kůň",
        isSmall = false,

        sleepTimeChance = 2,
        sleepTime = 5,

        chanceOnTrash = 1,

        sleepAnimation = {"amb_creature_mammal@world_horse_resting@base","base",-1,1},
        eatScenario = "WORLD_ANIMAL_HORSE_GRAZING",
        drinkScenario = "WORLD_ANIMAL_HORSE_DRINK_GROUND",
        expModifier = 1.0,

        buyPrice = 50,
        maxBuyCount = 4,
        maxBreedCount = 8,
        animalStyles = 4,
        manualSellPrice = 50,
        autoSellPrice = 50,

        breedState = 2,
        breedChance = 25,
        breedTime = 60,
  
        maxProduct = 50,
        countProduct = 2,
        ageForProduct = 5,
        productFemale = "Leather",
        productMale = "Leather",
        productFor100 = 0.5,
        takeProduct = 20,

        happiesUpAfterWalk = 0.15,
        expUpAfterWalk = 0.05,
        underHungerThirst = 50,
        healthDownUnderHappy = 30,

        ageMax = 20,
        deadOnOld = 2,

        blockTroughForSmall = 5,
        blockEatForSmall = 3,
        drainForSmall = 20,

        troughPrice = 100,
        maxTroughCapacity = 200,
        eatFromTrough = 40,
        bucketTrough= 20,
        minSellAge = 3,--Min age for sell animal

        troughDataFood = {
            ["Wild_Carrot"] = {40, 40, "Wild Carrot"},
        },
        troughDataDrink = {
            ["Clean_Water_Bottle"] = {10, 20, "Water in bottle"},
        },

        hungerDrain = {0.50, 1.50},
        foodData = {
            ["Wild_Carrot"] = {4, 40, "Wild Cartos"},
        },
        
        thirstDrain = {0.50, 1.50},
        waterData = {
            ["Clean_Water_Bottle"] = {1, 20, "Water in bottle"},
        },
        
        healthDrain = {0.010, 0.050},
        healthData = {
            ["Health_For_Dog"] = {1, 100, "Health injections"},
        },

        satisfactionDrain = {0.005, 0.010},

        minigameAnim = {
            [1] = {"script_common@barber_shop@hair_cut","back_right_barber",3000,25},
        }
    },
    pig = {
        label = "Prase",
        isSmall = true,

        sleepTimeChance = 2,
        sleepTime = 5,

        chanceOnTrash = 1,

        sleepAnimation = {"amb_creature_mammal@world_pig_resting@base","base",-1,1},
        eatScenario = "WORLD_ANIMAL_PIG_EAT_TROUGH",
        drinkScenario = "WORLD_ANIMAL_PIG_DRINK_TROUGH",
        expModifier = 1.5,

        buyPrice = 50,
        maxBuyCount = 4,
        maxBreedCount = 8,
        animalStyles = 4,
        manualSellPrice = 50,
        autoSellPrice = 50,

        breedState = 2,
        breedChance = 25,
        breedTime = 60,
  
        maxProduct = 50,
        countProduct = 2,
        ageForProduct = 5,
        productFemale = "Pork_Meat",
        productMale = "Leather",
        productFor100 = 0.5,
        takeProduct = 20,

        happiesUpAfterWalk = 0.15,
        expUpAfterWalk = 0.05,
        underHungerThirst = 50,
        healthDownUnderHappy = 30,

        ageMax = 20,
        deadOnOld = 2,

        blockTroughForSmall = 5,
        blockEatForSmall = 3,
        drainForSmall = 20,

        troughPrice = 100,
        maxTroughCapacity = 200,
        eatFromTrough = 40,
        bucketTrough= 20,
        minSellAge = 3,--Min age for sell animal

        troughDataFood = {
            ["Potato"] = {40, 40, "Potatoes"},
        },
        troughDataDrink = {
            ["Clean_Water_Bottle"] = {10, 20, "Water in bottle"},
        },

        hungerDrain = {0.50, 1.50},
        foodData = {
            ["Potato"] = {4, 40, "Potatoes"},
        },
        
        thirstDrain = {0.50, 1.50},
        waterData = {
            ["Clean_Water_Bottle"] = {1, 40, "Water in bottle"},
        },
        
        healthDrain = {0.010, 0.050},
        healthData = {
            ["Health_For_Dog"] = {1, 100, "Health injection"},
        },

        satisfactionDrain = {0.005, 0.010},

        minigameAnim = {
            [1] = {"amb_camp@prop_camp_butcher@working@deer@female_a@leg_slice@base","legslice_trans_meatchop",6000,25},
        }
    },
}

