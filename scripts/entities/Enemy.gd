extends Node

onready var ProjectileTimer = Timer.new()
export (PackedScene) var Projectile
func _ready():
	ProjectileTimer.one_shot = false
	add_child(ProjectileTimer)
func attack(enemy):
	var enemyNode = get_node(enemy)
	var enemyValues = Values.attackValues[enemy]
	
	#Check enemy attack type
	if enemyValues["Attack"] == "Left-Right":
		leftRight(enemy,enemyNode,enemyValues)
	

func leftRight(enemy,enemyNode,enemyValues):

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
	
	spawnProjectile(enemyNode,enemyValues)
	#Projectiles
	ProjectileTimer.wait_time = enemyValues["ProjectileDistance"]
	ProjectileTimer.connect("timeout",self,"spawnProjectile",[enemyNode,enemyValues])
	ProjectileTimer.start()
	
	yield(animate,"tween_all_completed")
	Values.fightState = "menu"

func spawnProjectile(enemyNode,enemyValues):
	print(1)
	if Values.fightState == "attack":
		print(2)
		var projectile = Projectile.instance()
		projectile.Velocity = Vector2(enemyValues["ProjectileVel"])
		projectile.position = enemyNode.position
		add_child(projectile)
	else:
		print(3)
		ProjectileTimer.stop()
