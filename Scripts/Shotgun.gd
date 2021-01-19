extends Sprite

onready var bullet = preload("res://Nodes/Projectiles/Bullet.tscn")
var can_shoot = true
export var ammoPerShot = 5
export var shootDelay = 0.75
export var spread = 15.0
export var spawnDistance = 80
export var damage = 3

func Shoot():
	if can_shoot and get_parent().get_parent().ammo >= ammoPerShot:
		$ShootSound.stop()
		$ShootSound.play()
		get_parent().get_parent().ConsumeAmmo(ammoPerShot)
		for i in range(-spread,spread+1,spread/2):
			var bullet_inst = bullet.instance()
			bullet_inst.damage = damage
			bullet_inst.position = get_parent().get_global_position() + Vector2(spawnDistance,0).rotated(get_parent().rotation + deg2rad(i))
			bullet_inst.rotation_degrees = get_parent().rotation_degrees + i
			get_tree().get_root().add_child(bullet_inst)
		can_shoot = false
		yield(get_tree().create_timer(shootDelay), "timeout")
		can_shoot = true
