extends AnimationPlayer

func playAnimation(animation):
	self.play(animation)

#For SoloAnimations, need to wait until finished to move on
func _on_animation_finished(anim_name):
	pass # Replace with function body.
