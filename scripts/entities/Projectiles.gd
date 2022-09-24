extends Area2D

export var Velocity = Vector2(0,0)

func _ready():
	print(69)
func _process(delta: float) -> void:
	position+=Velocity*delta
