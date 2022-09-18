extends Control

var flickerLoop
onready var cameras = get_node("/root/MainGame/Cameras")

func _ready() -> void:
	self.visible = false


func startFight(area: Area2D, enemy: String) -> void:
	if !Values.currentEnemy:
		self.visible = true
		Values.currentEnemy = enemy
		Values.fightState = "menu"
		setButton("Act","Items","button")
		flicker()


func flicker() -> void:
	for n in 5:
		$Timer.start()
		yield($Timer,"timeout")
		if n%2 == 0:
			cameras.fightCamera(Values.currentEnemy)
			$Flicker.visible = false
			rect_scale = Values.flickrValues[n]
			GeneralFunc.playSound("fightStart")
#			if n == 4:
#				GeneralFunc.playMusic("fightSong")
		else:
			$Flicker.visible = true
		
func _input(event: InputEvent) -> void:
	if Values.currentEnemy:
		if event.is_action_pressed("ui_left") && Values.fightState == "menu" && Values.selectedButton == "Act":
			setButton("Act","Items","button")
			GeneralFunc.playSound("select")
		elif event.is_action_pressed("ui_right") && Values.fightState == "menu" && Values.selectedButton == "Items":
			setButton("Items","Act","button")
			GeneralFunc.playSound("select")
		elif event.is_action_pressed("ui_select") && Values.fightState == "menu":
			get_node(Values.fightButtons["Act"]).visible = false
			get_node(Values.fightButtons["Items"]).visible = false
			get_node(Values.fightButtons[Values.selectedButton+"Text"]).visible = true
			GeneralFunc.playSound("select")
		elif event.is_action_pressed("ui_cancel") && Values.fightState == "menu":
			setButton(Values.selectedButton,Values.selectedButton,"button")
			get_node(Values.fightButtons["ActText"]).visible = false
			get_node(Values.fightButtons["ItemsText"]).visible = false
			get_node(Values.fightButtons["Act"]).visible = true
			get_node(Values.fightButtons["Items"]).visible = true
			GeneralFunc.playSound("select")
			
func setButton(selectedButton, newButton,mode):
	if mode == "button":
		get_node(Values.fightButtons[selectedButton]).modulate = Color(1,1,1,0.5)
		get_node(Values.fightButtons[newButton]).modulate = Color(1,1,1,1)
		prints(get_node(Values.fightButtons[newButton]).modulate,get_node(Values.fightButtons[selectedButton]).modulate)
		Values.selectedButton = newButton
