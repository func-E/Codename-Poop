extends Area2D

onready var particles = preload("res://Nodes/Particles/BulletBreakParticle.tscn")
export var speed = 1500
export var lifeTime = 2
export var damage = 1

var prev_damage

var Owner

func _ready():
	$bulletParticle.modulate = ColorCheck(damage)

func _physics_process(delta):
	move_local_x(speed * delta)
	lifeTime -= delta
	if lifeTime < 0:
		queue_free() #bullet disapears

func _on_Bullet_body_entered(body):
	prev_damage = damage
	if body.has_method("Damage"):
		var temp_dmg = body.Damage(damage, self)
		if temp_dmg < damage:
			damage = temp_dmg
	elif body.has_method("wallBang"):
		print("bang")
	else:
		damage = 0
	
	modulate = ColorCheck(damage)
	
	if round(damage) < 1:
		var particle_inst = particles.instance()
		particle_inst.position = position
		particle_inst.modulate = ColorCheck(prev_damage)
		get_parent().add_child(particle_inst)
		queue_free()

func ColorCheck(num):
	if round(num) == 1:
		return "ffe900"
	elif round(num) == 2:
		return "ff5a00"
	elif round(num) == 3:
		return "ff0000"
	elif round(num) == 4:
		return "ff00bf"
	else:
		return "ffffff"
