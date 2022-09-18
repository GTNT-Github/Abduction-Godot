extends Control

var flickerLoop

func _ready() -> void:
	self.visible = false


func startFight(area: Area2D, enemy: String) -> void:
	self.visible = true
	flicker()


func flicker() -> void:
	for n in 5:
		$Timer.start()
		yield($Timer,"timeout")
		if n%2 == 0:
			$Flicker.visible = false
			rect_scale = Values.flickrValues[n]
			GeneralFunc.playSound("fightStart")
			if n == 4:
				print(69)
				GeneralFunc.playMusic("fightSong")
		else:
			$Flicker.visible = true
		
