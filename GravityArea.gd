extends KinematicBody2D


onready var timer = get_node("Timer")
onready var anim_player = $AnimationPlayer

#signal is_in_GravityPulse

func _ready():
	timer.set_wait_time(5)
	timer.start()
	play_anim("GravityPulse")
	
#	"Data structure: Name of animation : [animation frame, collision shape node (can be used for multiple frames!)]" 
#	ANIMATION_FRAMES = { "Idle_01":
#		[0, get_node("animation_collision_shapes/GravityStart/shape_01")], "Idle_02":[1, get_node("animation_collision_shapes/idle/shape_01")], "Idle_03":
#			[2, get_node("animation_collision_shapes/idle/shape_02")], "Attack_01":[3, get_node("animation_collision_shapes/attack/shape_01")], "Attack_02":
#				[4, get_node("animation_collision_shapes/attack/shape_02")], } 
#	current_animation_frame = "Idle_01" 
				

func _on_Timer_timeout():
	queue_free()
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)




				
#func change_animation(animation_name): 
#	" Check to see if we need to disable a old collision shape... " 
#	if (current_animation_frame != null):
#		"Disable the old collision shape" 
#		ANIMATION_FRAMES[current_animation_frame][1].disabled = true 
#		" Enable the new collision shape " 
#		ANIMATION_FRAMES[animation_name][1].disabled = false 
#		" Change the sprite's animation " 
#		get_node("sprite").frame = ANIMATION_FRAMES[animation_name][0] 
#		" Update current_animation_frame so we can disable the collision shape when the animation changes" 
#		current_animation_frame = animation_name



	



