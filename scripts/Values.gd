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
var selectedText
var fightState = "attack"
var selectedMenu
var currentEnemy

#Item Values
var itemTypes = {
	"Shield" : "Armor",
	"Health Potion" : "Health",
	"BlueKeycard" : "Keycard"
}

var itemStats = {
	"Shield": 10,
	"Health Potion": 10,
	"-----": 0
}


#Sound Vales
var sounds = {
	"fightStart": preload("res://assets/sound/fightStart.wav"),
	"select": preload("res://assets/sound/select.wav")
}

var music = {
	"fightSong": preload("res://assets/music/fightSong.wav")
}


#Fight Values

var HP = 100

var flickrValues = {
	0:Vector2(1.54,1.54),
	2:Vector2(1.28,1.28),
	4:Vector2.ONE
}

var actValues = {
	"Guard1": ["Insult","Compliment"]
}

var attackValues = {
	"Guard1": {
		"AttackDir": "Left-Right",
		"Left": Vector2(408,979),
		"Right": Vector2(888,979),
		"End": Vector2(648,979),
		"Duration": 5,
		"StartDuration": 1,
		"Direction": "Right",
		"Attacks": 0,
		"ProjectileDistance": 0.5,
		"ProjectileVel": Vector2(0,-200),
		"Attack": 10,
		"Drops": true,
		"Drop": "BlueKeycard"
		}
}

var fightButtons = {
	"Items": "Left/Items",
	"Act": "Right/Act",
	"ItemsText": "Left/Text",
	"ActText": "Right/Text",
	"Items1": "Left/Text/Slot1",
	"Items2": "Left/Text/Slot2",
	"Items3": "Left/Text/Slot3",
	"Items4": "Left/Text/Slot4",
	"Items5": "Left/Text/Slot5",
	"Act1": "Right/Text/Act1",
	"Act2": "Right/Text/Act2",
	"Act3": "Right/Text/Act3",
	"Act4": "Right/Text/Act4",
	"Act5": "Right/Text/Act5",
}
