extends KinematicBody2D

const bullet_speed = 2000
var reload_time_bullet = 0
const bullet = preload("res://Bullet.tscn")

const bomb_speed = 5
var reload_time_bomb = 0
const bomb = preload("res://Bomb.tscn")

func _process(delta: float) -> void:
	reload_time_bullet -= delta
	if Input.is_action_pressed("left_mouse_button") and reload_time_bullet < 0:
		reload_time_bullet = 0.3
		fire()
	
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
		reload_time_bomb = 5
		fire_bomb()
			
		
	look_at(get_global_mouse_position())
	

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	# Bullet Sound
	var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("BulletAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()
	
func fire_bomb():
	var bomb_instance = bomb.instance()
	bomb_instance.position = $BulletPoint.get_global_position()
	bomb_instance.rotation_degrees = rotation_degrees
	var distanceToMouse = bomb_instance.position.distance_to(get_global_mouse_position()) 
	bomb_instance.apply_impulse(Vector2(),Vector2(bomb_speed * distanceToMouse, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bomb_instance)
	# Bomb Sound
	var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("BombAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()







