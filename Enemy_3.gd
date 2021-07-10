extends KinematicBody2D

const Rocket = preload("res://Enemy_3_Rocket.tscn")
const Plasma = preload("res://Enemy_3_Plasma_Bomb.tscn")
const Rocket_speed = -500
const Plasma_speed = -250

var isAttacking = false

onready var anim_player = get_node("AnimationPlayer")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	
func player_in_range():
	return false

func _process(delta: float) -> void:
	if (!player_in_range()):
		return
	
	if Input.is_action_just_pressed("left_mouse_button"):
		isAttacking = true
		$Timer2.set_wait_time(1)
		$Timer2.start()
		play_anim("Trigger")
		yield($AnimationPlayer, "animation_finished")
		play_anim("Fire Rocket")
		yield($AnimationPlayer, "animation_finished")
		isAttacking = false
		
	if Input.is_action_just_pressed("right_mouse_button"):
		isAttacking = true
		$Timer.set_wait_time(1.25)
		$Timer.start()
		play_anim("Trigger")
		yield($AnimationPlayer, "animation_finished")
		play_anim("Fire Bomb")
		yield($AnimationPlayer, "animation_finished")
		isAttacking = false
		
	elif isAttacking == false:
		play_anim("Idle")

func fire_Enemy_3_Rocket():
	var Rocket_instance = Rocket.instance()
	var Rocket2_instance = Rocket.instance()
	Rocket_instance.position = $RocketPoint.get_global_position()
	Rocket2_instance.position = $RocketPoint2.get_global_position()
	Rocket_instance.rotation_degrees = rotation_degrees
	Rocket_instance.apply_impulse(Vector2(),Vector2(Rocket_speed, 0).rotated(rotation))
	Rocket2_instance.rotation_degrees = rotation_degrees
	Rocket2_instance.apply_impulse(Vector2(),Vector2(Rocket_speed, 0).rotated(rotation))
	get_tree().get_root().get_node("SceneManager/Main/Viewport").call_deferred("add_child", Rocket_instance)
	get_tree().get_root().get_node("SceneManager/Main/Viewport").call_deferred("add_child", Rocket2_instance)
	
func fire_Enemy_3_Plasma_Bomb():
	var Plasma_instance = Plasma.instance()
	var Plasma2_instance = Plasma.instance()
	Plasma_instance.position = $PlasmaBombPoint.get_global_position()
	Plasma2_instance.position = $PlasmaBombPoint2.get_global_position()
	Plasma_instance.apply_impulse(Vector2(),Vector2(Plasma_speed, 0).rotated(rotation))
	Plasma2_instance.apply_impulse(Vector2(),Vector2(Plasma_speed, 0).rotated(rotation))
	get_tree().get_root().get_node("SceneManager/Main/Viewport").call_deferred("add_child", Plasma_instance)
	get_tree().get_root().get_node("SceneManager/Main/Viewport").call_deferred("add_child", Plasma2_instance)


func _on_Timer_timeout():
	fire_Enemy_3_Plasma_Bomb()


func _on_Timer2_timeout():
	fire_Enemy_3_Rocket()



