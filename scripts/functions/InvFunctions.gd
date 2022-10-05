extends Node


var inventory:Array = ["-----","-----","-----","-----","-----"]
var armor:String = "-----"
var weapon:String = "-----"

var tempInventory:Array = ["-----","-----","-----","-----","-----"]
var tempArmor:String = "-----"
var tempWeapon:String = "-----"

func setArmor(invSlot:int):
	var armorItem = inventory[invSlot]
	if armor != "-----":
		inventory[invSlot] = armor
	else:
		removeItem(invSlot)
	armor = armorItem

func setWeapon(invSlot:int):
	weapon = inventory[invSlot]
	if weapon != "-----":
		inventory[invSlot] = weapon
	else:
		removeItem(invSlot)

func addItem(item:String):
	print(item)
	for n in inventory.size():
		var i = inventory[n]
		if i != "-----":
			inventory[n] = item

func removeItem(invSlot:int):
	inventory[invSlot] = "-----"
	resetInventory()

func resetInventory():
	var tempInv = ["-----","-----","-----","-----","-----"]
	var count = 0
	for n in inventory.size():
		var i = inventory[n]
		if i != "-----":
			tempInv[count] = i
			count+=1
	inventory = tempInv
