function tables()
    -- Fight Enemy
    approach = {["Guard1"] = 2,["Guard2"] = 12,["Guard3"] = 22,["Guard4"] = 47,["King"] = 70}
    attack = {["Guard1"] = 10,["Guard2"] = 15,["Guard3"] = 20,["Guard4"] = 20,["King"] = 15}
    stats = {["Guard1"] = 3,["Guard2"] = 13,["Guard3"] = 23,["Guard4"] = 48,["King"] = 71}
    text_2 = {["Guard1"] = 4,["Guard2"] = 14,["Guard3"] = 24,["Guard4"] = 49,["King"] = 72}
    text_2_options = {["Guard1"] = math.random(5,6),["Guard2"] = math.random(15,16),["Guard3"] = math.random(25,26),["Guard4"] = {50,51},["King"] = {73,74,75,76,77,78}}
    text_3 = {["Guard1"] = 7,["Guard2"] = 17,["Guard3"] = 27,["Guard4"] = 52,["King"] = 79}
    text_3_options = {["Guard1"] = math.random(8,9),["Guard2"] = math.random(18,19),["Guard3"] = math.random(28,29),["Guard4"] = {53,54},["King"] = 80}
    spare = {["Guard1"] = 10,["Guard2"] = 20,["Guard3"] = 30,["Guard4"] = 55}
    spare_text = {["Guard1"] = 3,["Guard2"] = 2,["Guard3"]=3}
end
king_pos = {vmath.vector3(16882,1641,1),vmath.vector3(17242,1641,1),vmath.vector3(17602,1641,1),vmath.vector3(17962,1641,1)}
king_direction = {[3] = "Spin",[4] = "Spin"}
king_fire_direction = {"Circle","Circle","Spin","Spin"}
text_2_check = {["Guard4"] = false}
text_3_check = {["Guard4"] = false}
spare_order = {["Guard4"] = {2,3},["King"] = {2,2,2,2}}

-- Fight Spawner
spawner_pos = {vmath.vector3(971.43,467.879,1),vmath.vector3(2771.85,467.85,1),vmath.vector3(5616,1440,1),vmath.vector3(12954,1497,1)}
enemy_num = {"Guard1","Guard2","Guard3","Guard4"}

-- Projectiles
move_direction = {["Guard1"] = "Left-Right",["Guard2"] = "Up-Down",["Guard4"] = "Spin"}
min_direction = {["Guard1"] = vmath.vector3(612,467.879,1),["Guard2"] = vmath.vector3(2771.85,754.85,1)}
max_direction = {["Guard1"] = vmath.vector3(1331,467.879,1),["Guard2"] = vmath.vector3(2771.85,178.85,1)}
fire_direction = {["Guard1"] = "Up",["Guard2"] = "Left",["Guard3"]="Circle",["Guard4"] = "Spiral"}

--Camera
camera_pos = {["Guard1"] = vmath.vector3(972,610,1),["Guard2"] = vmath.vector3(2530,390,1),["Guard3"] = vmath.vector3(5616,1360,1),["Guard4"] = vmath.vector3(12954,1300,1),["King"] = vmath.vector3(17451,1641,1)}
can_flee = {["Guard1"] = false,["Guard2"] = false,["Guard3"] = false,["Guard4"] = false,["King"] = false}
original_pos = {["Guard1"] = vmath.vector3(971,905,1),["Guard2"] = vmath.vector3(2338.55,484.5,1),["Guard3"]=vmath.vector3(5190.55,1440.5,1),["Guard4"] = vmath.vector3(11804,1353,1)}
camera_zoom = {["Guard1"] = 0.7,["Guard2"] = 0.6,["Guard3"] = 0.6,["Guard4"] = 0.3,["King"] = 0.4}

--Misc
collisions = {["Guard1"] = "/Guard1",["Guard2"] = "/Guard2",["Guard3"] = "/Guard3",["Guard4"] = "/Guard4"}
locks = {["Red Keycard"] = "/redlock",["Blue Keycard"] = "/bluelock",["Green Keycard"] = "/greenlock"}
--Items
item_type = {["shield"] = "Defense",["heal_potion"] = "Heal",["BlueKeycard"] = "Keycard",["RedKeycard"] = "Keycard",["blue_heal"] = "Heal"}
item_collision = {["shield"] = "/shield",["heal_potion"] = "/heal_potion",["BlueKeycard"] = "/BlueKeycard",["RedKeycard"] = "/RedKeycard",["GreenKeycard"] = "/GreenKeycard",["blue_heal"]= "/blue_heal"}
item_name = {["shield"] = "Shield",["heal_potion"] = "Health Potion",["BlueKeycard"] = "Blue Keycard",["RedKeycard"] = "Red Keycard",["GreenKeycard"] = "Green Keycard",["blue_heal"] = "Blue Heal Potion"}
item_stats = {["shield"] = 10,["heal_potion"] = 10,["blue_heal"] = 30}
item_text = {["shield"] = 35,["heal_potion"] = 38,["blue_heal"] = 96}
item_pickup = {["shield"] = 34,["heal_potion"] = 37,["BlueKeycard"] = 40,["RedKeycard"] = 43,["GreenKeycard"] = 45,["blue_heal"] = 95}
item_enabled = {["shield"] = true,["heal_potion"] = true,["BlueKeycard"] = false,["RedKeycard"] = false,["GreenKeycard"] = false,["blue_heal"] = true}
finish_item = {["Guard1"] = "BlueKeycard",["Guard2"] = "RedKeycard",["Guard3"] = "GreenKeycard",}