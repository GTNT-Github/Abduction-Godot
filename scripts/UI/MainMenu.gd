extends ColorRect

var storyNode
var Level = 0
var Level1 = preload("res://scenes/Level1.tscn")

var tweenValues = [Vector2(1,1),Vector2(1.05,1.05)]
var tween = Tween.new()

func _ready() -> void:
	storyNode = Dialogic.start("MainMenu")
	storyNode.connect("dialogic_signal",self,"end_dialouge")
	add_child(storyNode)
	
	tween.connect("tween_completed",self,"_on_tween_completed")
	add_child(tween)
	tween.interpolate_property($Start,"rect_scale",tweenValues[0],tweenValues[1],.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.repeat = true
	tween.start()
	
func end_dialouge():
	storyNode.queue_free()
	storyNode = null
	GeneralFunc.playMusic("startTheme")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") && storyNode:
		end_dialouge()
	elif event.is_action_pressed("ui_select") && Level == 0:
		Level+=1
		var level1 = Level1.instance()
		get_node("/root").add_child(level1)
		GeneralFunc.stopMusic("startTheme")

func _on_tween_completed(object, key):
	tweenValues.invert()
	tween.interpolate_property($Start,"rect_scale",tweenValues[0],tweenValues[1],.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
