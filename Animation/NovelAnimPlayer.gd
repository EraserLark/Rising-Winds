extends AnimationPlayer

#var spaceSpeed = false
var animSpeed = 1
var runningPlayer	#Stores running animation player, whether self or in an actor

signal animFinished()

func playAnimation(animation):
	self.play(animation)
	runningPlayer = self
#	spaceSpeed = false

func actorAnimation(actor, animName):
	var actorAnimPlayer = actor.get_node("AnimationPlayer")
	actorAnimPlayer.connect("animation_finished", self, "_on_animation_finished")
	runningPlayer = actorAnimPlayer
	actor.playAnimation(animName)

func soloAnimInput(event):
	if event.is_action("ui_accept"):
		self.playback_speed = 3
	if event.is_action_released("ui_accept"):
		self.playback_speed = 1

func skipToEnd():
	if runningPlayer.current_animation:
		var end = runningPlayer.current_animation_length - runningPlayer.current_animation_position
		runningPlayer.advance(end)
		runningPlayer.stop(false)

#For SoloAnimations, need to wait until finished to move on
func _on_animation_finished(anim_name):
	self.playback_speed = 1
	
	if runningPlayer != self:
		runningPlayer.disconnect("animation_finished", self, "_on_animation_finished")
	
	emit_signal("animFinished")
	print("Animation Done!")
