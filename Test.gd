extends KinematicBody2D


onready var anim_player = $AnimationPlayer
var isAttacking = false
var attack_anim = null
var anim_numb = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	anim_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	
func _physics_process(_delta):
	attack_anim = "AttackC"+str(anim_numb)
	
	if Input.is_action_just_pressed("left_mouse_button") and isAttacking == false:
		$Timer.set_wait_time(1)
		$Timer.start()
		do_my_animation_sequence()
		
		if $Timer.time_left > 0:
			anim_numb += 1
		
		if anim_numb == 3:
			anim_numb = 1

		
		
		
#	elif anim_player.current_animation != "AttackC2" or "AttackC1":
#		yield($AnimationPlayer, "animation_finished")
#		play_anim("Idle")
#		play_anim("AttackC1")
#		yield($AnimationPlayer, "animation_finished")
		
func do_my_animation_sequence():
	isAttacking = true
	play_anim(attack_anim)
	yield($AnimationPlayer, "animation_finished")
	isAttacking = false


#	play_anim("AttackC1")
#	yield($AnimationPlayer, "animation_finished")
#	if Input.is_action_pressed("left_mouse_button"):
#		play_anim("AttackC2")
		
#	yield($AnimationPlayer, "animation_finished")
#	play_anim("Idle")
#
#func playNextAnim():
#	if($AnimationPlayer.get_current_animation() == "AttackC1"):
#		play_anim("Attack2")
	
#	if Input.is_action_pressed("left_mouse_button"):
#		play_anim("Attackb1") 

#func _on_AnimatedSprite_animation_finished():
#	print("Animation Finished")
	
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)


func _on_AnimationPlayer_animation_finished(anim_name):
	print("Animation finished")
#	if anim_name == "AttackC1" and isAttacking == true:
#		play_anim("AttackC2")
#
#	if anim_name == "AttackC2" and isAttacking == true:
#		play_anim("AttackC1")


		



#func _on_AnimatedSprite_animation_finished():
#	print("Test")
#	if animated_sprite == "Attackb1":
#		animated_sprite.play("Attackb2")
#	if animated_sprite == "Attackb2":
#		animated_sprite.play("Attackb1")


func _on_Timer_timeout():
	anim_numb = 1
	play_anim("Idle")
