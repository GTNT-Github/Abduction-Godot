extends Node

var selectedItem

func itemCollision(body: Node, entered: bool, item: String) -> void:
	if entered:
		selectedItem = item
	else:
		selectedItem = null
		
func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ENTER) && event.is_pressed() && selectedItem:
		for n in Values.inventory.size():
			var invValue = Values.inventory[n]
			if invValue == "-----":
				Values.inventory[n] = selectedItem
				print(selectedItem)
				remove_child(get_node(selectedItem))
				Preloads.dialougeStart(selectedItem)
				selectedItem = null
				break
