extends KinematicBody2D

# Bullet variables
const bullet_speed = 2000
var reload_time_bullet = 0
const bullet = preload("res://Bullet.tscn")

# Bomb variables
const bomb_speed = 7
var reload_time_bomb = 0
const bomb = preload("res://Bomb.tscn")
const max_bomb_speed = 1100

var _animated_sprite

# Run shoot animation timer 
var run_shoot_timer = 0

func _ready():
	_animated_sprite = get_tree().get_root().get_node("Level_1/Player").get_node("PlayerAnimatedSprite")

func _process(delta: float) -> void:
	reload_time_bullet -= delta
	run_shoot_timer -= delta
	
	if Input.is_action_pressed("left_mouse_button") and reload_time_bullet < 0:
		reload_time_bullet = 0.3
		run_shoot_timer = 0.5
		fire_bullet()
	
	var bombLabel = get_tree().get_root().get_node("Level_1/BombLabel")
	reload_time_bomb -= delta
	if reload_time_bomb < 0:
		if (bombLabel.text == ""):
			var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("BombReadyAudioStreamPlayer")
			if !audioPlayer.is_playing():
				audioPlayer.play()
		bombLabel.set_text("BOMB READY!")
	else:
		bombLabel.set_text("")
	
	if Input.is_action_pressed("right_mouse_button") and reload_time_bomb < 0:
		reload_time_bomb = 6
		fire_bomb()
			
		
	look_at(get_global_mouse_position())
	

func fire_bullet():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	# Run Shoot animation
	_animated_sprite.play("run_shoot")
	# Bullet Sound
	var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("BulletAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()
	
func fire_bomb():
	var bomb_instance = bomb.instance()
	bomb_instance.position = $BulletPoint.get_global_position()
	bomb_instance.rotation_degrees = rotation_degrees
	var distanceToMouse = bomb_instance.position.distance_to(get_global_mouse_position())
	if  bomb_speed * distanceToMouse < max_bomb_speed:
		bomb_instance.apply_impulse(Vector2(),Vector2(bomb_speed * distanceToMouse, 0).rotated(rotation))
	else:
		bomb_instance.apply_impulse(Vector2(),Vector2(max_bomb_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bomb_instance)
	# Bomb Sound
	var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("BombAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()







