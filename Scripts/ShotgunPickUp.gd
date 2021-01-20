extends Area2D


func _on_ShotgunPickUp_body_entered(body):
	if body.name == "Player" and !body.weaponsList[2]:
		body.get_node("PlayerSprite").get_node("Shotgun").get_node("PickUpSound").play()
		body.weaponsList[2] = true
		body.Update_Inventory()
		
		if body.has_method("AddAmmo") and body.ammo < body.maxAmmo:
			body.AddAmmo(30)
		queue_free()

