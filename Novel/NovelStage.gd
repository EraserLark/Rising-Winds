extends Node

onready var novInterface = $NovelInterface
onready var cast = $Cast
onready var animPlayer = $NovelAnimPlayer

export (String) var jsonDialogue
var convos

var dictCount : int = 0
var route
var routeSize = 0

enum StageState {NEXTLINE, DIALOGUE, SOLOANIM, INTERFACE}
var currentState

##BASE FUNCTIONS
func _ready():
	currentState = StageState.NEXTLINE
	animPlayer.connect("animFinished", self, "soloAnimFin")
	
	convos = loadJSONFile(jsonDialogue)
	var startingCast = convos["chapterStart"]["startingCast"]
	var startingRoute = convos["chapterStart"]["startingRoute"]
	
	cast.updateCast(startingCast)
	routeStart(convos, startingRoute)

#Alternate way for inputs??
func _input(event):
	if event.is_action_pressed("ui_accept"):
		match currentState:
			StageState.NEXTLINE:
				advance()
			StageState.DIALOGUE:
				pass	#Will replace once typewriter effect is set up
			StageState.SOLOANIM:
				animPlayer.soloAnimInput()
			StageState.INTERFACE:
				pass	#Leave as 'pass', don't want input when interface is open


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
	currentState = StageState.NEXTLINE
	setRoute(dialogueObj, routeName)	
	nextLine(route[dictCount])

func setRoute(dialogObj, routeName):
	route = dialogObj[routeName]
	routeSize = route.size()

func advance():
	dictCount += 1
	if dictCount < routeSize:
		nextLine(route[dictCount])

func nextLine(typeDict):
	if "Dialogue" in typeDict:
#		currentState = StageState.DIALOGUE
		var dict = typeDict["Dialogue"]
		#ACTOR
		var actor = cast.actorArray[dict["Actor"]]
		actor.changeFace(dict["Face"])
		#ANIMATION - ConcurrentAnim
		if dict["Anim"] != null:
			animPlayer.playAnimation(dict["Anim"])
		#DIALOGUE
		novInterface.changeName(dict["Name"])
		novInterface.changeText(dict["Dialogue"])
	#SoloAnim
	if "Animation" in typeDict:
		currentState = StageState.SOLOANIM
		var dict = typeDict["Animation"]
		var actor = cast.actorArray[dict["Actor"]]
		animPlayer.playAnimation(dict["Anim"])
		novInterface.changeText("")
	if "Interface" in typeDict:
		currentState = StageState.INTERFACE
		openInterface(typeDict["Interface"])


##ANIMATION
func soloAnimFin():
	currentState = StageState.NEXTLINE	#Needed now, will remove after dialogue is set up
	advance()

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
