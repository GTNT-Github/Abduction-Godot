extends Node

func checkUI():
	return !Dialogic.has_current_dialog_node() && !Values.invOpen && Values.fightState == "attack"

func playSound(sound):
	var soundNode = AudioStreamPlayer2D.new()
	soundNode.stream = Values.sounds[sound]
	add_child(soundNode)
	soundNode.play()

func playMusic(song):
	var musicNode = AudioStreamPlayer2D.new()
	musicNode.stream = Values.music[song]
	musicNode.volume_db = 5
	add_child(musicNode)
	musicNode.play()
