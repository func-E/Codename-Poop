extends Navigation2D

func SetPlayerState(data : Dictionary):
	var Player = get_child(0).get_node("Player")
	Player.health = data["Health"]
	Player.ammo = data["Ammo"]
	Player.weaponsList = data["Weapons"]
	Player.Update_Inventory()
