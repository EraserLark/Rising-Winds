extends Control

onready var choiceButtons = $CenterContainer/VBoxContainer
onready var textBox = $Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	choiceButtons.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
