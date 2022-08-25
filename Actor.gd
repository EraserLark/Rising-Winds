extends Node2D

var angryTest = preload("res://TestAssets/Angry.png")
var happyTest = preload("res://TestAssets/Happy.png")
var normalTest = preload("res://TestAssets/Normal.png")
var sadTest = preload("res://TestAssets/Sad.png")
var faces = [angryTest, happyTest, normalTest, sadTest]

onready var sprite = $Sprite
var actorName : String
export(Resource) var actorInfo

func _ready():
	actorName = actorInfo.characterName
	pass # Replace with function body.

func _process(delta):
#	if Input.is_action_just_pressed("ui_up"):
#		faceNumber += 1
#		changeFace(faceNumber)
#	if Input.is_action_just_pressed("ui_down"):
#		faceNumber -= 1
#		changeFace(faceNumber)
	pass

func changeFace(faceName):
	#sprite.set_texture(faces[faceNum])
	var newFace : Texture = actorInfo.charFaces[faceName]
	sprite.set_texture(newFace)
