extends Control

onready var centerContainer = $CenterContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel
#signal choice_selected(answer)

func _ready():
	pass

##Creates new buttons corresponding to the choice data sent in
#func newChoice(choices, TBshow):
#	#var choiceButtons = centerContainer.get_child(0)
#
#	#clearChoices(choiceButtons)
#	#buttonReveal(true)
#	textboxReveal(TBshow)
#
#	for choice in choices:
#	#for each 'object' in 'array'
#		var button = Button.new()
#		var choiceText = choice["Text"]
#		var choiceRoute = choice["Route"]
#		button.text = choiceText
#		button.connect("pressed", self, "_button_pressed", [choiceRoute])
#		#choiceButtons.add_child(button)

##Runs when the signal "pressed" is emitted by a button
#func _button_pressed(chosenRoute):
#	textboxReveal(true)
#	#buttonReveal(false)
#	emit_signal("choice_selected", chosenRoute)

##Removes all old buttons from last choice
#func clearChoices(prevChoiceButtons):
#	for n in prevChoiceButtons.get_children():
#		prevChoiceButtons.remove_child(n)
#		n.queue_free()
#		#Disconnect button signals? (Online says they disconnect automatically)

func changeName(name):
	nameLabel.text = name

func changeText(newText : String):
	textBox.text = newText

func textboxReveal(condition):
	textPanel.visible = condition

#func buttonReveal(condition):
#	choiceButtons.visible = condition
