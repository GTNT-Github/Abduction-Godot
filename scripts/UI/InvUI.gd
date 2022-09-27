extends Sprite

var selectedSlot = 1

func _ready():
	self.visible = false

func _input(event: InputEvent) -> void:

	#Open Inventory
	if event.is_action("ui_select") && event.is_pressed() && !Values.selectedItem && !Values.selectedSign && GeneralFunc.checkUI() && !Values.currentEnemy:
		Values.invOpen = true
		self.visible = true
		resetInv()
		
	#Close Inventory
	elif event.is_action("ui_cancel") && event.is_pressed():
		Values.invOpen = false
		self.visible = false
	
	#UI Arrow Keys
	elif event.is_action("ui_up") && event.is_pressed() && Values.invOpen:
		changeSelect(selectedSlot-1)
	elif event.is_action("ui_down") && event.is_pressed() && Values.invOpen:
		changeSelect(selectedSlot+1)
		
	#Use Item
	elif event.is_action("ui_select") && event.is_pressed() && Values.invOpen:
		var currentItem = InvFunctions.inventory[selectedSlot-1]
		if currentItem != "-----":
			if Values.itemTypes[currentItem] == "Armor":
				InvFunctions.setArmor(selectedSlot-1)
				resetInv()

func resetInv():
	$ArmorSlot.text = InvFunctions.armor
	$WeaponSlot.text = InvFunctions.weapon
	for n in InvFunctions.inventory.size():
		get_node(str("InvSlot",n+1)).text = InvFunctions.inventory[n]
		get_node(str("InvSlot",n+1)).add_color_override("font_color",Color(1,1,1))
	changeSelect(1)

func changeSelect(slot):
	if slot <= 5 && slot >=1:
		if InvFunctions.inventory[slot-1] != "-----":
			get_node(str("InvSlot",selectedSlot)).add_color_override("font_color",Color(1,1,1))
			selectedSlot = slot
			get_node(str("InvSlot",selectedSlot)).add_color_override("font_color",Color(0.4,0.4,0.4))
