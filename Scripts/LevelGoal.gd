extends Area2D

onready var Game = get_node("/root/GameManager")

func _on_LevelGoal_body_entered(body):
	if body.name == "Player":
		var player_data = {
			"Level" : int(get_parent().get_parent().name) + 1,
			"Health" : body.health,
			"Ammo" : body.ammo,
			"Weapons" : body.WeaponsList,
			"Abilities" : []
		}
		Game.Save(player_data, Game.current_game)
		Game.StartGame(player_data, Game.current_game)
