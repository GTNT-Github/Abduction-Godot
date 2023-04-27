extends Control

var flickerLoop

func _ready() -> void:
	self.visible = false


#Starts the fight
func startFight(area: Area2D, enemy: String) -> void:
	
	#Check a fight is not already in progress
	if !Values.currentEnemy:
		self.visible = true
		Values.currentEnemy = enemy
		Values.fightState = "menu"
		Dialogic.set_variable("Fight","true")
		
		$Right/Act.visible = true
		$Left/Items.visible = true
		
		
		var areaNode = get_node("/root/MainGame/BattleCollisions/"+enemy)
		areaNode.queue_free()
		
		#Set act and inventory
		$"Top/Armor".text = "Armor:\n"+InvFunctions.armor
		$"Top/Weapon".text = "Weapon:\n"+InvFunctions.weapon
		for n in InvFunctions.inventory.size():
			get_node(str("Left/Text/Slot",n+1)).text = InvFunctions.inventory[n]
		for n in Values.actValues[Values.currentEnemy].size():
			get_node(str("Right/Text/Act",n+2)).text = Values.actValues[Values.currentEnemy][n]
		
		setButton("Act","Items","button")
		flicker()


#Flicker transition at start
func flicker() -> void:
	for n in 5:
		$Timer.start()
		yield($Timer,"timeout")
		if n%2 == 0:
			$Flicker.visible = false
			rect_scale = Values.flickrValues[n]
			GeneralFunc.playSound("fightStart")
			if n == 4:
				get_node("/root/MainGame/Player/Player").global_position = Vector2(648,840)
				get_node("/root/MainGame/Player/Player").zoom =  Values.attackValues[Values.currentEnemy]["Zoom"]
				playText(Values.currentEnemy+"Approach")
				GeneralFunc.playMusic("fightSong")
		else:
			$Flicker.visible = true


func _input(event: InputEvent) -> void:
	
	#Check if fight is in progress
	if Values.currentEnemy:
		
		#Switch to Item button
		if event.is_action_pressed("ui_left") && Values.fightState == "menu" && Values.selectedButton == "Act":
			setButton("Act","Items","button")
			GeneralFunc.playSound("select")
			
		#Switch to act button
		elif event.is_action_pressed("ui_right") && Values.fightState == "menu" && Values.selectedButton == "Items":
			setButton("Items","Act","button")
			GeneralFunc.playSound("select")
			
		#Button Selection
		elif event.is_action_pressed("ui_select") && Values.fightState == "menu":
			GeneralFunc.playSound("select")
			if Values.selectedButton != "Items" || InvFunctions.inventory[0] != "-----":
				Values.fightState = "text"
				Values.selectedMenu = Values.selectedButton
				get_node(Values.fightButtons["Act"]).visible = false
				get_node(Values.fightButtons["Items"]).visible = false
				get_node(Values.fightButtons[Values.selectedButton+"Text"]).visible = true
				setButton(str(Values.selectedButton,1),str(Values.selectedButton,1),"text")
		
		
		#Go back to buttons
		elif event.is_action_pressed("ui_cancel") && Values.fightState == "text":
			resetMenu("false")
		
		#Move selected text down
		elif event.is_action_pressed("ui_down") && Values.fightState == "text":
			var selectedText = int(Values.selectedText[Values.selectedText.length()-1])
			#Check boundaries for acts
			if selectedText < 3 && Values.selectedMenu != "Items":
				var selectedButton = Values.selectedText
				selectedButton[selectedButton.length()-1] = str(selectedText+1)
				setButton(Values.selectedText,selectedButton,"text")

			#Check boundaries for items
			elif selectedText < 5 && Values.selectedMenu != "Act" && get_node(str("Left/Text/Slot",selectedText+1)).text != "-----":
				var selectedButton = Values.selectedText
				selectedButton[selectedButton.length()-1] = str(selectedText+1)
				setButton(Values.selectedText,selectedButton,"text")

		#Move selected text up
		elif event.is_action_pressed("ui_up") && Values.fightState == "text":
			var selectedText = int(Values.selectedText[Values.selectedText.length()-1])
			if selectedText > 1:
				var selectedButton = Values.selectedText
				selectedButton[selectedButton.length()-1] = str(selectedText-1)
				setButton(Values.selectedText,selectedButton,"text")

		#Select Text
		elif event.is_action_pressed("ui_select") && Values.fightState == "text" && !Dialogic.has_current_dialog_node():
			#Select Item
			if Values.selectedMenu == "Items":
				var selectedSlot = int(Values.selectedText[Values.selectedText.length()-1])-1
				var selectedItem = InvFunctions.inventory[selectedSlot]
				useItem(selectedItem,selectedSlot)
			elif Values.selectedMenu == "Act":
				
				print(Values.selectedText)
				var selectedAct = Values.selectedText
				playText(Values.currentEnemy+selectedAct)

