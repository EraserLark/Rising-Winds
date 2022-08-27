extends Node2D

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer
var actorName : String
export(Resource) var actorInfo

func _ready():
	actorName = actorInfo.characterName
	pass # Replace with function body.

func changeFace(faceName):
	#sprite.set_texture(faces[faceNum])
	var newFace : Texture = actorInfo.charFaces[faceName]
	sprite.set_texture(newFace)

func playAnimation(anim):
	animPlayer.play(anim)
