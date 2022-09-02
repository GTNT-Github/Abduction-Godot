extends Node

func signCollision(body: Node, entered: bool, targetSign: String) -> void:
	if entered:
		Values.selectedSign = targetSign
	else:
		Values.selectedSign = null
		
func _input(event: InputEvent) -> void:
	if event.is_action("ui_select") && event.is_pressed() && Values.selectedSign && !Dialogic.has_current_dialog_node():
		var dialouge = Dialogic.start(Values.selectedSign)
		dialouge.connect("dialogic_signal",self,"itemAccepted")
		add_child(dialouge)
