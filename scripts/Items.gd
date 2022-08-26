extends Node

var selectedItem

func itemCollision(body: Node, entered: bool, item: String) -> void:
	if entered:
		selectedItem = item
	else:
		selectedItem = null
		
func _input(event: InputEvent) -> void:
	if event.is_action("ui_select") && event.is_pressed() && selectedItem && !Dialogic.has_current_dialog_node():
		var dialouge = Dialogic.start(selectedItem)
		dialouge.connect("dialogic_signal",self,"itemAccepted")
		add_child(dialouge)

func itemAccepted(item:String):
	for n in Values.inventory.size():
		var invValue = Values.inventory[n]
		if invValue == "-----":
			Values.inventory[n] = selectedItem
			Dialogic.set_variable("InventorySize",n+1)
			remove_child(get_node(selectedItem))
			selectedItem = null
			break
