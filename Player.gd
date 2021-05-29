extends KinematicBody2D

# Player variables 
const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

# Animation
onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var _animated_sprite = $PlayerAnimatedSprite
onready var _powerup_animated_sprite = $PowerUpAnimatedSprite
 
var y_velo = 0
var facing_right = true

func _ready():
	_powerup_animated_sprite.visible = false
#	var tilemap_rect = get_parent().get_node("TileMap").get_used_rect()
#	var tilemap_cell_size = get_parent().get_node("TileMap").cell_size 
#	$Camera2D.limit_left = tilemap_rect.postition.x * tilemap_cell_size.x
#	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
#	$Camera2D.limit_top = tilemap_rect.postition.y * tilemap_cell_size.y
#	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y


func _physics_process(_delta):		
	#var viewportInfo : Rect2 = get_viewport().get_visible_rect()
	var scoreLabel = get_tree().get_root().get_node("Level_1/ScoreLabel")
	var scoreText = get_tree().get_root().get_node("Level_1/ScoreText")
	scoreLabel.set_position(Vector2(position.x - 30, position.y - 80))
	scoreText.set_position(Vector2(position.x + 20, position.y - 80))
	
	var bombLabel = get_tree().get_root().get_node("Level_1/BombLabel")
	bombLabel.set_position(Vector2(position.x - 30, position.y - 100))
	
	var run_shoot_timer = get_node("BulletKinematicBody2D").get("run_shoot_timer")
	
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
		if run_shoot_timer <= 0:
			_animated_sprite.play("run")
	elif Input.is_action_pressed("move_left"):
		move_dir -= 1
		if run_shoot_timer <= 0:
			_animated_sprite.play("run")
	else:
		if run_shoot_timer <= 0:
			_animated_sprite.play("idle")
		else:
			_animated_sprite.play("idle_shoot")
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))

	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
		var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("JumpAudioStreamPlayer")
		if !audioPlayer.is_playing():
			audioPlayer.play()
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
 
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	
	#if grounded:
	#	if move_dir == 0:
	#		play_anim("idle")
	#	else:
	#		play_anim("walk")
	#else:
	#	play_anim("jump")
 
func flip():
	facing_right = !facing_right
	#sprite.flip_h = !sprite.flip_h
	_animated_sprite.flip_h = !_animated_sprite.flip_h
 
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	

func death():
# warning-ignore:return_value_discarded
	var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("DeathAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()
	yield(get_tree().create_timer(0.5), 'timeout')
	get_tree().reload_current_scene()

func power_up():
	var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("PowerUpAudioStreamPlayer")
	if !audioPlayer.is_playing():
		audioPlayer.play()
	_powerup_animated_sprite.visible = true
	_powerup_animated_sprite.play("lightning")
	
func _on_Area2D_body_entered(body):
	#if "Enemy_1" in body.name or "Enemy_2" in body.name:
	if body.name.begins_with("Enemy"):
		if _powerup_animated_sprite.visible:
			body.queue_free()
			_powerup_animated_sprite.stop()
			_powerup_animated_sprite.visible = false
		else:
			death()
	elif body.name.begins_with("Power"):
		power_up()
