extends VBoxContainer

var parentAddress = "NovelInterface/CenterContainer"

signal interfaceCreated(nodeSelf, desiredParent)
signal result(nodeSelf, answer)

func init(choices):
	emit_signal("interfaceCreated", self, parentAddress)
	
	clearChoices()
	
	for choice in choices:
	#for each 'object' in 'array'
		var button = Button.new()
		var choiceText = choice["Text"]
		var choiceRoute = choice["Route"]
		button.text = choiceText
		button.connect("pressed", self, "_button_pressed", [choiceRoute])
		add_child(button)

func _button_pressed(chosenRoute):
#	textboxReveal(true)
#	buttonReveal(false)
	emit_signal("result", self, chosenRoute)

func clearChoices():
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
