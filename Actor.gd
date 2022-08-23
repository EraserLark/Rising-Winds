extends Node2D

var angryTest = preload("res://TestAssets/Angry.png")
var happyTest = preload("res://TestAssets/Happy.png")
var normalTest = preload("res://TestAssets/Normal.png")
var sadTest = preload("res://TestAssets/Sad.png")
var faces = [angryTest, happyTest, normalTest, sadTest]
var faceNumber = 0
onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	changeFace(faceNumber)
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		faceNumber += 1
		changeFace(faceNumber)
	if Input.is_action_just_pressed("ui_down"):
		faceNumber -= 1
		changeFace(faceNumber)
	pass

func changeFace(faceNum):
	sprite.set_texture(faces[faceNum])