#Set camera position if enemy is set
func _process(_delta: float) -> void:
	if Values.currentEnemy:
		get_node("/root/MainGame/Player/Player").global_position = Values.attackValues[Values.currentEnemy]["CameraPosition"]


#Set selected button/text
func setButton(selectedButton, newButton,mode):
	if mode == "button":
		get_node(Values.fightButtons[selectedButton]).modulate = Color(1,1,1,0.5)
		get_node(Values.fightButtons[newButton]).modulate = Color(1,1,1,1)
		Values.selectedButton = newButton
	elif mode == "text":
		get_node(Values.fightButtons[selectedButton]).modulate = Color(1,1,1,1)
		get_node(Values.fightButtons[newButton]).modulate = Color(1,1,1,0.5)
		Values.selectedText = newButton

#Play Text
func playText(text) -> Object:
	$"Left/Text".visible = false
	$"Right/Text".visible = false
	
	var dialouge = Dialogic.start(text)
	dialouge.connect("dialogic_signal",get_node("/root/MainGame/Enemy"),"attack")
	add_child(dialouge)
	return dialouge

#Use an item
func useItem(item:String,slot:int):
	if Values.itemTypes[item] == "Armor":
		playText(item+"Use")
		InvFunctions.setArmor(slot)
		resetInv(slot)
	elif Values.itemTypes[item] == "Keycard":
		playText(item+"Use")
	elif Values.itemTypes[item] == "Health":
		playText(item+"Use")
		Values.HP += Values.itemStats[item]
		Values.HP = 100 if Values.HP > 100 else Values.HP
		InvFunctions.inventory[slot] = "-----"
		InvFunctions.resetInventory()
		resetInv(slot)
		
#Reset inventory slots
func resetInv(slot):
	$"Top/Armor".text = "Armor:\n"+InvFunctions.armor
	$"Top/Weapon".text = "Weapon:\n"+InvFunctions.weapon
	for n in InvFunctions.inventory.size():
		get_node(str("Left/Text/Slot",n+1)).text = InvFunctions.inventory[n]
		get_node(str("Left/Text/Slot",n+1)).add_color_override("font_color",Color(1,1,1))
	setButton(str("Items",slot+1),"Items1","text")
	$Top/HPBack/HPBar.rect_scale = Vector2(Values.HP/100.0,1)
	$Top/HPBack/HP.text = str(Values.HP,"/100")

#Reset Menu screen
func resetMenu(spare):
	if spare == "false":
		setButton(Values.selectedButton,Values.selectedButton,"button")
		get_node(Values.fightButtons["ActText"]).visible = false
		get_node(Values.fightButtons["ItemsText"]).visible = false
		get_node(Values.fightButtons["Act"]).visible = true
		get_node(Values.fightButtons["Items"]).visible = true
		GeneralFunc.playSound("select")
		Values.fightState = "menu"
		Values.selectedMenu = "Menu"
		var selectedButton = Values.selectedText
		selectedButton[selectedButton.length()-1] = str(1)
		setButton(Values.selectedText,selectedButton,"text")
	else:
		var spareText = playText(Values.currentEnemy+"Befriend")
		yield(spareText,"dialogic_signal")

#Close Fight UI
func closeUI():
		$Tween.interpolate_property(self,"rect_scale",Vector2(1,1),Vector2(1.9,1.9),0.4,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
		var attackValues = Values.attackValues[Values.currentEnemy]
		Values.currentEnemy = null
		Values.fightState = "attack"
		Dialogic.set_variable("Fight","false")
		print(Values.selectedText)
		setButton(Values.selectedText,"Act1","text")
		get_node("/root/MainGame/Player/Player").position = Vector2(-2,-40)
		get_node("/root/MainGame/Player/Player").zoom = Vector2(0.75,0.75)
		GeneralFunc.stopMusic("fightSong")
		yield($Tween,"tween_all_completed")
	
		self.visible = true
		if attackValues["Drops"]:
			get_node("/root/MainGame/Items").showItem(attackValues["Drop"])
