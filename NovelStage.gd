extends Node

onready var novInterface = $NovelInterface

onready var actor0 = $Actor0
onready var actor1 = $Actor1
onready var actor2 = $Actor2
onready var animPlayer = $AnimationPlayer
var actorArray

#Dialogue Dictionary Test
onready var masterDict = {
1: {"Actor": 0, "Name": actor0.actorName, 	"Face": "Happy", 	"Dialogue": "Howdy howdy.", "Anim": null},
2: {"Actor": 1, "Name": actor1.actorName, 	"Face": "Angry", 	"Dialogue": "Who are you?", "Anim": null},
3: {"Actor": 0, "Name": actor0.actorName,	"Face": "Normal", 	"Dialogue": "Sorry to bother you, name's " + actor0.actorName, "Anim": null},
4: {"Actor": 1, "Name": actor1.actorName, 	"Face": "Sad", 		"Dialogue": "No worries. Been a long day.", "Anim": null },
5: {"Actor": 2, "Name": actor2.actorName, 	"Face": "Happy", 	"Dialogue": "Hee hee! I'm here too!", "Anim": "testPeekDown"}
}
var dictCount : int = 1
var route
var routeSize = 0

onready var jimmyDict = {
1: {"Actor": 2, "Name": actor2.actorName, 	"Face": "Happy", 	"Dialogue": "That's my name! Don't wear it out!", "Anim": null},
2: {"Actor": 1, "Name": actor1.actorName, 	"Face": "Angry", 	"Dialogue": "Get off the ceiling!", "Anim": null},
3: {"Actor": 0, "Name": actor0.actorName,	"Face": "Normal", 	"Dialogue": "Now, now " + actor1.actorName + ". It's okay to have fun.", "Anim": null}
}

#Choice Dictionary Test
onready var choiceDict = {
0: {"Text": actor0.actorName, "Route": masterDict},
1: {"Text": actor1.actorName, "Route": masterDict},
2: {"Text": actor2.actorName, "Route": jimmyDict}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	novInterface.connect("choice_selected", self, "nextChoice")
	
	route = masterDict
	routeStart(route)

func routeStart(_route):
	novInterface.buttonReveal(false)	#Hide buttons
	
	actorArray = [actor0, actor1, actor2]
	
	routeSize = _route.size()
	nextLine(_route[dictCount])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if dictCount < routeSize:
			dictCount += 1
			nextLine(route[dictCount])
		else:
			novInterface.textboxReveal(false)
			novInterface.buttonReveal(true)
			novInterface.newChoice(choiceDict)

func nextLine(dict):
	var actor = actorArray[dict["Actor"]]
	actor.changeFace(dict["Face"])
	if dict["Anim"] != null:
		#actor.playAnimation(dict["Anim"])
		animPlayer.play(dict["Anim"])
	novInterface.changeName(dict["Name"])
	novInterface.changeText(dict["Dialogue"])

func nextChoice(nextRoute):
	route = nextRoute
	dictCount = 1
	routeStart(nextRoute)

#Signal disconnected, moved script
#func _on_Button_pressed():
#	changeText("Button Pressed!")
