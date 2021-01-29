extends CanvasLayer

func _ready():
	$Background.visible = false

func PauseUnpause():
	get_tree().paused = !get_tree().paused
	$Background.visible = get_tree().paused

func _on_ResumeButton_pressed():
	PauseUnpause()

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		PauseUnpause()

func _on_MainMenuButton_pressed():
	GameManager.MainMenu()
	get_tree().paused = false
