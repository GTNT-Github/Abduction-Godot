extends Control

var flickerLoop
onready var cameras = get_node("/root/MainGame/Cameras")



func _ready() -> void:
	self.visible = false


#Starts the fight
func startFight(area: Area2D, enemy: String) -> void:
	
	#Check a fight is not already in progress
	if !Values.currentEnemy:
		self.visible = true
		Values.currentEnemy = enemy
		Values.fightState = "menu"
		$"Top/Armor".text = "Armor:\n"+InvFunctions.armor
		$"Top/Weapon".text = "Weapon:\n"+InvFunctions.weapon
		for n in InvFunctions.inventory.size():
			get_node(str("Left/Text/Slot",n+1)).text = InvFunctions.inventory[n]
		for n in Values.actValues[Values.currentEnemy].size():
			get_node(str("Right/Text/Act",n+3)).text = Values.actValues[Values.currentEnemy][n]
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
#			GeneralFunc.playSound("fightStart")
			if n == 4:
				cameras.fightCamera(Values.currentEnemy)
				playText(Values.currentEnemy+"Approach","approach")
#				GeneralFunc.playMusic("fightSong")
		else:
			$Flicker.visible = true


func _input(event: InputEvent) -> void:
	
	#Check if fight is in progress
	if Values.currentEnemy:
		print(Values.selectedButton)
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
			prints(Values.selectedButton != "Items",InvFunctions.inventory[0] != "-----")
			if Values.selectedButton != "Items" || InvFunctions.inventory[0] != "-----":
				Values.fightState = "text"
				get_node(Values.fightButtons["Act"]).visible = false
				get_node(Values.fightButtons["Items"]).visible = false
				get_node(Values.fightButtons[Values.selectedButton+"Text"]).visible = true
				setButton(str(Values.selectedButton,1),str(Values.selectedButton,1),"text")
		
		#Go back to buttons
		elif event.is_action_pressed("ui_cancel") && Values.fightState == "text":
			setButton(Values.selectedButton,Values.selectedButton,"button")
			get_node(Values.fightButtons["ActText"]).visible = false
			get_node(Values.fightButtons["ItemsText"]).visible = false
			get_node(Values.fightButtons["Act"]).visible = true
			get_node(Values.fightButtons["Items"]).visible = true
			GeneralFunc.playSound("select")
			Values.fightState = "menu"
			var selectedButton = Values.selectedText
			selectedButton[selectedButton.length()-1] = str(1)
			setButton(Values.selectedText,selectedButton,"text")
		
		elif event.is_action_pressed("ui_down") && Values.fightState == "text":
			var selectedText = int(Values.selectedText[Values.selectedText.length()-1])
			if selectedText < 4:
				var selectedButton = Values.selectedText
				selectedButton[selectedButton.length()-1] = str(selectedText+1)
				setButton(Values.selectedText,selectedButton,"text")
		elif event.is_action_pressed("ui_up") && Values.fightState == "text":
			var selectedText = int(Values.selectedText[Values.selectedText.length()-1])
			if selectedText > 1:
				var selectedButton = Values.selectedText
				selectedButton[selectedButton.length()-1] = str(selectedText-1)
				setButton(Values.selectedText,selectedButton,"text")

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
func playText(text,type):
	var dialouge = Dialogic.start(text)
#	dialouge.connect("dialogic_signal",self,"itemAccepted")
	add_child(dialouge)
