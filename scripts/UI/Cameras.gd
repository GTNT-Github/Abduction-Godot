extends Node

func fightCamera(enemy):
	var camera = get_node("/root/MainGame/Cameras/"+enemy)
	camera.current = true
