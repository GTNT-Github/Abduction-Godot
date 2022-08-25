extends Node

#Scenes
var itemScene:PackedScene = preload("res://scenes/Item.tscn")

#Item Sprites
var healthPotionSprite = preload("res://assets/items/healPotion.png")


func dialougeStart(conversation):
	add_child(Dialogic.start(conversation))
