extends Sprite

onready var bullet = preload("res://Nodes/Projectiles/Bullet.tscn")
var can_shoot = true
export var ammoPerShot = 1
export var shootDelay = 0.25
export var spread = 2
export var damage = 3

func Shoot():
	if can_shoot and get_parent().get_parent().ammo >= ammoPerShot:
		$ShootSound.stop()
		$ShootSound.play()
		get_parent().get_parent().ConsumeAmmo(ammoPerShot)
		var bullet_inst = bullet.instance()
		bullet_inst.Owner = get_parent().get_parent()
		bullet_inst.damage = damage
		bullet_inst.position = get_parent().get_global_position() + Vector2(80,0).rotated(get_parent().rotation)
		bullet_inst.rotation_degrees = get_parent().rotation_degrees + rand_range(-spread,spread)
		get_tree().get_root().add_child(bullet_inst)
		can_shoot = false
		yield(get_tree().create_timer(shootDelay), "timeout")
		can_shoot = true
