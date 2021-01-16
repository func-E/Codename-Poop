extends KinematicBody2D

export var health = 10

func Damage(damage):
	var damage_left = damage - health
	health -= damage
	if health < 1:
		queue_free() #placeholder for dieing
	return damage_left
