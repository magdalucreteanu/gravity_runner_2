extends KinematicBody2D

# Player variables 
const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

const PORTAL_SPEED = 200
var portal_velocity = Vector2()

# Animation
onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var _animated_sprite = $PlayerAnimatedSprite
onready var _powerup_animated_sprite = $PowerUpAnimatedSprite
onready var player = get_node("AnimationPlayer")

# Camera
onready var camera = $Camera2D

var y_velo = 0
var facing_right = false
var reload_time_bullet = 0
var isAttacking = false
var attack_anim = null
var anim_numb = 1

#var attack_anim = null
#var anim_numb = 1

var blink_timer

#var state_maschine

var level_cleared = false

func set_level_cleared():
	level_cleared = true

func get_level_cleared():
	return level_cleared

func get_portal_velocity():
	portal_velocity = Vector2()
	portal_velocity.y -= 1
	portal_velocity = portal_velocity.normalized() * PORTAL_SPEED
	
func _ready():
	add_to_group("Player")
	
	
	_powerup_animated_sprite.visible = false
	
	blink_timer = Timer.new()
	blink_timer.connect("timeout", self, "_on_blink_timeout")
	add_child(blink_timer)

func _process(delta: float) -> void:
	reload_time_bullet -= delta


func _physics_process(_delta):
	var disable_movement = camera.is_boss_dead() and abs(get_position().x - 4800) < 5;
	
	if (disable_movement):
		if (get_position().y > -100):
			var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Sounds").get_node("PortalAudioStreamPlayer")
			if !audioPlayer.is_playing():
				audioPlayer.play()
			get_portal_velocity()
			portal_velocity = move_and_slide(portal_velocity)
		return
	
	#var viewportInfo : Rect2 = get_viewport().get_visible_rect()
	var scoreLabel = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/ScoreLabel")
	var scoreText = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/ScoreText")
	#var visible_rect_position = get_viewport().get_visible_rect().position
	#scoreLabel.set_position(Vector2(camera.limit_left + 30, camera.limit_top + 80))
	#scoreText.set_position(Vector2(camera.limit_left + 80, camera.limit_top + 80))	
	scoreLabel.set_position(Vector2(position.x - 30, position.y - 80))
	scoreText.set_position(Vector2(position.x + 20, position.y - 80))
	
	var bombLabel = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/BombLabel")
	bombLabel.set_position(Vector2(position.x - 30, position.y - 100))
	
	var run_shoot_timer = get_node("BulletKinematicBody2D").get("run_shoot_timer")
	
#	attack_anim = "Attack"+str(anim_numb) 
	
# warning-ignore:unused_variable
#	var current = state_maschine.get_current_node()
	var move_dir = 0
	
	
	attack_anim = "Attack"+str(anim_numb)
	
	if Input.is_action_just_pressed("left_mouse_button") and isAttacking == false:
		$Timer.set_wait_time(1)
		$Timer.start()
		do_my_animation_sequence()
		
		if $Timer.time_left > 0:
			anim_numb += 1
		
		if anim_numb == 3:
			anim_numb = 1

#	elif Input.is_action_pressed("left_mouse_button") and anim_player.current_animation == "Attack1":
#		play_anim("Attack2")



		
		
	if Input.is_action_pressed("move_right"):
		move_dir += 1
		if run_shoot_timer <= 0 and isAttacking == false:
			play_anim("Walk")
	elif Input.is_action_pressed("move_left"):
		move_dir -= 1
		if run_shoot_timer <= 0 and isAttacking == false:
			play_anim("Walk")
	else:
		if run_shoot_timer <= 0 and isAttacking == false:
			play_anim("Idle")

# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))

	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
		var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Sounds").get_node("JumpAudioStreamPlayer")
		if !audioPlayer.is_playing():
			audioPlayer.play()
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
 
	var xPlayerPosition = get_position().x
	var xMousePosition = get_global_mouse_position().x
	var playerLooksRight = (xPlayerPosition <= xMousePosition)
	
	if facing_right and !playerLooksRight:
		flip()
	if !facing_right and playerLooksRight:
		flip()
	
	#if grounded:
	#	if move_dir == 0:
	#		play_anim("idle")
	#	else:
	#		play_anim("walk")
	#else:
	#	play_anim("jump")
 
func do_my_animation_sequence():
	isAttacking = true
	play_anim(attack_anim)
	yield($AnimationPlayer, "animation_finished")
	isAttacking = false

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
#	_animated_sprite.flip_h = !_animated_sprite.flip_h
 
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	

func death():
# warning-ignore:return_value_discarded
	var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Sounds").get_node("DeathAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()
	start_blinking(0.05)
	yield(get_tree().create_timer(0.5), 'timeout')
	get_tree().reload_current_scene()

func power_up():
	var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Sounds").get_node("PowerUpAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()
	_powerup_animated_sprite.visible = true
	_powerup_animated_sprite.play("lightning")
	
func _on_Area2D_body_entered(body):
	#if "Enemy_1" in body.name or "Enemy_2" in body.name:
	if body.name.begins_with("Enemy"):
		if _powerup_animated_sprite.visible:
			var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Sounds").get_node("EnemyDeathAudioStreamPlayer")
			if !audioPlayer.is_playing():
				audioPlayer.play()
			body.queue_free()
			_powerup_animated_sprite.stop()
			_powerup_animated_sprite.visible = false
		else:
			death()
	elif body.name.begins_with("Power"):
		body.queue_free()
		power_up()

func _on_blink_timeout():
	if is_visible():
		hide()
	else:
		show()
		
func start_blinking(interval):
	blink_timer.set_wait_time(interval)
	blink_timer.start()

func stop_blinking():
	show()
	blink_timer.stop()

#onready var Player = get_node("AnimationPlayer")
#
#func do_my_animation_sequence():
#	Player.play("Attack1")
#	yield(get_node("AnimationPlayer"), "animation_finished")
#	Player.play("Attack2")
#	yield(get_node("AnimationPlayer"), "animation_finished")
#	Player.play("Idle")
#
#func playNextAnim():
#	if(Player.get_current_animation() == "Attack1"):
#		Player.play("Attack2")

func _on_Timer_timeout():
	anim_numb = 1






func _on_AnimationPlayer_animation_finished(anim_name):
	#print("Test1")
	pass




