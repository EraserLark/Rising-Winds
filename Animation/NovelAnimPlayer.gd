extends AnimationPlayer

#var spaceSpeed = false
var animSpeed = 1

signal animFinished()

func playAnimation(animation):
	self.play(animation)
#	spaceSpeed = false

func soloAnimInput(event):
	if event.is_action("ui_accept"):
		self.playback_speed = 3
	if event.is_action_released("ui_accept"):
		self.playback_speed = 1

#For SoloAnimations, need to wait until finished to move on
func _on_animation_finished(anim_name):
	self.playback_speed = 1
	emit_signal("animFinished")

func skipToEnd():
	if self.current_animation:
		var end = self.current_animation_length - self.current_animation_position
		self.advance(end)
		self.stop(false)

#func dialogueFin():
#	self.advance(1000)
#	pass
