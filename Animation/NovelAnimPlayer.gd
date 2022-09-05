extends AnimationPlayer

var spaceSpeed = false
var animSpeed = 1

signal animFinished()

func playAnimation(animation):
	self.play(animation)
	spaceSpeed = false

func soloAnimInput():
	spaceSpeed = !spaceSpeed
	if spaceSpeed:
		self.playback_speed = 3
	else:
		self.playback_speed = 1

#For SoloAnimations, need to wait until finished to move on
func _on_animation_finished(anim_name):
	self.playback_speed = 1
	emit_signal("animFinished")
