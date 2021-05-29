extends KinematicBody2D
 
const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

 
onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
 
var y_velo = 0
var facing_right = true

#func _ready():
#	var tilemap_rect = get_parent().get_node("TileMap").get_used_rect()
#	var tilemap_cell_size = get_parent().get_node("TileMap").cell_size 
#	$Camera2D.limit_left = tilemap_rect.postition.x * tilemap_cell_size.x
#	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
#	$Camera2D.limit_top = tilemap_rect.postition.y * tilemap_cell_size.y
#	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y
#	pass 


func _physics_process(_delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))

 
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
 
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
 
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
 
func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
 
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	



