tool
extends Node2D

onready var facePt = $BodyPoint/FacePoint
onready var bodyPt = $BodyPoint
onready var faceSpr = $BodyPoint/FacePoint/FaceSprite
onready var bodySpr = $BodyPoint/BodySprite
onready var animPlayer = $AnimationPlayer

var actorName : String
export(Resource) var actorInfo
export(bool) var flipped setget change_flipped
export(bool) var testBool
export(String) var expFace setget changeFace
export(String) var expPose setget changePose

func _ready():
	actorName = actorInfo.characterName
#	changeFace(startFace)
#	changePose(startPose)

func changeFace(faceName):
	var newFace : Texture = actorInfo.charFaces[faceName]
	faceSpr.set_texture(newFace)
	pass

func changePose(poseName):
	var newPose : Texture = actorInfo.charPoses[poseName]
	bodySpr.set_texture(newPose)
	pass

func playAnimation(anim):
	animPlayer.play(anim)

func change_flipped(case):
	print(var2str(case) + self.name)
	
	bodySpr = get_node("BodyPoint/BodySprite")
	faceSpr = get_node("BodyPoint/FacePoint/FaceSprite")
	bodyPt = get_node("BodyPoint")
	facePt = get_node("BodyPoint/FacePoint")
	
	bodySpr.flip_h = case
	faceSpr.flip_h = case
	
	var flipNum = -1
	if flipped == case:
		flipNum = 1
	
	var currentPos
	currentPos = facePt.position
	facePt.position = Vector2((currentPos.x * flipNum), currentPos.y)
	
	currentPos = bodyPt.position
	bodyPt.position = Vector2((currentPos.x * flipNum), currentPos.y)
	
	flipped = case
	
#	if bodySpr == null:
	
#	if case == true:

#	elif case == false:
#		var currentPos
#		currentPos = facePt.position
#		facePt.position = Vector2(abs(currentPos.x), currentPos.y)
#
#		currentPos = bodyPt.position
#		bodyPt.position = Vector2(abs(currentPos.x), currentPos.y)
