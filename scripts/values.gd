extends Node

var inventory:Array = ["-----","-----","-----","-----","-----"]
var armor:String = "-----"
var weapon:String = "-----"

var invOpen:bool = false
var selectedItem

var itemTypes = {
	"Shield" : "Armor"
}

var itemStats = {
	"Shield" : 10
}
