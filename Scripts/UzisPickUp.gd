extends Area2D

func _on_UzisPickUp_body_entered(body):
	if body.name == "Player" and !body.weaponsList[1]:
		body.get_node("PlayerSprite").get_node("DualUzis").get_node("PickUpSound").play()
		body.weaponsList[1] = true
		body.Update_Inventory()
		
		if body.has_method("AddAmmo") and body.ammo < body.maxAmmo:
			body.AddAmmo(20)
		queue_free()
