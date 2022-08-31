extends Control

onready var startButton = $CenterContainer/VBoxContainer/StartButton

signal start_chapter()

func _on_StartButton_pressed():
	emit_signal("start_chapter")

func _on_Options_Button_pressed():
	pass # Replace with function body.
