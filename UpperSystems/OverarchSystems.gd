extends Node

var novelStage = preload("res://Novel/NovelStage.tscn")
onready var mainMenu = $MainMenu

func _ready():
	mainMenu.connect("start_chapter", self, "startChapter")

func startChapter():
	var currentNovStage = novelStage.instance()
	self.add_child(currentNovStage)
	get_node("MainMenu").queue_free()
