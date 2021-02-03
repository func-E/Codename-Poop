extends Control

onready var Animations = $MenuAnimations
onready var SaveNodePath = $PlayMenu/PlayContainer/SaveFileContainer

var loaded_data : Dictionary
func _ready():
	SetSettingsMenu(false)
	SetPlayMenu(false)
	ReloadMenuData()
	get_tree().paused = false

func ReloadMenuData():
	for i in range(1,4):
		loaded_data = GameManager.Load(i)
		ShowSaveData(loaded_data, i)

func ShowSaveData(data : Dictionary, number : int):
	if SaveNodePath.has_node("Save" + str(number)):
		SaveNodePath.get_node("Save" + str(number)).get_node("SaveText/StatsContainer/Level").text = "Level " + str(data["Level"])
		SaveNodePath.get_node("Save" + str(number)).get_node("SaveText/StatsContainer/Health").text = "Health " + str(data["Health"])
		SaveNodePath.get_node("Save" + str(number)).get_node("SaveText/StatsContainer/Ammo").text = "Ammo " + str(data["Ammo"])
		
		SaveNodePath.get_node("Save" + str(number)).get_node("ItemsContainer/WeaponsContainer/PistolIcon").self_modulate.a = int(data["Weapons"][0])
		SaveNodePath.get_node("Save" + str(number)).get_node("ItemsContainer/WeaponsContainer/UzisIcon").self_modulate.a = int(data["Weapons"][1])
		SaveNodePath.get_node("Save" + str(number)).get_node("ItemsContainer/WeaponsContainer/ShotgunIcon").self_modulate.a = int(data["Weapons"][2])

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

func _on_FullscreenButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	if button_pressed:
		$SettingsMenu/SettingsContainer/Columns/VideoSettings/FullscreenButton.text = "Fullscreen: ON"
	else:
		$SettingsMenu/SettingsContainer/Columns/VideoSettings/FullscreenButton.text = "Fullscreen: OFF"



#play menu buttons
func _on_PlayBackButton_pressed():
	SetMainMenu(true)
	SetPlayMenu(false)
	Animations.play_backwards("MainToPlay")


func _on_Delete1Button_pressed():
	GameManager.Save(GameManager.default_data, 1)
	ReloadMenuData()

func _on_Load1Button_pressed():
	GameManager.StartGame(1)



#enabling and disabling the menus
func SetMainMenu(value):
	$TitleMenu/MainButtonContainer/PlayButton.disabled = !value
	$TitleMenu/MainButtonContainer/SettingsButton.disabled = !value
	$TitleMenu/MainButtonContainer/QuitButton.disabled = !value

func SetSettingsMenu(value):
	$SettingsMenu/SettingsBackButton.disabled = !value
	$SettingsMenu/SettingsContainer/Columns/VideoSettings/FullscreenButton.disabled = !value

func SetPlayMenu(value):
	$PlayMenu/PlayBackButton.disabled = !value
