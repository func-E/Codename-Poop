extends Area2D

export var ammoGiven = 0.1

func _on_Small_Ammo_body_entered(body):
	if body.has_method("AddAmmo") and body.ammo < body.maxAmmo:
		body.AddAmmo(round(body.maxAmmo * ammoGiven))
		queue_free()
