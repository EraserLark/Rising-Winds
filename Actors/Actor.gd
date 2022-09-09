extends Node2D

onready var facePt = $BodyPoint/FacePoint
onready var bodyPt = $BodyPoint
onready var faceSpr = $BodyPoint/FacePoint/FaceSprite
onready var bodySpr = $BodyPoint/BodySprite
onready var animPlayer = $AnimationPlayer
var actorName : String
export(Resource) var actorInfo
export(bool) var flipped setget change_flipped
export(String) var startFace

func _ready():
	actorName = actorInfo.characterName
	if startFace:
		changeFace(startFace)
#		changePose(startFace)

func changePose(poseName):
	var newPose : Texture = actorInfo.charPoses[poseName]
	bodySpr.set_texture(newPose)
	#bodySpr.position = actorInfo.offsetData[poseName]

func changeFace(faceName):
	var newFace : Texture = actorInfo.charFaces[faceName]
	faceSpr.set_texture(newFace)

func playAnimation(anim):
	animPlayer.play(anim)

func change_flipped(case):
	var actorOrient = self.get_node("BodyPoint")
	if case:
		actorOrient.set_scale(Vector2(-1, 1))
	if !case:
		actorOrient.set_scale(Vector2(1, 1))
