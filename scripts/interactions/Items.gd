extends Node

func itemCollision(body: Node, entered: bool, item: String) -> void:
	if entered:
		Values.selectedItem = item
	else:
		Values.selectedItem = null
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") && Values.selectedItem && !Dialogic.has_current_dialog_node():
		var dialouge = Dialogic.start(Values.selectedItem)
		dialouge.connect("dialogic_signal",self,"itemAccepted")
		add_child(dialouge)

func itemAccepted(item:String):
	for n in InvFunctions.inventory.size():
		var invValue = InvFunctions.inventory[n]
		if invValue == "-----":
			InvFunctions.inventory[n] = Values.selectedItem
			Dialogic.set_variable("InventorySize",n+1)
			remove_child(get_node(Values.selectedItem))
			Values.selectedItem = null
			break
