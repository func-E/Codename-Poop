extends Control

var MainMenu

func _ready():
	pass

func _on_BackButton_pressed():
	get_parent().get_parent().LoadItem(MainMenu)
