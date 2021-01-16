extends Area2D

export var healthGiven = 0.1

func _on_Small_Health_body_entered(body):
	if body.has_method("Heal") and body.health < body.maxHealth:
		body.Heal(round(body.maxHealth * healthGiven))
		queue_free()
