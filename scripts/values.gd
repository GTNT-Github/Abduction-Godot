extends Node

var inventory:Array = ["-----","-----","-----","-----","-----"]
var armor:String = "-----"
var weapon:String = "-----"

var invOpen:bool = false
var selectedItem
var selectedSign
var itemTypes = {
	"Shield" : "Armor",
	"Shield2" : "Armor"
}

var itemStats = {
	"Shield" : 10,
	"Shield2" : 10
}

var flickrValues = {
	0: Vector2(1.54,1.54),
	2: Vector2(1.28,1.28),
	4: Vector2.ONE
}

var sounds = {
	"fightStart":preload("res://assets/sound/fightStart.wav")
}

var music = {
	"fightSong":preload("res://assets/music/fightSong.wav")
}
