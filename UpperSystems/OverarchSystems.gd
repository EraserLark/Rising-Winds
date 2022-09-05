extends Node

var novelStage = preload("res://Novel/NovelStage.tscn")
onready var mainMenu = $MainMenu
onready var audioPlayer = $MainMenu/AudioStreamPlayer

func _ready():
	mainMenu.connect("start_chapter", self, "startChapter")
	audioPlayer.play()

func startChapter():
	var currentNovStage = novelStage.instance()
	self.add_child(currentNovStage)
	get_node("MainMenu").queue_free()

