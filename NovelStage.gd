extends Node

onready var novInterface = $NovelInterface

onready var actor0 = $Actor0
onready var actor1 = $Actor1
onready var actor2 = $Actor2
onready var animPlayer = $AnimationPlayer
var actorArray

export (String) var jsonDict
var convos

var dictCount : int = 0
var route
var routeSize = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	convos = loadDialogueFile(jsonDict)
	novInterface.connect("choice_selected", self, "nextChoice")
	
	route = convos["masterDict"]
	routeStart(route)

func routeStart(_route):
	novInterface.buttonReveal(false)	#Hide buttons
	
	actorArray = [actor0, actor1, actor2]
	
	routeSize = _route.size()
	nextLine(_route[dictCount])

#https://www.youtube.com/watch?v=8HOmLNuuccs&t=178s
func loadDialogueFile(file_path):
	var file = File.new()
	assert(file.file_exists(file_path))
	
	file.open(file_path, file.READ)
	var convos = parse_json(file.get_as_text())
	assert(convos.size() > 0)
	return convos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		dictCount += 1
		if dictCount < routeSize:
			nextLine(route[dictCount])
		else:
			novInterface.textboxReveal(false)
			novInterface.buttonReveal(true)
			novInterface.newChoice(convos["choiceDict"])

func nextLine(dict):
	var actor = actorArray[dict["Actor"]]
	actor.changeFace(dict["Face"])
	if dict["Anim"] != null:
		#actor.playAnimation(dict["Anim"])
		animPlayer.play(dict["Anim"])
	novInterface.changeName(dict["Name"])
	novInterface.changeText(dict["Dialogue"])

func nextChoice(nextRoute):
	route = convos[nextRoute]
	dictCount = 0
	routeStart(route)
