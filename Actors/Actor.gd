extends Node2D

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer
var actorName : String
export(Resource) var actorInfo
export(String) var startFace

func _ready():
	actorName = actorInfo.characterName
	if startFace:
		changeFace(startFace)

func changeFace(faceName):
	var newFace : Texture = actorInfo.charFaces[faceName]
	sprite.set_texture(newFace)

func playAnimation(anim):
	animPlayer.play(anim)
