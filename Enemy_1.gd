extends KinematicBody2D

const MOVE_SPEED = 100
const GRAVITY = 20
const MAX_FALL_SPEED = 1000
const MAX_FLIGHT_SPEED = -100

var lives = 3

var is_hit = false;

var y_velo = 0
var facing_right = true

var screenSize

func _ready():
	screenSize = get_viewport().get_visible_rect().size
	
func _physics_process(_delta):
	if (is_hit):
		if position.y < 20:
		  position.y = 20
		move_and_slide(Vector2(0, y_velo), Vector2(0, -1))
		y_velo -= GRAVITY
		if y_velo < MAX_FLIGHT_SPEED:
			y_velo = MAX_FLIGHT_SPEED
	else:
		var move_dir = -1
	# warning-ignore:return_value_discarded
		move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
		var grounded = is_on_floor()
		y_velo += GRAVITY
		if grounded and y_velo >= 5:
			y_velo = 5
		if y_velo > MAX_FALL_SPEED:
			y_velo = MAX_FALL_SPEED
			

func _on_EnemyArea_body_entered(body):
	if "Bullet" in body.name:
		lives -= 1
		var scoreText = get_tree().get_root().get_node("Level_1/ScoreText")
		var score = int(scoreText.get_text())
		score += 1
		scoreText.set_text(str(score))
		if (lives == 0):
			queue_free()
	if "GravityArea" in body.name:
		is_hit = true
		var scoreText = get_tree().get_root().get_node("Level_1/ScoreText")
		var score = int(scoreText.get_text())
		score += 10
		scoreText.set_text(str(score))
		#queue_free()
