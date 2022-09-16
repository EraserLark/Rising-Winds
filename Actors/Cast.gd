extends Node2D

var actorTemp = preload("res://Actors/Actor.tscn")
var actorArray : Array

func updateCast(castDict):
	for obj in castDict:
		updateActor(obj)
	
	actorArray = updateActorArray()

func updateActor(castDict):
	var targetActor = get_child(castDict["CastSlot"])
	targetActor.expFace = castDict["Face"]
	targetActor.expPose = castDict["Pose"]
	#targetActor.name = castDict["Name"]
	targetActor.actorInfo = load(castDict["Info"])
	targetActor.position = (str2var(castDict["Position"]))	#Vector2

func addBlankActor():
	var newActor = actorTemp.instance()
	add_child(newActor)

func updateActorArray():
	return self.get_children()
