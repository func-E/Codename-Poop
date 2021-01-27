extends Control

onready var Game = get_node("/root/GameManager")
onready var Animations = $MenuAnimations
onready var SaveNodePath = $PlayMenu/SaveFileContainer

var loaded_data : Dictionary
func _ready():
	SetSettingsMenu(false)
	SetPlayMenu(false)
	ReloadMenuData()

func ReloadMenuData():
	for i in range(1,4):
		loaded_data = Game.Load(i)
		ShowSaveData(loaded_data, i)

func ShowSaveData(data : Dictionary, number : int):
	if SaveNodePath.has_node("Save" + str(number)):
		SaveNodePath.get_node("Save" + str(number)).get_node("SaveText/StatsContainer/Level").text = "Level " + str(data["Level"])
		SaveNodePath.get_node("Save" + str(number)).get_node("SaveText/StatsContainer/Health").text = "Health " + str(data["Health"])
		SaveNodePath.get_node("Save" + str(number)).get_node("SaveText/StatsContainer/Ammo").text = "Ammo " + str(data["Ammo"])

#main menu buttons
func _on_PlayButton_pressed():
	SetMainMenu(false)
	SetPlayMenu(true)
	Animations.play("MainToPlay")

func _on_SettingsButton_pressed():
	SetMainMenu(false)
	SetSettingsMenu(true)
	Animations.play("MainToSettings")

func _on_QuitButton_pressed():
	get_tree().quit()


#settings menu buttons
func _on_SettingsBackButton_pressed():
	SetSettingsMenu(false)
	SetMainMenu(true)
	Animations.play_backwards("MainToSettings")


#play menu buttons
func _on_PlayBackButton_pressed():
	SetMainMenu(true)
	SetPlayMenu(false)
	Animations.play_backwards("MainToPlay")


func _on_Delete1Button_pressed():
	Game.Save(Game.default_data, 1)
	ReloadMenuData()

func _on_Load1Button_pressed():
	Game.StartGame(Game.Load(1))



#enabling and disabling the menus
func SetMainMenu(value):
	$MainButtonContainer/PlayButton.disabled = !value
	$MainButtonContainer/SettingsButton.disabled = !value
	$MainButtonContainer/QuitButton.disabled = !value

func SetSettingsMenu(value):
	$SettingsMenu/SettingsBackButton.disabled = !value

func SetPlayMenu(value):
	$PlayMenu/PlayBackButton.disabled = !value
