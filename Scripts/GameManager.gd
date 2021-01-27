extends Node2D

const levels = {
	"lvl1" : preload("res://Nodes/Levels/Lvl1.tscn")
}

func LoadItem(item):
	get_tree().change_scene_to(item)

var save_path_beginning = "user://save"
var save_path_end = ".dat"

func Save(data : Dictionary, number : int):
	var file = File.new()
	var error = file.open(save_path_beginning + str(number) + save_path_end, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
		print("Success!")
	else:
		print(error)

func StartGame(data : Dictionary):
	LoadItem(levels["lvl" + str(data["Level"])])

const default_data = {
	"Level" : 1,
	"Health" : 20,
	"Ammo" : 0,
	"Weapons" : [],
	"Abilities" : []
}

var loaded_data : Dictionary
func Load(number : int):
	var file = File.new()
	if file.file_exists(save_path_beginning + str(number) + save_path_end):
		var error = file.open(save_path_beginning + str(number) + save_path_end, File.READ)
		if error == OK:
			loaded_data = file.get_var()
			file.close()
			return loaded_data
		else:
			print(error)
	else:
		print("File does not exist.\nCreating a new file.")
		Save(default_data,number)
		return default_data
	
