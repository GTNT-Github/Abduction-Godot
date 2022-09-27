extends Area2D

export var Velocity = Vector2(0,0)
export var Spare = false

func _process(delta: float) -> void:
	position+=Velocity*delta
