extends CanvasLayer

var enabled = true

func _ready():
	$Background.visible = false
	get_tree().paused = false

func PauseUnpause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		$Animations.play("PausedMenuFadeIn")
	else:
		$Animations.play_backwards("PausedMenuFadeIn")
	$Background.visible = get_tree().paused

func _on_ResumeButton_pressed():
	PauseUnpause()

func _process(_delta):
	if Input.is_action_just_pressed("Pause") and enabled:
		PauseUnpause()

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	GameManager.MainMenu()
