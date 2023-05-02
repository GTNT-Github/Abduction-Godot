extends Node

func fightCamera(enemy):
	var camera = get_node("/root/Level1/Cameras/"+enemy)
	camera.current = true
