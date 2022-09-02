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
