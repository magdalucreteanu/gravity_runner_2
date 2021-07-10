extends RigidBody2D


onready var _animated_sprite = $AnimatedSprite
const MOVE_SPEED = 300
var y_velo = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	_animated_sprite.play("PlasmaShuffle")

func _physics_process(_delta):
	var move_dir = -1
	set_linear_velocity(Vector2(move_dir * MOVE_SPEED, y_velo))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_EnemyPlasmaArea_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()


func _on_Enemy_3_Plasma_Bomb_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
