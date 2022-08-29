extends Node

onready var novInterface = $NovelInterface
onready var cast = $Cast

#Add createActor() func
var actorTemp = preload("res://Actors/Actor.tscn")
onready var actor0 = $Cast/Actor0
onready var actor1 = $Cast/Actor1
onready var actor2 = $Cast/Actor2
onready var animPlayer = $AnimationPlayer
var actorArray

export (String) var jsonDialogue
var convos

var dictCount : int = 0
var route
var routeSize = 0

var actorDict = {
	1: {"Name": "Actor0", "Position": Vector2(152, 376), "Info": "res://TestAssets/TestActor.tres"}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	convos = loadJSONFile(jsonDialogue)
	novInterface.connect("choice_selected", self, "nextChoice")
	updateCast(actorDict)
	
	route = routeStart(convos, "masterDict")

#https://www.youtube.com/watch?v=8HOmLNuuccs&t=178s
func loadJSONFile(file_path):
	var file = File.new()
	assert(file.file_exists(file_path))
	
	file.open(file_path, file.READ)
	var jsonFile = parse_json(file.get_as_text())
	assert(jsonFile.size() > 0)
	return jsonFile

func updateCast(castDict):
	for obj in castDict:
		var newActor = actorTemp.instance()
		newActor.name = actorDict[obj]["Name"]
		newActor.actorInfo = load(actorDict[obj]["Info"])
		newActor.position = actorDict[obj]["Position"]
		cast.add_child(newActor)

func routeStart(dialogueObj, routeName):
	novInterface.buttonReveal(false)	#Hide buttons
	actorArray = [actor0, actor1, actor2]
	
	var _route = dialogueObj[routeName]
	routeSize = _route.size()
	nextLine(_route[dictCount])
	return _route

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		dictCount += 1
		if dictCount < routeSize:
			nextLine(route[dictCount])
		else:
			showChoices()

func nextLine(dict):
	var actor = actorArray[dict["Actor"]]
	actor.changeFace(dict["Face"])
	if dict["Anim"] != null:
		#actor.playAnimation(dict["Anim"])
		animPlayer.play(dict["Anim"])
	novInterface.changeName(dict["Name"])
	novInterface.changeText(dict["Dialogue"])

func showChoices():
	novInterface.newChoice(convos["choiceDict"], false)

func nextChoice(nextRoute):
	#route = convos[nextRoute]
	dictCount = 0
	routeStart(convos, nextRoute)
