Config = {}
-- BANCO PRINCIPAL

Config['PacificHeist'] = {
    ['requiredPoliceCount'] = 0, -- Required police count for start heist
    ['nextRob'] = 7200, -- Seconds for next heist
    ['requiredItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names
        'drill',
        'bag',
        'cutter',
        'c4_bomb',
        'thermite_bomb',
        'laptop',
        'hack_usb'
    },
    ['rewardItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names. Also dont forget glass cutting and painting item names.(in bottom)
        {itemName = 'gold', sellPrice = 2000},
        {itemName = 'diamond', sellPrice = 2000},
        {itemName = 'coke_pooch', sellPrice = 2000},
    },
    ['drillReward'] = function()
        local random = math.random(1, 3)
        return Config['PacificHeist']['rewardItems'][random]['itemName'], 5
    end,
    ['trollyMoneyReward'] = 3000, -- This is the amount of money per roll
    ['stackRewards'] = { -- This is stacks rewards. (not trolly) You can just change count(after =).
        gold = 20,
        money = 500000
    },
    ['black_money'] = true, -- If change true, all moneys will convert to black
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-622.70, 328.733, 85.3010),
        peds = {
            {pos = vector3(-622.70, 328.733, 85.2510), heading = 315.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-621.71, 328.410, 85.2510), heading = 23.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-622.89, 329.701, 85.2510), heading = 228.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['finishHeist'] = {
        buyerPos = vector3(-1228.0, -662.41, 39.3575)
    }
}

Config['PacificSetup'] = {
    ['freezeDoorList'] = { -- dont change
        {model = -222270721,  pos = vector3(257.10, 220.30, 106.28), heading = 340.0, lock = true, action = 'plant', scene = {pos = vector3(257.40, 220.20, 106.35), rot = vector3(0.0, 0.0, 336.48), ptfx = vector3(257.39, 221.20, 106.29)}}, -- pacific enter 1
        {model = 746855201,   pos = vector3(262.35, 223.00, 107.05), heading = 250.0, lock = true, action = 'plant', scene = {pos = vector3(261.75, 221.420, 106.35), rot = vector3(0.0, 0.0, 255.48), ptfx = vector3(261.80, 222.470, 106.283)}}, -- pacific enter 2
        {model = 615294389,   pos = vector3(257.572, 227.826, 101.683), lock = true, action = 'hacking', scene = nil}, -- extended enter
        {model = 2774049745, pos = vector3(256.764, 241.272, 101.693), heading = 160.0, lock = true, action = 'vault', scene = {pos = vector3(257.35, 240.312, 102.0), rot = vector3(0.0, 0.0, 340.0)}}, -- extended vault
        {model = 1008631277,  pos = vector3(262.804, 258.266, 101.709), lock = true, action = 'hacking', scene = nil}, -- extended secret
        {model = -1508355822, pos = vector3(252.72, 220.95, 101.68), heading = 160.0,   lock = true, action = 'plant', scene = {pos = vector3(252.95, 220.70, 101.76), rot = vector3(0.0, 0.0, 160.0), ptfx = vector3(252.985, 221.70, 101.72)}}, -- main vault gate 1
        {model = -1508355822, pos = vector3(261.01, 215.01, 101.68), heading = 250.0, lock = true, action = 'plant', scene = {pos = vector3(261.65, 215.60, 101.76), rot = vector3(0.0, 0.0, 252.0), ptfx = vector3(261.68, 216.63, 101.75)}}, -- main vault gate 2
        {model = 961976194,   pos = vector3(253.154, 228.344, 101.683), lock = true, action = 'vault', scene = nil}, -- main vault
    },
    ['cellGates'] = { -- extended vault inside
        {pos = vector3(260.399, 242.955, 101.801), rot = vector3(0.0, 0.0, 250.0), plant = false},
        {pos = vector3(262.399, 248.455, 101.801), rot = vector3(0.0, 0.0, 250.0), plant = false},
        {pos = vector3(264.409, 254.055, 101.801), rot = vector3(0.0, 0.0, 250.0), plant = false},
        {pos = vector3(255.205, 244.726, 101.801), rot = vector3(0.0, 0.0, 70.0), plant = false},
        {pos = vector3(257.205, 250.276, 101.801), rot = vector3(0.0, 0.0, 70.0), plant = false},
        {pos = vector3(259.225, 255.886, 101.801), rot = vector3(0.0, 0.0, 70.0), plant = false},
    },
    ['mainStack'] = {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(264.265, 213.735, 101.531), heading = 250.0},
    ['drills'] = {
        {pos = vector3(258.267, 213.848, 101.883), rotation = vector3(0.0, 0.0, 160.0)},
        {pos = vector3(259.682, 218.327, 101.883), rotation = vector3(0.0, 0.0, 350.0)},
    },
    ['trollys'] = { -- you can add new trolly but dont change first 4 trolly because for this extended vault fixed trollys
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(266.334, 255.849, 101.691), heading = nil},
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(269.230, 254.744, 101.691), heading = nil},
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(268.085, 251.274, 101.723), heading = nil},
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(266.076, 252.015, 101.691), heading = nil},
        
        {model = 'ch_prop_ch_cash_trolly_01b',  pos = vector3(266.351, 215.192, 100.683), heading = 115.0},
        {model = 'ch_prop_gold_trolly_01a',     pos = vector3(265.107, 211.960, 100.683), heading = 35.0},
        {model = 'imp_prop_impexp_coke_trolly', pos = vector3(261.623, 213.510, 100.683), heading = 300.0},
        {model = 'ch_prop_diamond_trolly_01c',  pos = vector3(262.819, 216.429, 100.683), heading = 200.0},
    },
    ['stacks'] = {
        {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(265.812, 241.233, 101.581), heading = 250.0},
        {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(268.112, 247.533, 101.581), heading = 250.0},
        {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(254.062, 258.454, 101.581), heading = 70.0},

        {model = 'h4_prop_h4_gold_stack_01a', pos = vector3(250.019, 247.602, 101.581), heading = 70.0},
        {model = 'h4_prop_h4_gold_stack_01a', pos = vector3(251.988, 252.979, 101.581), heading = 70.0},
    },
    ['glassCutting'] = {
        displayPos = vector3(263.925, 260.656, 100.633),
        displayHeading = 340.0,
        rewardPos = vector3(263.925, 260.656, 101.6721),
        rewardRot = vector3(360.0, 0.0, 70.0),
        rewards = {
            {
                object = {model = 'h4_prop_h4_diamond_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanaguia',
                price = 700000,
            },
            {
                object = {model = 'h4_prop_h4_art_pant_01a', rot = -53.06},
                displayObj = nil,
                item = 'vanpanther',
                price = 700000,
            },
            {
                object = {model = 'h4_prop_h4_necklace_01a', rot = 340.06},
                displayObj = {model = 'h4_prop_h4_neck_disp_01a', rot = vector3(360.0, 0.0, 340.0)},
                item = 'vannecklace',
                price = 700000,
            },
            {
                object = {model = 'h4_prop_h4_t_bottle_02b', rot = 340.06},
                displayObj = nil,
                item = 'vanbottle',
                price = 700000,
            },
            {
                object = {model = 'vw_prop_vw_pogo_gold_01a', rot = 340.06},
                displayObj = nil,
                item = 'vanrapariga',
                price = 700000,
            },
        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintingg', -- u need add item to database
            paintingPrice = '12000', -- price of the reward item for sell
            scenePos = vector3(266.575, 259.565, 101.663), -- animation coords
            sceneRot = vector3(0.0, 0.0, 250.0), -- animation rotation
            object = 'h4_prop_h4_painting_01e', -- object model
            objectPos = vector3(267.025, 259.545, 101.853), -- object spawn coords
            objHeading = 250.0 -- object spawn heading
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '12000',
            scenePos = vector3(261.302, 261.792, 101.663),
            sceneRot = vector3(0.0, 0.0, 70.0),
            object = 'h4_prop_h4_painting_01f', 
            objectPos = vector3(260.842, 261.932, 101.853), 
            objHeading = 70.85
        },
    },
}

