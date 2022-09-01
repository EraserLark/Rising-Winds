extends Node

onready var novInterface = $NovelInterface
onready var cast = $Cast
onready var animPlayer = $AnimationPlayer

export (String) var jsonDialogue
var convos

var dictCount : int = 0
var route
var routeSize = 0

func _ready():
	convos = loadJSONFile(jsonDialogue)
	var startingCast = convos["chapterStart"]["startingCast"]
	var startingRoute = convos["chapterStart"]["startingRoute"]
	
	novInterface.connect("choice_selected", self, "nextChoice")
	cast.updateCast(startingCast)
	routeStart(convos, startingRoute)

#https://www.youtube.com/watch?v=8HOmLNuuccs&t=178s
func loadJSONFile(file_path):
	var file = File.new()
	assert(file.file_exists(file_path))
	
	file.open(file_path, file.READ)
	var jsonFile = parse_json(file.get_as_text())
	assert(jsonFile.size() > 0)
	return jsonFile

func routeStart(dialogueObj, routeName):
	dictCount = 0
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

func nextLine(typeDict):
	if "Dialogue" in typeDict:
		var dict = typeDict["Dialogue"]
		#ACTOR
		var actor = cast.actorArray[dict["Actor"]]
		actor.changeFace(dict["Face"])
		#ANIMATION - ConcurrentAnim
		if dict["Anim"] != null:
			#actor.playAnimation(dict["Anim"])
			animPlayer.play(dict["Anim"])
		#DIALOGUE
		novInterface.changeName(dict["Name"])
		novInterface.changeText(dict["Dialogue"])
	#SoloAnim
	if "Animation" in typeDict:
		var dict = typeDict["Animation"]
		var actor = cast.actorArray[dict["Actor"]]
		animPlayer.play(dict["Anim"])
		novInterface.changeText("")

func showChoices(choicesDict):
	novInterface.newChoice(choicesDict, false)

func nextChoice(nextRoute):
	routeStart(convos, nextRoute)
