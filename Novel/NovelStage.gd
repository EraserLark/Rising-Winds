extends Node

onready var novInterface = $NovelInterface
onready var cast = $Cast
onready var animPlayer = $AnimationPlayer

export (String) var jsonDialogue
var convos

var dictCount : int = 0
var route
var routeSize = 0


##BASE FUNCTIONS
func _ready():
	convos = loadJSONFile(jsonDialogue)
	var startingCast = convos["chapterStart"]["startingCast"]
	var startingRoute = convos["chapterStart"]["startingRoute"]
	
	cast.updateCast(startingCast)
	routeStart(convos, startingRoute)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		dictCount += 1
		if dictCount < routeSize:
			nextLine(route[dictCount])


##ROUTES
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
	nextLine(route[dictCount])

func setRoute(dialogObj, routeName):
	route = dialogObj[routeName]
	routeSize = route.size()

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
	if "Interface" in typeDict:
		openInterface(typeDict["Interface"])


##INTERFACE
func openInterface(intfData):
	var newInterface = load(intfData["Type"]).instance()
	newInterface.connect("interfaceCreated", self, "setInterface")
	newInterface.connect("result", self, "interfaceResults")
	newInterface.init(convos[intfData["Data"]])

func setInterface(child, parentName):
	print("Interface Connected!")
	var parentNode = get_node(parentName)
	parentNode.add_child(child)

func interfaceResults(intfNode, results):
	intfNode.queue_free()
	routeStart(convos, results)
