extends Node


func _process(delta: float) -> void:
	if !Values.currentEnemy:
		$Player.position = get_node("/root/MainGame/Player").position

func fightCamera(enemy):
	var camera = get_node("/root/MainGame/Cameras/"+enemy)
	camera.current = true
