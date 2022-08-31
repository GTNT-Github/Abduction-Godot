extends Node


var inventory:Array = ["-----","-----","-----","-----","-----"]
var armor:String = "-----"
var weapon:String = "-----"

func setArmor(invSlot:int):
	armor = inventory[invSlot]
	if armor != "-----":
		inventory[invSlot] = armor
	else:
		removeItem(invSlot)

func setWeapon(invSlot:int):
	weapon = inventory[invSlot]
	if weapon != "-----":
		inventory[invSlot] = weapon
	else:
		removeItem(invSlot)

func addItem(item:String):
	for n in inventory.size():
		var i = inventory[n]
		if i != "-----":
			inventory[n] = item

func removeItem(invSlot:int):
	inventory[invSlot] = "-----"
	resetInventory()

func resetInventory():
	var tempInv = ["-----","-----","-----","-----","-----"]
	for n in inventory.size():
		var i = inventory[n]
		if i != "-----":
			tempInv[n] = i
	inventory = tempInv
