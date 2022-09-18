extends Node


#Inventory
var inventory:Array = ["-----","-----","-----","-----","-----"]
var armor:String = "-----"
var weapon:String = "-----"


#Variable Checks
var invOpen:bool = false


#Select Checks
var selectedItem
var selectedSign
var selectedButton
var fightState = "attack"
var currentEnemy

#Item Values
var itemTypes = {
	"Shield" : "Armor",
	"Shield2" : "Armor"
}

var itemStats = {
	"Shield" : 10,
	"Shield2" : 10
}


#Sound Vales
var sounds = {
	"fightStart":preload("res://assets/sound/fightStart.wav"),
	"select":preload("res://assets/sound/select.wav")
}

var music = {
	"fightSong":preload("res://assets/music/fightSong.wav")
}


#Fight Values
var flickrValues = {
	0: Vector2(1.54,1.54),
	2: Vector2(1.28,1.28),
	4: Vector2.ONE
}

var fightButtons = {
	"Items":"Left/Items",
	"Act":"Right/Act",
	"ItemsText":"Left/Text",
	"ActText":"Right/Text",
	"Slot1":"Left/Text/Slot1",
	"Slot2":"Left/Text/Slot2",
	"Slot3":"Left/Text/Slot3",
	"Slot4":"Left/Text/Slot4",
	"Slot5":"Left/Text/Slot5",
	"Act1":"Right/Text/Act1",
	"Act2":"Right/Text/Act2",
	"Act3":"Right/Text/Act3",
	"Act4":"Right/Text/Act4",
	"Act5":"Right/Text/Act5",
}
