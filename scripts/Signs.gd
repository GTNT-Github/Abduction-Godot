extends Node

var selectedSign

func signCollision(body: Node, entered: bool, targetSign: String) -> void:
	if entered:
		selectedSign = targetSign
	else:
		selectedSign = null
		
func _input(event: InputEvent) -> void:
	if event.is_action("ui_select") && event.is_pressed() && selectedSign && !Dialogic.has_current_dialog_node():
		var dialouge = Dialogic.start(selectedSign)
		dialouge.connect("dialogic_signal",self,"itemAccepted")
		add_child(dialouge)