--Dont change because those main and required things.
Planting = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'thermal_charge', 'bag_thermal_charge'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

LaptopAnimation = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'hei_prop_hst_laptop',
        'hei_prop_heist_card_hack_02'
    },
    ['animations'] = {
        {'hack_enter', 'hack_enter_bag', 'hack_enter_laptop', 'hack_enter_card'},
        {'hack_loop', 'hack_loop_bag', 'hack_loop_laptop', 'hack_loop_card'},
        {'hack_exit', 'hack_exit_bag', 'hack_exit_laptop', 'hack_exit_card'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

GrabCash = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'enter', 'enter_bag'},
        {'grab', 'grab_bag', 'grab_cash'},
        {'grab_idle', 'grab_idle_bag'},
        {'exit', 'exit_bag'},
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}

TrollyAnimation = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'intro', 'bag_intro'},
        {'grab', 'bag_grab', 'cart_cash_dissapear'},
        {'exit', 'bag_exit'}
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}


HackKeypad = {
    ['animations'] = {
        {'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing'},
        {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
        {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
        {'fail_react', 'fail_react_ch_prop_ch_usb_drive01x', 'fail_react_prop_phone_ing'},
        {'reattempt', 'reattempt_ch_prop_ch_usb_drive01x', 'reattempt_prop_phone_ing'},
    },
    ['scenes'] = {}
}

-- FLEECAS
Config['FleecaMain'] = {
    ['nextFleeca'] = 10800, -- seconds
    requiredPoliceCount = 0,
    requiredItems = {
        'drill', -- Add item to database
        'bag' -- Add item to database
    },
    rewardItems = {
        diamondTrolly = { 
            item = 'diamond', --item code
            count = 1, -- reward count
            sellPrice = 2000, -- for buyer sell price
        },
        goldTrolly = { 
            item = 'gold', 
            count = 1,
            multiGrabCount = 15, -- middle main grab
            sellPrice = 2000,
        },
        cashTrolly = { 
            item = nil, -- cash
            count = 3000,
            multiGrabCount = 250000, -- middle main grab
        },
        lockbox = function()
            local items = {Config['FleecaMain']['rewardItems']['diamondTrolly'], Config['FleecaMain']['rewardItems']['goldTrolly']}
            local random = math.random(1, 2)
            local lockboxBag = { -- random diamond or gold for safety box drill reward
                item = items[random].item,
                count = 5
            }
            return lockboxBag
        end,
    },
    grabReward = function() -- dont change this
        local rewards, random = {'gold', 'cash'}, math.random(1, 2)
        return rewards[random]
    end,
    trollyReward = function() -- dont change this
        local rewards, random = {'gold', 'cash', 'diamond'}, math.random(1, 3)
        return rewards[random]
    end,
    finishHeist = {
        buyerPos = vector3(1291.19, -3143.2, 4.90626)
    }
}

Config['FleecaHeist'] = {
    [1] = {
        scenePed = { model = 'csb_tomcasino', coords = vector3(-2960.8, 483.305, 14.7), heading = 90.25}, -- ped settings
        scenePos = vector3(-2958.695, 478.2697, 14.7), -- start ped pos
        sceneRot = vector3(0.0, 0.0, -92.24812), -- start ped rotation
        scenePedWalkCoords = vector3(-2964.6, 482.968, 15.7068),
        doorHeading = {300.0, 300.0}, -- inside doors rotation
        grab = { -- middle main grab point
            pos = vector3(-2954.2, 484.377, 15.525),
            heading = 270.0,
            loot = false
        },
        drills = { -- drill points
            {coords = vector3(-2952.2, 484.135, 15.9253), rotation = vector3(0.0, 0.0, 265.0), loot = false},
            {coords = vector3(-2954.0, 486.676, 15.9253), rotation = vector3(0.0, 0.0, 355.0), loot = false},
            {coords = vector3(-2954.2, 482.120, 15.9253), rotation = vector3(0.0, 0.0, 185.0), loot = false},
        },
        trollys = { -- trollys points
            {coords = vector3(-2957.3, 485.690, 14.6753), heading = 178.0, loot = false},
            {coords = vector3(-2958.4, 484.099, 14.6753), heading = 268.0, loot = false},
        },
        nextRob = 10800, -- seconds
    },
    [2] = {
        scenePed = { model = 'csb_tomcasino', coords = vector3(-1211.4, -331.84, 36.78), heading = 27.56},
        scenePos = vector3(-1214.835, -336.3697, 36.78),
        sceneRot = vector3(0.0, 0.0, -152.9346),
        scenePedWalkCoords = vector3(-1213.6, -328.57, 37.7907),
        doorHeading = {240.0, 240.0},
        grab = {
            pos = vector3(-1207.6, -337.40, 37.6093),
            heading = 210.0,
            loot = false
        },
        drills = {
            {coords = vector3(-1205.1, -336.54, 37.9593), rotation = vector3(0.0, 0.0, -60.0), loot = false},
            {coords = vector3(-1206.4, -339.10, 37.9593), rotation = vector3(0.0, 0.0, 200.0), loot = false},
            {coords = vector3(-1209.1, -338.87, 37.9593), rotation = vector3(0.0, 0.0, 120.0), loot = false},
        },
        trollys = {
            {coords = vector3(-1207.6, -333.89, 36.7592), heading = 118.0, loot = false},
            {coords = vector3(-1209.4, -333.79, 36.7592), heading = 208.0, loot = false},
        },
        nextRob = 10800,
    },
    [3] = {
        scenePed = { model = 'csb_tomcasino', coords = vector3(-351.34, -51.356, 48.05), heading = 340.04},
        scenePos = vector3(-356.5303, -52.26782, 48.05),
        sceneRot = vector3(0.0, 0.0, -198.9691),
        scenePedWalkCoords = vector3(-350.10, -47.569, 49.0462),
        doorHeading = {200.0, 200.0},
        grab = {
            pos = vector3(-352.23, -58.215, 48.848),
            heading = 160.0,
            loot = false
        },
        drills = {
            {coords = vector3(-354.15, -57.592, 49.3147), rotation = vector3(0.0, 0.0, 75.0), loot = false},
            {coords = vector3(-352.81, -60.155, 49.3147), rotation = vector3(0.0, 0.0, 160.0), loot = false},
            {coords = vector3(-349.70, -59.020, 49.3147), rotation = vector3(0.0, 0.0, 260.0), loot = false},
        },
        trollys = {
            {coords = vector3(-349.86, -55.756, 48.0148), heading = 70.0, loot = false},
            {coords = vector3(-351.02, -54.136, 48.0148), heading = 162.0, loot = false},
        },
        nextRob = 10800,
    },
    [4] = {
        scenePed = { model = 'csb_tomcasino', coords = vector3(313.973, -280.63, 53.16), heading = 340.04},
        scenePos = vector3(308.598, -281.3508, 53.16),
        sceneRot = vector3(0.0, 0.0, -200.1235),
        scenePedWalkCoords = vector3(315.079, -276.63, 54.1744),
        doorHeading = {200.0, 200.0},
        grab = {
            pos = vector3(312.756, -287.41, 54.0),
            heading = 160.0,
            loot = false
        },
        drills = {
            {coords = vector3(310.867, -286.82, 54.4430), rotation = vector3(0.0, 0.0, 75.0), loot = false},
            {coords = vector3(312.411, -289.41, 54.4430), rotation = vector3(0.0, 0.0, 160.0), loot = false},
            {coords = vector3(315.230, -288.20, 54.4430), rotation = vector3(0.0, 0.0, 260.0), loot = false},
        },
        trollys = {
            {coords = vector3(315.230, -284.93, 53.1430), heading = 70.0, loot = false},
            {coords = vector3(314.184, -283.42, 53.1430), heading = 160.0, loot = false},
        },
        nextRob = 10800,
    },
    [5] = {
        scenePed = { model = 'csb_tomcasino', coords = vector3(1174.88, 2708.24, 37.09), heading = 175.0},
        scenePos = vector3(1179.56, 2710.876, 37.09),
        sceneRot = vector3(0.0, 0.0, 0.2100044),
        scenePedWalkCoords = vector3(1175.13, 2704.27, 38.0977),
        doorHeading = {40.0, 40.0},
        grab = {
            pos = vector3(1173.45, 2715.08, 37.9162),
            heading = 360.0,
            loot = false
        },
        drills = {
            {coords = vector3(1173.34, 2717.16, 38.3363), rotation = vector3(0.0, 0.0, 0.0), loot = false},
            {coords = vector3(1175.52, 2715.16, 38.3363), rotation = vector3(0.0, 0.0, 275.0), loot = false},
            {coords = vector3(1170.95, 2715.26, 38.3363), rotation = vector3(0.0, 0.0, 90.0), loot = false},
        },
        trollys = {
            {coords = vector3(1172.02, 2712.01, 37.0662), heading = 270.0, loot = false},
            {coords = vector3(1173.69, 2710.93, 37.0662), heading = 0.0, loot = false},
        },
        nextRob = 10800,
    },
    [6] = {
        scenePed = { model = 'csb_tomcasino', coords = vector3(149.663, -1042.3, 28.37), heading = 345.0},
        scenePos = vector3(144.2593, -1042.969, 28.37),
        sceneRot = vector3(0.0, 0.0, -200.384),
        scenePedWalkCoords = vector3(150.710, -1038.4, 29.3777),
        doorHeading = {200.0, 200.0},
        grab = {
            pos = vector3(148.431, -1049.1, 29.19),
            heading = 160.0,
            loot = false
        },
        drills = {
            {coords = vector3(146.459, -1048.4, 29.6162), rotation = vector3(0.0, 0.0, 70.0), loot = false},
            {coords = vector3(148.095, -1051.1, 29.6162), rotation = vector3(0.0, 0.0, 170.0), loot = false},
            {coords = vector3(150.969, -1049.8, 29.6162), rotation = vector3(0.0, 0.0, 250.0), loot = false},
        },
        trollys = {
            {coords = vector3(151.036, -1046.6, 28.3462), heading = 70.0, loot = false},
            {coords = vector3(149.887, -1045.1, 28.3462), heading = 160.0, loot = false},
        },
        nextRob = 10800,
    }
}


LaserDrill = {
    ['animations'] = {
        {'intro', 'bag_intro', 'intro_drill_bit'},
        {'drill_straight_start', 'bag_drill_straight_start', 'drill_straight_start_drill_bit'},
        {'drill_straight_end_idle', 'bag_drill_straight_idle', 'drill_straight_idle_drill_bit'},
        {'drill_straight_fail', 'bag_drill_straight_fail', 'drill_straight_fail_drill_bit'},
        {'drill_straight_end', 'bag_drill_straight_end', 'drill_straight_end_drill_bit'},
        {'exit', 'bag_exit', 'exit_drill_bit'},
    },
    ['scenes'] = {}
}

Trolly = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'intro', 'bag_intro'},
        {'grab', 'bag_grab', 'cart_cash_dissapear'},
        {'exit', 'bag_exit'}
    },
    ['scenes'] = {}
}


