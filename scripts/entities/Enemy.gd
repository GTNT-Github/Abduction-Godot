extends Node

onready var timer = Timer.new()
export (PackedScene) var Projectile
func _ready():
	timer.one_shot = false
	add_child(timer)
	
func attack(spare):
	var enemy = Values.currentEnemy
	var enemyNode = get_node(enemy)
	var enemyValues = Values.attackValues[enemy]
	Values.fightState = "attack"
	#Check enemy attack type
	if spare == "spare":
		get_node(Values.currentEnemy).visible = false
		$"/root/Level1/UI/FightUI".closeUI()
		
	
	elif enemyValues["AttackDir"] == "Left-Right":
		leftRight(enemyNode,enemyValues,spare)
	elif enemyValues["AttackDir"] == "Circle":
		circle(enemyNode,enemyValues,spare)
	

func leftRight(enemyNode,enemyValues,spare):

	#Get attack direction
	var direction = enemyValues["Direction"]
	
	var animate = Tween.new()
	add_child(animate)
	
	 #Set position on first attack
	if enemyValues["Attacks"] == 0:
		animate.interpolate_property(enemyNode,"position",enemyNode.position,enemyValues["Left"],enemyValues["StartDuration"],Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		animate.start()
		yield(animate,"tween_all_completed")
		
	#Attack animation
	animate.interpolate_property(enemyNode,"position",enemyNode.position,enemyValues[direction],enemyValues["Duration"],Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	animate.start()
	
	#Set attack count and direction
	direction = "Right" if direction == "Left" else "Left"
	enemyValues["Attacks"] += 1
	enemyValues["Direction"] = direction

	spawnProjectile(enemyNode,enemyValues,spare)
	#Projectiles
	timer.wait_time = enemyValues["ProjectileDistance"]
	timer.connect("timeout",self,"spawnProjectile",[enemyNode,enemyValues,spare])
	timer.start()
	
	#Wait for attack end
	yield(animate,"tween_all_completed")
	timer.stop()
	#Reset fight UI
	timer.wait_time = 2
	timer.start()
	timer.disconnect("timeout",self,"spawnProjectile")
	yield(timer,"timeout")
	$"/root/Level1/UI/FightUI".resetMenu(spare)
	Values.fightState = "menu"
	timer.stop()

func circle(enemyNode,enemyValues,spare):

	#Get attack direction
	for i in 720:
		i-=360
		enemyValues["Rotation"] = i
		spawnProjectile(enemyNode,enemyValues,spare)
	
	#Reset fight UI
	timer.wait_time = 4
	timer.start()
	yield(timer,"timeout")
	$"/root/Level1/UI/FightUI".resetMenu(spare)
	Values.fightState = "menu"
	timer.stop()
	
func spawnProjectile(enemyNode,enemyValues,spare):
	var projectile = Projectile.instance()
	projectile.Velocity = Vector2(enemyValues["ProjectileVel"])
	if enemyValues.has("Direction"):
		var projectile2 = Projectile.instance()
		projectile2.Velocity = Vector2(enemyValues["ProjectileVel"])*-1
		projectile2.Spare = spare
		projectile2.position = enemyNode.position
		add_child(projectile2)
	if enemyValues.has("Rotation"):
		projectile.rotation = enemyValues["Rotation"]
	projectile.Spare = spare
	projectile.position = enemyNode.position
	add_child(projectile)
