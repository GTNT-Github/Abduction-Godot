extends Area2D

export var Velocity = Vector2(0,0)
export var Spare = false

func _process(delta: float) -> void:
	
	var direction = Velocity.rotated(rotation)
	position+=direction*delta

func projectileTouch(area: Node) -> void:
	if area.name == "Player":
		
		if Values.HP <= 0:
			return
		var enemy = Values.currentEnemy
		var armor = InvFunctions.armor
		var enemyValues = Values.attackValues[enemy]
		var HPRemove = round(enemyValues["Attack"]-Values.itemStats[armor]/enemyValues["Attack"]) if Spare == "false" else round((enemyValues["Attack"]-Values.itemStats[armor]/enemyValues["Attack"])/2)
		Values.HP -= HPRemove
		get_node("/root/MainGame/UI/FightUI/Top/HPBack/HPBar").rect_scale = Vector2(Values.HP/100.0,1)
		get_node("/root/MainGame/UI/FightUI/Top/HPBack/HP").text = str(Values.HP,"/100")
		self.queue_free()

		if Values.HP <= 0:
			Values.currentEnemy = null
			Values.fightState = "attack"
			InvFunctions.inventory = InvFunctions.tempInventory
			InvFunctions.armor = InvFunctions.tempArmor
			InvFunctions.weapon = InvFunctions.tempWeapon
			get_tree().change_scene("res://scenes/Death.tscn")

	if area.name == "Cell":
		self.queue_free()
