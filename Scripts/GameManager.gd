extends Node2D

onready var main_menu = preload("res://Nodes/UI/MainMenu.tscn")

const levels = {
	"lvl1" : preload("res://Nodes/Levels/Lvl1.tscn"),
	"lvl2" : preload("res://Nodes/Levels/Lvl2.tscn"),
	"lvl3" : preload("res://Nodes/Levels/Lvl3.tscn")
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

var current_game : int = 0
func StartGame(number : int):
	var data = Load(number)
	LoadItem(levels["lvl" + str(data["Level"])])
	current_game = number
	yield(get_tree().create_timer(0.1),"timeout") #this is a terrible solution and should be changed as soon as I figure out another way
	get_parent().get_node("Lvl" + str(data["Level"])).SetPlayerState(data)

func MainMenu():
	LoadItem(main_menu)
	current_game = 0

const default_data = {
	"Level" : 1,
	"Health" : 20,
	"Ammo" : 0,
	"Weapons" : [false, false, false],
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


#settings data
var settings_data = {
	"Fullscreen" : false
}

func LoadSettings():
	pass

func SaveSettings():
	pass
