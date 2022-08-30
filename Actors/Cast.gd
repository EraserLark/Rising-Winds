extends Node2D

var actorTemp = preload("res://Actors/Actor.tscn")
var actorArray : Array

func updateCast(jsonObj, castDict):
	var newCast = jsonObj[castDict]
	for obj in newCast:
		addActor(obj)
	
	actorArray = updateActorArray()

func addActor(castDict):
		var newActor = actorTemp.instance()
		newActor.startFace = castDict["Face"]
		newActor.name = castDict["Name"]
		newActor.actorInfo = load(castDict["Info"])
		newActor.position = (str2var(castDict["Position"]))	#Vector2
		add_child(newActor)

func updateActorArray():
	return self.get_children()
