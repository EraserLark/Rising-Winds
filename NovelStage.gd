extends Node

onready var novInterface = $NovelInterface
onready var cast = $Cast
onready var animPlayer = $AnimationPlayer

var actorTemp = preload("res://Actors/Actor.tscn")
var actorArray : Array

export (String) var jsonDialogue
var convos

var dictCount : int = 0
var route
var routeSize = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	convos = loadJSONFile(jsonDialogue)
	novInterface.connect("choice_selected", self, "nextChoice")
	updateCast(convos, "actorDict")
	routeStart(convos, "masterDict")

#https://www.youtube.com/watch?v=8HOmLNuuccs&t=178s
func loadJSONFile(file_path):
	var file = File.new()
	assert(file.file_exists(file_path))
	
	file.open(file_path, file.READ)
	var jsonFile = parse_json(file.get_as_text())
	assert(jsonFile.size() > 0)
	return jsonFile

func updateCast(jsonObj, castDict):
	var newCast = jsonObj[castDict]
	for obj in newCast:
		var newActor = actorTemp.instance()
		newActor.name = obj["Name"]
		newActor.actorInfo = load(obj["Info"])
		newActor.position = (str2var(obj["Position"]))	#Vector2
		cast.add_child(newActor)
	
	actorArray = cast.get_children()

func routeStart(dialogueObj, routeName):
	setRoute(dialogueObj, routeName)	
	novInterface.buttonReveal(false)	#Hide buttons
	nextLine(route[dictCount])

func setRoute(dialogObj, routeName):
	route = dialogObj[routeName]
	routeSize = route.size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		dictCount += 1
		if dictCount < routeSize:
			nextLine(route[dictCount])
		else:
			showChoices(convos["choiceDict"])

func nextLine(dict):
	var actor = actorArray[dict["Actor"]]
	actor.changeFace(dict["Face"])
	if dict["Anim"] != null:
		#actor.playAnimation(dict["Anim"])
		animPlayer.play(dict["Anim"])
	novInterface.changeName(dict["Name"])
	novInterface.changeText(dict["Dialogue"])

func showChoices(choicesDict):
	novInterface.newChoice(choicesDict, false)

func nextChoice(nextRoute):
	#route = convos[nextRoute]
	dictCount = 0
	routeStart(convos, nextRoute)
