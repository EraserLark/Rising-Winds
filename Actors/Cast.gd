extends Node2D

var actorTemp = preload("res://Actors/Actor.tscn")
var actorArray : Array
onready var castList : Dictionary = {"Act":"actorObj"}

func updateCast(castDict):
	for obj in castDict:
		updateActor(obj)
	
	actorArray = updateActorArray()

func updateActor(castDict):
	var targetActor = get_child(castDict["CastSlot"])
	targetActor.exprFace = castDict["Face"]
	targetActor.exprPose = castDict["Pose"]
	targetActor.actorInfo = load(castDict["Info"])
	targetActor.position = (str2var(castDict["Position"]))	#Vector2
	
	castList[castDict["Actor"]] = targetActor	#Allows for only name needed in .json to ref actor object

func addBlankActor():
	var newActor = actorTemp.instance()
	add_child(newActor)

func updateActorArray():
	return self.get_children()
