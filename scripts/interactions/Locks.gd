extends Node

var locks = 0

func lockCollision(area: Area2D, entered: bool, color: String) -> void:
	if entered:
		Values.selectedLock = color
	else:
		Values.selectedLock = null

func _input(event: InputEvent) -> void:
	if event.is_action("ui_select") && event.is_pressed() && Values.selectedLock && !Dialogic.has_current_dialog_node():
		if InvFunctions.inventory.has(Values.selectedLock+" Keycard"):
			locks += 1
			get_node(Values.selectedLock).play("unlocked")
			var slot = InvFunctions.inventory.find(Values.selectedLock+" Keycard")
			InvFunctions.removeItem(slot)
			GeneralFunc.playSound("lockEnter")
			if locks == 3:
				breakWall()

func breakWall():
	Values.fightState = "cutscene"
	get_node("/root/Level1/Player/Player").global_position = Vector2(4870, 310)
	
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/Level1/Cell/CellWall").queue_free()
	get_node("/root/Level1/Player/Player/ScreenShake").start(.5, 50, 50, 0)
	GeneralFunc.playSound("wallFall")
	
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/Level1/Player/Player").position = Vector2(0, 0)
	Values.fightState = "attack"
