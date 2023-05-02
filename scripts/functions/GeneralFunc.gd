extends Node

func checkUI():
	return !Dialogic.has_current_dialog_node() && !Values.invOpen && Values.fightState == "attack"

func playSound(sound):
	var soundNode = AudioStreamPlayer.new()
	soundNode.stream = Values.sounds[sound]
	add_child(soundNode)
	soundNode.play()

func playMusic(song):
	var musicNode = get_node("/root/MainMenu/Music/"+song)
	musicNode.play()

func stopMusic(song):
	var musicNode = get_node("/root/MainMenu/Music/"+song)
	musicNode.stop()
