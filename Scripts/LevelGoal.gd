extends Area2D

func _on_LevelGoal_body_entered(body):
	if body.name == "Player":
		var player_data = {
			"Level" : int(get_parent().get_parent().name) + 1,
			"Health" : body.health,
			"Ammo" : body.ammo,
			"Weapons" : body.weaponsList,
			"Abilities" : []
		}
		GameManager.Save(player_data, GameManager.current_game)
		body.get_node("PlayerCamera/LevelCompleteMenu").EndLevel()
