extends Sprite

var selectedSlot = 1

func _ready():
	self.visible = false

func _input(event: InputEvent) -> void:

	if event.is_action("ui_select") && event.is_pressed() && !Values.selectedItem:
		if GeneralFunc.checkUI():
			Values.invOpen = true
			self.visible = true
			$ArmorSlot.text = InvFunctions.armor
			$WeaponSlot.text = InvFunctions.weapon
			for n in InvFunctions.inventory.size():
				get_node(str("InvSlot",n+1)).text = InvFunctions.inventory[n]
				get_node(str("InvSlot",n+1)).add_color_override("font_color",Color(1,1,1))
			changeSelect(1)
		elif !Dialogic.has_current_dialog_node():
			Values.invOpen = false
			self.visible = false
	
func changeSelect(slot):
	get_node(str("InvSlot",selectedSlot)).add_color_override("font_color",Color(1,1,1))
	if InvFunctions.inventory[slot-1] != "-----":
		selectedSlot = slot
		get_node(str("InvSlot",selectedSlot)).add_color_override("font_color",Color(0.4,0.4,0.4))
