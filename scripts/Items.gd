extends Node

var selectedItem

func itemCollision(body: Node, entered: bool, item: String) -> void:
	if entered:
		selectedItem = item
	else:
		selectedItem = null
		
func _input(event: InputEvent) -> void:
	if event.
