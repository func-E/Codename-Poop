extends Control

func _on_Player_updateAmmo(new_ammo):
	$AmmoBar.value = new_ammo

func _on_Player_updateHealth(new_health):
	$HealthBar.value = new_health
