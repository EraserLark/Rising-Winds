extends Node2D

onready var face = $BodySprite/FacePoint/FaceSprite
onready var body = $BodySprite
onready var animPlayer = $AnimationPlayer
var actorName : String
export(Resource) var actorInfo
export(String) var startFace

func _ready():
	actorName = actorInfo.characterName
	if startFace:
		changeFace(startFace)
		changePose(startFace)

func changePose(poseName):
	var newPose : Texture = actorInfo.charPoses[poseName]
	body.set_texture(newPose)
	body.position = actorInfo.offsetData[poseName]

func changeFace(faceName):
	var newFace : Texture = actorInfo.charFaces[faceName]
	face.set_texture(newFace)

func playAnimation(anim):
	animPlayer.play(anim)
