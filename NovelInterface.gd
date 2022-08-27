extends Control

onready var choiceButtons = $CenterContainer/VBoxContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel
signal choice_selected(answer)

func _ready():
	pass

#Creates new buttons corresponding to the choice data sent in
func newChoice(choices):
	clearChoices()
	for i in choices:
		var button = Button.new()
		var choiceText = choices[i]["Text"]
		var choiceRoute = choices[i]["Route"]
		button.text = choiceText
		button.connect("pressed", self, "_button_pressed", [choiceRoute])
		choiceButtons.add_child(button)

func _button_pressed(chosenRoute):
	textboxReveal(true)
	buttonReveal(false)
	emit_signal("choice_selected", chosenRoute)

#Removes all old buttons from last choice
func clearChoices():
	for n in choiceButtons.get_children():
		choiceButtons.remove_child(n)
		n.queue_free()

func changeName(name):
	nameLabel.text = name

func changeText(newText):
	textBox.text = newText

func textboxReveal(condition):
	textPanel.visible = condition

func buttonReveal(condition):
	choiceButtons.visible = condition
