extends Node

var selectedSign

func itemCollision(body: Node, entered: bool, targetSign: String) -> void:
	if entered:
		selectedSign = targetSign
	else:
		selectedSign = null
		
func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ENTER) && event.is_pressed() && selectedSign:
		var dialouge = Dialogic.start(selectedSign)
		dialouge.connect("dialogic_signal",self,"itemAccepted")
		add_child(dialouge)
