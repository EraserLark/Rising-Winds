tool
extends Node2D

onready var facePt = $BodyPoint/FacePoint
onready var bodyPt = $BodyPoint
onready var faceSpr = $BodyPoint/FacePoint/FaceSprite
onready var bodySpr = $BodyPoint/BodySprite
onready var animPlayer = $AnimationPlayer
onready var tween = $Tween

var actorName : String
export(Resource) var actorInfo
export(bool) var flipped setget change_flipped
export(bool) var testBool
export(String) var exprFace setget changeFace
export(String) var exprPose setget changePose

func _ready():
	actorName = actorInfo.characterName
	#Test tweening
	if Engine.editor_hint == false:
		slideToPos(Vector2(300,300))

func changeFace(faceName):
	var newFace : Texture = actorInfo.charFaces[faceName]
	faceSpr.set_texture(newFace)

func changePose(poseName):
	var newPose : Texture = actorInfo.charPoses[poseName]
	bodySpr.set_texture(newPose)

func playAnimation(anim):
	animPlayer.play(anim)

func change_flipped(case):
	if flipped == case:
		return
	
	if bodySpr == null:
		bodySpr = get_node("BodyPoint/BodySprite")
		faceSpr = get_node("BodyPoint/FacePoint/FaceSprite")
		bodyPt = get_node("BodyPoint")
		facePt = get_node("BodyPoint/FacePoint")
	
	var flipNum = -1
	print(var2str(case) + self.name)
	
	bodySpr.flip_h = case
	faceSpr.flip_h = case
	
	var currentPos
	currentPos = facePt.position
	facePt.position = Vector2((currentPos.x * flipNum), currentPos.y)
	
	currentPos = bodyPt.position
	bodyPt.position = Vector2((currentPos.x * flipNum), currentPos.y)
	
	flipped = case

func slideToPos(newPos : Vector2):
	var currentPos = self.position
	tween.interpolate_property(self, "position", currentPos, newPos, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