-- RAPTOS
Config['Kidnapping'] = {
    ['nextNapping'] = 900, -- seconds
    ['start'] = { -- start boss ped
        ped = {model = 'a_m_m_soucent_02', pos = vector3(-1383.1, -640.04, 28.6733), heading = 211.53}
    },
    ['randomSpawnCoords'] = { -- kidnapped ped spawn
        {pos = vector3(-833.02, -350.74, 38.6802), heading = 243.42},
        {pos = vector3(-197.90, -864.60, 29.3243), heading = 246.03},
        {pos = vector3(-20.242, -1721.1, 29.2882), heading = 22.81}
    },
    ['query'] = {
        scenePos = vector3(568.450, -3123.8, 18.7686),
        sceneRot = vector3(0.0, 0.0, -90.0),
        laptopScenePos = vector3(565.9, -3123.0, 18.7686),
        laptopSceneRot = vector3(0.0, 0.0, 0.0),
        tripodPos = vector3(570.572, -3123.8, 17.7086),
        cameraPos = vector3(570.572, -3123.755, 19.2986),
        cameraHeading = -90.0
    },
    videoRecordItem = 'videorecord', -- add database item
    pedToKidnapped = 'a_m_m_prolhost_01',
    rewardCash = 25000, -- reward cash to video record
    randomRewardItems = { -- reward random item for sell video record
        'bread',
        'water'
    },
    ['objects_1'] = {
        'prop_cs_wrench'
    },
    ['animations_1'] = {
        {'wrench_idle_player', 'wrench_idle_victim', 'wrench_idle_chair', 'wrench_idle_wrench'},
        {'wrench_attack_left_player', 'wrench_attack_left_victim', 'wrench_attack_left_chair', 'wrench_attack_left_wrench'},
        {'wrench_attack_mid_player', 'wrench_attack_mid_victim', 'wrench_attack_mid_chair', 'wrench_attack_mid_wrench'},
        {'wrench_attack_right_player', 'wrench_attack_right_victim', 'wrench_attack_right_chair', 'wrench_attack_right_wrench'},
    },
    ['objects_2'] = {
        'w_am_jerrycan',
        'p_loose_rag_01_s'
    },
    ['animations_2'] = {
        {'waterboard_idle_player', 'waterboard_idle_victim', 'waterboard_idle_chair', 'waterboard_idle_jerrycan', 'waterboard_idle_rag'},
        {'waterboard_kick_player', 'waterboard_kick_victim', 'waterboard_kick_chair', 'waterboard_kick_jerrycan', 'waterboard_kick_rag'},
        {'waterboard_loop_player', 'waterboard_loop_victim', 'waterboard_loop_chair', 'waterboard_loop_jerrycan', 'waterboard_loop_rag'},
        {'waterboard_outro_player', 'waterboard_outro_victim', 'waterboard_outro_chair', 'waterboard_outro_jerrycan', 'waterboard_outro_rag'}
    },
    ['objects_3'] = {
        'prop_pliers_01'
    },
    ['animations_3'] = {
        {'pull_tooth_intro_player', 'pull_tooth_intro_victim', 'pull_tooth_intro_pliers'},
        {'pull_tooth_idle_player', 'pull_tooth_idle_victim', 'pull_tooth_idle_pliers'},
        {'pull_tooth_loop_player', 'pull_tooth_loop_victim', 'pull_tooth_loop_pliers'},
        {'pull_tooth_outro_b_player', 'pull_tooth_outro_b_victim', 'pull_tooth_outro_b_pliers'},
    }
}

