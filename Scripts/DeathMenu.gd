extends CanvasLayer

func _ready():
	$Background.visible = false

func Die():
	get_tree().paused = true
	$Animations.play("MenuFadeIn")
	$Background.visible = true

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	GameManager.MainMenu()

func _on_RestartButton_pressed():
	get_tree().paused = false
	GameManager.StartGame(GameManager.current_game)
