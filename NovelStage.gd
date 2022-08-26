extends Node

onready var novInterface = $NovelInterface

onready var actor0 = $Actor0
onready var actor1 = $Actor1
onready var actor2 = $Actor2
var actorArray

#Dialogue Dictionary Test
onready var masterDict = {
1: {"Actor": 0, "Name": actor0.actorName, 	"Face": "Happy", 	"Dialogue": "Howdy howdy.", "Anim": null},
2: {"Actor": 1, "Name": actor1.actorName, 	"Face": "Angry", 	"Dialogue": "Who are you?", "Anim": null},
3: {"Actor": 0, "Name": actor0.actorName,	"Face": "Normal", 	"Dialogue": "Sorry to bother you, name's " + actor0.actorName, "Anim": null},
4: {"Actor": 1, "Name": actor1.actorName, 	"Face": "Sad", 		"Dialogue": "No worries. Been a long day.", "Anim": null },
5: {"Actor": 2, "Name": actor2.actorName, 	"Face": "Happy", 	"Dialogue": "Hee hee! I'm here too!", "Anim": "MoveIn"}
}
var dictCount : int = 1
var masterDictSize = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	novInterface.buttonReveal(false)	#Hide buttons
	
	actorArray = [actor0, actor1, actor2]
	
	masterDictSize = masterDict.size()
	nextLine(masterDict[dictCount])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if dictCount < masterDictSize:
			dictCount += 1
			nextLine(masterDict[dictCount])
		else:
			novInterface.textboxReveal(false)
			novInterface.buttonReveal(true)

func nextLine(dict):
	var actor = actorArray[dict["Actor"]]
	actor.changeFace(dict["Face"])
	if dict["Anim"] != null:
		actor.playAnimation(dict["Anim"])
	novInterface.changeName(dict["Name"])
	novInterface.changeText(dict["Dialogue"])

#Signal disconnected, moved script
#func _on_Button_pressed():
#	changeText("Button Pressed!")
