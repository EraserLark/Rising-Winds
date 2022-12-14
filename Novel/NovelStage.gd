extends Node

onready var novInterface = $NovelInterface
onready var cast = $Cast
onready var animPlayer = $NovelAnimPlayer

export (String) var jsonDialogue
var chData

var dictCount : int = 0
var route
var routeSize = 0

enum StageState {NEXTLINE, DIALOGUE, SOLOANIM, INTERFACE}
var currentState

##BASE FUNCTIONS
func _ready():
	currentState = StageState.NEXTLINE
	animPlayer.connect("animFinished", self, "soloAnimFin")
	novInterface.connect("phraseFin", self, "dialogueFin")
	
	chData = loadJSONFile(jsonDialogue)
	var startingCast = chData["chapterStart"]["startingCast"]
	var startingRoute = chData["chapterStart"]["startingRoute"]
	
	cast.updateCast(startingCast)
	routeStart(chData, startingRoute)

func _input(event):
	match currentState:
		StageState.NEXTLINE:
			if event.is_action_pressed("ui_accept"):
				advance()
		StageState.DIALOGUE:
			novInterface.dialogueInput(event)
		StageState.SOLOANIM:
			animPlayer.soloAnimInput(event)
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
	if "D" in typeDict:
		currentState = StageState.DIALOGUE
		var dict = typeDict["D"]
		#- - - - ACTOR - - - -
#		var actor = cast.actorArray[dict["Actor"]]
		var actor = cast.castList[dict["Actor"]]
		actor.exprFace = dict["Face"]
		if dict.has("Pose"):
			actor.exprPose = dict["Pose"]
		#- - - - ANIMATION - ConcurrentAnim - - - -
		if dict.has("Anim"):
			animPlayer.determineAnimType(actor, dict["Anim"])
		#- - - - DIALOGUE - - - -
		novInterface.changeName(actor.actorName)
		novInterface.typeText(dict["Dialogue"])
	#SoloAnimation
	elif "SA" in typeDict:
		currentState = StageState.SOLOANIM
		var dict = typeDict["SA"]
#		var actor = cast.actorArray[dict["Actor"]]
		#Can instead do 'determineAnimType()' here, in case a soloAnim uses only an Actor's animation?
		animPlayer.playAnimation(dict["Anim"])
		novInterface.showTextbox(false)
	elif "I" in typeDict:
		currentState = StageState.INTERFACE
		novInterface.showTextbox(false)
		openInterface(typeDict["I"])


##DIALOGUE
func dialogueFin():
	animPlayer.skipToEnd()	#If any concurrentAnimations are still running, skip them to the end before advancing
	currentState = StageState.NEXTLINE

##ANIMATION
func soloAnimFin():
	if currentState == StageState.SOLOANIM:	#Prevents ConcurrentAnims from triggering advance()
		advance()

##INTERFACE
func openInterface(intfData):
	var newInterface = load(intfData["Type"]).instance()
	newInterface.connect("interfaceCreated", self, "setInterface")
	newInterface.connect("result", self, "interfaceResults")
	newInterface.init(chData[intfData["Data"]])

func setInterface(child, parentName):
	print("Interface Connected!")
	var parentNode = get_node(parentName)
	parentNode.add_child(child)

func interfaceResults(intfNode, results):
	intfNode.queue_free()
	routeStart(chData, results)
