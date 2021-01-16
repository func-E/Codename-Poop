extends Sprite

onready var bullet = preload("res://Nodes/Projectiles/Bullet.tscn")
var can_shoot = true
var right_gun = true
export var ammoPerShot = 1
export var shootDelay = 0.05
export var spread = 9
export var damage = 1

func Shoot():
	if can_shoot and get_parent().get_parent().ammo >= ammoPerShot:
		$ShootSound.stop()
		$ShootSound.play()
		get_parent().get_parent().ConsumeAmmo(ammoPerShot)
		var bullet_inst = bullet.instance()
		bullet_inst.damage = damage
		if right_gun:
			bullet_inst.position = get_parent().get_global_position() + Vector2(80,36).rotated(get_parent().rotation)
			right_gun = false
		else:
			bullet_inst.position = get_parent().get_global_position() + Vector2(80,-36).rotated(get_parent().rotation)
			right_gun = true
		bullet_inst.rotation_degrees = get_parent().rotation_degrees + rand_range(-spread,spread)
		get_tree().get_root().add_child(bullet_inst)
		can_shoot = false
		yield(get_tree().create_timer(shootDelay), "timeout")
		can_shoot = true
