extends KinematicBody2D

export var startingRotation = 0

var player
onready var smallAmmoPack = preload("res://Nodes/PickUps/SmallAmmo.tscn")

var lookDir
var isWalking = false
var sensePlayer = false
var sees_player = false
var can_path = true
var can_attack = true
export var enemyDamage = 1
export var attackDelay = 0.4
export var maxSpeed = 20000
export var moveAcceleration = 0.1
export var health = 5
export var visionAngle = 80
export var lookSnapiness = 0.2
export var bulletOffset: Vector2 = Vector2(60, 20)

onready var bullet = preload("res://Nodes/Projectiles/Bullet.tscn")

var velocity = Vector2.ZERO
var moveTarget = Vector2.ZERO
var path

func _ready():
	$EnemySprite.rotation_degrees = startingRotation
	if get_parent().has_node("Player"):
		player = get_parent().get_node("Player")

func _physics_process(delta):
	#checking if the enemy can see the player
	if get_parent().has_node("Player"):
		$EnemySprite/VisionRay.look_at(get_parent().get_node("Player").get_global_position())
		$EnemySprite/VisionRay.rotation_degrees = clamp($EnemySprite/VisionRay.rotation_degrees, -visionAngle, visionAngle)
		if $EnemySprite/VisionRay.is_colliding() and $EnemySprite/VisionRay.get_collider().name == "Player":
			moveTarget = $EnemySprite/VisionRay.get_collider().get_global_position()
			sees_player = true
		elif sensePlayer:
			moveTarget = player.get_global_position()
			sees_player = true
		else:
			sees_player = false
	
	if sees_player:
		$EnemySprite.rotation = lerp_angle($EnemySprite.rotation, (moveTarget - position).angle(), lookSnapiness)
		Attack()
	else:
		PathToTarget(moveTarget)
		if path and path.size() > 0:
			if position.distance_to(path[0]) > 60:
				velocity = lerp(velocity, (path[0] - position).normalized(), moveAcceleration)
				lookDir = velocity.angle()
			else:
				path.remove(0)
		else:
			velocity = lerp(velocity, Vector2.ZERO, moveAcceleration)
			isWalking = false
		move_and_slide(velocity * maxSpeed * delta)
		if lookDir:
			$EnemySprite.rotation = lerp_angle($EnemySprite.rotation, lookDir, lookSnapiness)

func Attack():
	if can_attack:
		var bullet_inst = bullet.instance()
		bullet_inst.damage = enemyDamage
		bullet_inst.rotation = $EnemySprite.rotation
		bullet_inst.position = position + bulletOffset.rotated($EnemySprite.rotation)
		get_parent().add_child(bullet_inst)
		can_attack = false
		yield(get_tree().create_timer(attackDelay), "timeout")
		can_attack = true

func Damage(damage, dealer : Node):
	var damage_left = damage - health
	health -= damage
	if health < 1:
		Die()
	elif !isWalking:
		lookDir = deg2rad(dealer.rotation_degrees + 180)
	return damage_left

func Die():
	var drop = smallAmmoPack.instance()
	drop.position = position
	get_parent().add_child(drop)
	queue_free()

func PathToTarget(target):
	if target and position.distance_to(target) > 60 and can_path:
		path = get_parent().get_parent().get_simple_path(position, target, false) #create path to player
		for value in path.size() - 1:
			if position.distance_to(path[value]) < 60:
				path.remove(value)
		isWalking = true
		can_path = false
		yield(get_tree().create_timer(0.1), "timeout")
		can_path = true


func _on_SenseArea_body_entered(body):
	if body == player:
		sensePlayer = true

func _on_SenseArea_body_exited(body):
	if body == player:
		sensePlayer = false
