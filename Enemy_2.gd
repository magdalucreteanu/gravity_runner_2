extends KinematicBody2D

const MOVE_SPEED = 100

var lives = 2
var is_hit_by_bomb = false;
var y_velo = 0
var facing_right = true

var screenSize
var player
var rotatorSprite

onready var anim_player = get_node("AnimationPlayer")
onready var effect_player = get_node("AnimationPlayer2")

func _ready():
	player = get_tree().get_root().get_node("Level_1/Player")
	add_to_group("enemies")
	screenSize = get_viewport().get_visible_rect().size
	rotatorSprite = get_node("Rotator")
	rotatorSprite.visible = false

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)

func play_effect_anim(effect_name):
	if effect_player.is_playing() and effect_player.current_animation == effect_name:
		return
	effect_player.play(effect_name)
	

func _on_EnemyArea_body_entered(body):
	if "WallLeft" in body.name:
		queue_free()
	if "PlatformUp" in body.name:
		position.y -= 50
	if "Bullet" in body.name:
		var audioPlayer = get_tree().get_root().get_node("Level_1/Sounds").get_node("DamageAudioStreamPlayer")
		if !audioPlayer.is_playing():
			audioPlayer.play()
		lives -= 1
		var scoreText = get_tree().get_root().get_node("Level_1/ScoreText")
		var score = int(scoreText.get_text())
		score += 1
		scoreText.set_text(str(score))
		if (lives == 0):
			queue_free()
	while "GravityArea" in body.name:
		is_hit_by_bomb = true
		rotatorSprite.visible = true
		var scoreText = get_tree().get_root().get_node("Level_1/ScoreText")
		var score = int(scoreText.get_text())
		score += 20
		scoreText.set_text(str(score))
		break

func _on_EnemyArea_body_exited(body):
	if "GravityArea" in body.name:
		is_hit_by_bomb = false
		rotatorSprite.visible = false
		
func _physics_process(_delta):
	play_anim("Flying")
	if (is_hit_by_bomb):
		play_effect_anim("Rotator")
		var move_dir = -0.50
		# warning-ignore:return_value_discarded
		move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	else:
		var move_dir = -1.25
		# warning-ignore:return_value_discarded
		move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))










