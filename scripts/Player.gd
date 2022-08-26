extends KinematicBody2D
export var speed = 250
var faceLeft: bool = true


func _process(delta: float) -> void:
	var velocity: Vector2 = getInput()
	move_and_slide(velocity*speed)

func getInput() -> Vector2:
	var animatedSprite = get_node("Sprite")
	var velocity: Vector2 = Vector2.ZERO
	var animation: String = "idle"
	if !Dialogic.has_current_dialog_node():
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
			animation = "walk"
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
			animation = "walk"
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			animation = "walk"
			faceLeft = false
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			animation = "walk"
			faceLeft = true
		animatedSprite.flip_h = faceLeft
		if animation != animatedSprite.animation:
			animatedSprite.play(animation)
			animatedSprite.flip_h = faceLeft
	return velocity