--- ARTE
Config['ArtHeist'] = {
    ['nextRob'] = 1800, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(244.346, 374.012, 105.738),
        peds = {
            {pos = vector3(244.346, 374.012, 105.738), heading = 156.39, ped = 's_m_m_highsec_01'},
            {pos = vector3(243.487, 372.176, 105.738), heading = 265.63, ped = 's_m_m_highsec_02'},
            {pos = vector3(245.074, 372.730, 105.738), heading = 73.3, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['sellPainting'] ={ -- sell painting coords
        pos = vector3(288.558, -2981.1, 5.90696),
        peds = {
            {pos = vector3(288.558, -2981.1, 5.90696), heading = 135.88, ped = 's_m_m_highsec_01'},
            {pos = vector3(287.190, -2980.9, 5.72252), heading = 218.0, ped = 's_m_m_highsec_02'},
            {pos = vector3(287.731, -2982.6, 5.82852), heading = 336.08, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintinge', -- u need add item to database
            paintingPrice = '12000', -- price of the reward item for sell
            scenePos = vector3(1400.486, 1164.55, 113.4136), -- animation coords
            sceneRot = vector3(0.0, 0.0, -90.0), -- animation rotation
            object = 'ch_prop_vault_painting_01e', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(1400.946, 1164.55, 114.5336), -- object spawn coords
            objHeading = 270.0 -- object spawn heading
        },
        {
            rewardItem = 'paintingi',
            paintingPrice = '12000', 
            scenePos = vector3(1408.175, 1144.014, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 180.0),
            object = 'ch_prop_vault_painting_01i', 
            objectPos = vector3(1408.175, 1143.564, 114.5336), 
            objHeading = 180.0
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '12000', 
            scenePos = vector3(1407.637, 1150.74, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01h', 
            objectPos = vector3(1407.637, 1151.17, 114.5336), 
            objHeading = 0.0
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '12000', 
            scenePos = vector3(1408.637, 1150.74, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01j', 
            objectPos = vector3(1408.637, 1151.17, 114.5336), 
            objHeading = 0.0
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '12000', 
            scenePos = vector3(1397.586, 1165.579, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 90.0),
            object = 'ch_prop_vault_painting_01f', 
            objectPos = vector3(1397.136, 1165.579, 114.5336), 
            objHeading = 90.0
        },
        {
            rewardItem = 'paintingg',
            paintingPrice = '12000', 
            scenePos = vector3(1397.976, 1165.679, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01g', 
            objectPos = vector3(1397.936, 1166.079, 114.5336), 
            objHeading = 0.0
        },
    },
    ['objects'] = { -- dont change (required)
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { -- dont change (required)
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
}


-- ATM
Translation = {}

Config.Locale = 'en'
Config.CopsRequiredToSell = 3

Config.InteractionKey = 47
Config.AbortKey = 73

Config.useBlips = true -- should there be Blips for the ATM Locations
Config.showMarker = false -- Should a red marker be displayed
Config.showInfobar = true -- Hint text: Press G to...

Config.useSound = true -- use Alarm sound

Config.RequireLockpickItem = true
Config.LockpickItem = 'lockpick'

-- Animation examples:
-- WORLD_HUMAN_HAMMERING
-- WORLD_HUMAN_WELDING
Config.AnimationStyle = "WORLD_HUMAN_WELDING"

-- Timeout in minutes
Config.Atms   = {
    {x = 146.06, y = -1034.82, z = 29.34, timeout = 10, money = {min = 3600, max = 9000}},
    {x = -303.48263549805, y = -831.02526855469, z = 32.08687210083, timeout = 10, money = {min = 4000, max = 8000}},
    {x = -56.362201690674, y = -1752.3922119141, z = 29.421005249023, timeout = 10, money = {min = 2600, max = 4000}},
    {x = -821.26617431641, y = -1082.509765625, z = 11.132418632507, timeout = 10, money = {min = 3200, max = 7000}},
    {x = -2073.240234375, y = -317.16448974609, z = 13.315970420837, timeout = 10, money = {min = 3600, max = 7000}},
    {x = 1172.6140136719, y = 2701.9362792969, z = 38.174629211426, timeout = 10, money = {min = 3800, max = 8200}},
    {x = -1091.0859375, y = 2708.2854003906, z = 18.970090866089, timeout = 10, money = {min = 3900, max = 7800}},
    {x = 2559.6220703125, y = 351.03356933594, z = 108.6215133667, timeout = 10, money = {min = 4100, max = 7000}},
}

Config.AlarmTime = 15 -- in seconds (how long should the alarm stay activated)
Config.Step3Time = 15 -- How long should it take before the player gets the first money (break the case)

Config.IntervalCount = 6
Config.IntervalTime = 17.5 -- in seconds

Translation = {
    ['en'] = {
        ['blip_text'] = 'Assaltar Multibanco',
        ['infobar_start'] = 'Pressiona ~r~G~w~, para assaltar o multibanco',
        ['recently_robbed'] = 'Este multibanco foi assaltado recentemente!',
        ['step_1'] = 'Começaste a assaltar o multibanco',
        ['step_2'] = 'Remove os cabos do sistema de alarme',
        ['step_3'] = 'O sistema de alarme foi desativado!',
        ['step_4'] = 'O multibanco foi hackeado. Começaste a tirar dinheiro do multibanco',
        ['got_money'] = 'Dinheiro ganho: ',
        ['got_money2'] = '€ O multibanco está vazio. CORRE!',
        ['got_money3'] = '€ Fica para tirares mais dinheiro...',
        ['rob_aborted'] = 'O assalto foi cancelado! Tu ganhaste ',
        ['rob_aborted2'] = '€',
        ['rob_aborted_nothing'] = 'O assalto foi cancelado sem lucro...',
        ['cop_notify'] = 'Alarme Silêncioso em multibanco em',
        ['cop_notify2'] = '. GPS foi marcado!',
        ['cop_atm'] = 'Multibanco Segurança',
        ['cop_heading'] = 'Alarme Silencioso',
        ['rob_aborted_chat'] = 'O assalto foi cancelado!',
        ['rob_abort_title'] = 'Assalto cancelado',
        ['not_enough_cops'] = 'Não há polícia suficientes!',
        ['timeout'] = 'Este multibanco foi assaltado recentemente!',
        ['no_lockpick'] = 'Não tens uma lockpick!',
    }

}


-- COMBOIOS


Config['TrainHeist'] = {
    ['requiredPoliceCount'] = 0, -- required police count for start heist
    ['nextRob'] = 2700, -- seconds for next heist
    ['requiredItems'] = { -- add to database or shared
        'cutter',
        'bag'
    },
    ['reward'] = {
        itemName = 'gold', -- gold item name
        grabCount = 15, -- gold grab count
        sellPrice = 2000 -- buyer sell price
    },
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-687.82, -2417.1, 13.9445),
        peds = {
            {pos = vector3(-686.43, -2417.5, 13.8945), heading = 23.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-687.82, -2417.1, 13.8945), heading = 320.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-688.89, -2416.3, 13.8945), heading = 291.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['guardPeds'] = { -- guard ped list (you can add new)
            { coords = vector3(2850.67, 4535.49, 45.3924), heading = 270.87, model = 's_m_y_blackops_01'},
            { coords = vector3(2856.28, 4544.12, 45.3354), heading = 177.93, model = 's_m_y_blackops_01'},
            { coords = vector3(2869.90, 4530.26, 47.7877), heading = 354.93, model = 's_m_y_blackops_01'},
            { coords = vector3(2859.08, 4519.85, 47.9145), heading = 177.88, model = 's_m_y_blackops_01'},
            { coords = vector3(2843.78, 4521.66, 47.4138), heading = 268.28, model = 's_m_y_blackops_01'},
            { coords = vector3(2856.90, 4526.85, 48.6552), heading = 268.3, model = 's_m_y_blackops_01'},
            { coords = vector3(2878.67, 4556.77, 48.4119), heading = 359.44, model = 's_m_y_blackops_01'},
            { coords = vector3(2886.69, 4556.21, 48.4262), heading = 265.05, model = 's_m_y_blackops_01'},
    },
    ['finishHeist'] = { -- finish heist coords
        buyerPos = vector3(-1690.6, -916.19, 6.78323)
    },
    ['setupTrain'] = { -- train and containers coords
        pos = vector3(2872.028, 4544.253, 47.758),
        part = vector3(2883.305, 4557.646, 47.758),
        heading = 140.0,
        ['containers'] = {
            {
                pos = vector3(2885.97, 4560.83, 48.0551), 
                heading = 320.0, 
                lock = {pos = vector3(2884.76, 4559.38, 49.22561), taken = false},
                table = vector3(2886.55, 4561.53, 48.23),
                golds = {
                    {pos = vector3(2886.05, 4561.93, 49.14), taken = false},
                    {pos = vector3(2887.05, 4561.13, 49.14), taken = false},
                } 
            },
            {
                pos = vector3(2880.97, 4554.83, 48.0551), 
                heading = 140.0, 
                lock = {pos = vector3(2882.15, 4556.26, 49.22561), taken = false},
                table = vector3(2880.45, 4554.23, 48.23),
                golds = {
                    {pos = vector3(2881.05, 4553.93, 49.14), taken = false},
                    {pos = vector3(2880.25, 4554.63, 49.14), taken = false},
                } 
            }
        }
    }
}

--Dont change. Main and required things.
TrainAnimation = {
    ['objects'] = {
        'tr_prop_tr_grinder_01a',
        'ch_p_m_bag_var02_arm_s'
    },
    ['animations'] = {
        {'action', 'action_container', 'action_lock', 'action_angle_grinder', 'action_bag'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

GrabGold = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'enter', 'enter_bag'},
        {'grab', 'grab_bag', 'grab_gold'},
        {'grab_idle', 'grab_idle_bag'},
        {'exit', 'exit_bag'},
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}




--- Joalharia

Config['VangelicoHeist'] = {
    ['requiredPoliceCount'] = 0, -- required police count for start heist 8
    ['nextRob'] = 10800, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-846.42, -1307.5, 5.00017),
        peds = {
            {pos = vector3(-846.73, -1306.4, 5.00018), heading = 174.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-845.40, -1306.7, 5.00018), heading = 131.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-845.61, -1308.2, 5.00018), heading = 79.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['gasMask'] = {
        itemName = 'gasmask', -- item name for gasmask
        clothNumber = 67 -- you can change, this is my choise
    },
    ['requiredItems'] = { -- add item to database
        'cutter',
        'bag'
    },
    ['smashRewards'] = { -- you can add new smash reward items
        {item = 'rolex', price = 2000},
        {item = 'ring', price = 2000},
        {item = 'necklace', price = 2000},
    },
    ['smashWeapons'] = { -- you can add new smash required weapons
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
        'WEAPON_ADVANCEDRIFLE',
        'WEAPON_BULLPUPRIFLE',
    },
    ['finishHeist'] = {
        buyerPos = vector3(832.607, -2954.4, 4.90086)
    }
}

Config['VangelicoInside'] = {
    ['glassCutting'] = {
        displayPos = vector3(-617.4622, -227.4347, 37.057),
        displayHeading = -53.06,
        rewardPos = vector3(-617.4622, -227.4347, 38.0861),
        rewardRot = vector3(360.0, 0.0, 70.0),
        rewards = {
            {
                object = {model = 'h4_prop_h4_diamond_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanaguia',
                price = 700000,
            },
            {
                object = {model = 'h4_prop_h4_art_pant_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanpanther',
                price = 700000,
            },
            {
                object = {model = 'h4_prop_h4_necklace_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_neck_disp_01a', rot = vector3(360.0, 0.0, -60.0)},
                item = 'vannecklace',
                price = 700000,
            },
            {
                object = {model = 'h4_prop_h4_t_bottle_02b', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanbottle',
                price = 700000,
            },
        }
    },
    ['smashScenes'] = {
        {
            objPos = vector3(-627.735, -234.439, 37.875),
            scenePos = vector3(-628.187, -233.538, 37.0946),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-626.716, -233.685, 37.8583),
            scenePos = vector3(-627.136, -232.775, 37.0946),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-627.35, -234.947, 37.8531),
            scenePos = vector3(-626.62, -235.725, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-626.298, -234.193, 37.8492),
            scenePos = vector3(-625.57, -234.962, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-626.399, -239.132, 37.8616),
            scenePos = vector3(-626.894, -238.2, 37.0856),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
        {
            objPos = vector3(-625.376, -238.358, 37.8687),
            scenePos = vector3(-625.867, -237.458, 37.0946),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-625.517, -227.421, 37.86),
            scenePos = vector3(-624.738, -228.2, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-624.467, -226.653, 37.861),
            scenePos = vector3(-623.688, -227.437, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-623.8118, -228.6336, 37.8522),
            scenePos = vector3(-624.293, -227.831, 37.0946),
            sceneRot = vector3(0.0, 0.0, -143.511),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
        {
            objPos = vector3(-624.1267, -230.7476, 37.8618),
            scenePos = vector3(-624.939, -231.247, 37.0946),
            sceneRot = vector3(0.0, 0.0, -54.13),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-621.7181, -228.9636, 37.8425),
            scenePos = vector3(-620.864, -228.481, 37.0946),
            sceneRot = vector3(0.0, 0.0, 126.925),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-622.7541, -232.614, 37.8638),
            scenePos = vector3(-623.3596, -233.2296, 37.0946),
            sceneRot = vector3(0.0, 0.0, -52.984),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-620.3262, -230.829, 37.8578),
            scenePos = vector3(-619.408, -230.1969, 37.0946),
            sceneRot = vector3(0.0, 0.0, 126.352),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-620.6465, -232.9308, 37.8407),
            scenePos = vector3(-620.184, -233.729, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.398),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-619.978, -234.93, 37.8537),
            scenePos = vector3(-620.44, -234.084, 37.0946),
            sceneRot = vector3(0, 0, -144.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-618.937, -234.16, 37.8425),
            scenePos = vector3(-619.39, -233.32, 37.0946),
            sceneRot = vector3(0, 0, -144.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-620.163, -226.212, 37.8266),
            scenePos = vector3(-620.797, -226.79, 37.0946),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-619.384, -227.259, 37.8342),
            scenePos = vector3(-620.055, -227.817, 37.0856),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
        {
            objPos = vector3(-618.019, -229.115, 37.8302),
            scenePos = vector3(-618.679, -229.704, 37.0946),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-617.249, -230.156, 37.8201),
            scenePos = vector3(-617.937, -230.731, 37.0856),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
    },
    ['painting'] = {
        {
            rewardItem = 'paintingg', -- u need add item to database
            paintingPrice = '12000', -- price of the reward item for sell
            scenePos = vector3(-626.70, -228.3, 38.06), -- animation coords
            sceneRot = vector3(0.0, 0.0, 90.0), -- animation rotation
            object = 'ch_prop_vault_painting_01g', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(-627.20, -228.31, 38.06), -- object spawn coords
            objHeading = 94.75 -- object spawn heading
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '12000', 
            scenePos = vector3(-622.97, -225.54, 38.06), 
            sceneRot = vector3(0.0, 0.0, -20.0),
            object = 'ch_prop_vault_painting_01f', 
            objectPos = vector3(-622.80, -225.14, 38.06), 
            objHeading = 345.85
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '12000', 
            scenePos = vector3(-617.48, -233.22, 38.06), 
            sceneRot = vector3(0.0, 0.0, -90.0),
            object = 'ch_prop_vault_painting_01h', 
            objectPos = vector3(-617.00, -233.22, 38.06), 
            objHeading = 269.53
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '12000', 
            scenePos = vector3(-621.25, -235.78, 38.06), 
            sceneRot = vector3(0.0, 0.0, 160.0),
            object = 'ch_prop_vault_painting_01j', 
            objectPos = vector3(-621.25, -236.38, 38.06), 
            objHeading = 161.22
        },
    }
}

Overheat = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'h4_prop_h4_cutter_01a',
    },
    ['animations'] = {
        {'enter', 'enter_bag', 'enter_cutter', 'enter_glass_display'},
        {'idle', 'idle_bag', 'idle_cutter', 'idle_glass_display'},
        {'cutting_loop', 'cutting_loop_bag', 'cutting_loop_cutter', 'cutting_loop_glass_display'},
        {'overheat_react_01', 'overheat_react_01_bag', 'overheat_react_01_cutter', 'overheat_react_01_glass_display'},
        {'success', 'success_bag', 'success_cutter', 'success_glass_display_cut'},
    },
    ['scenes'] = {},
    ['sceneObjects'] = {},
}

ArtHeist = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { 
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}