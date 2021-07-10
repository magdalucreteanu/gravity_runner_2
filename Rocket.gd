extends RigidBody2D

onready var sprite = $Sprite
onready var _animated_sprite = $AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	_animated_sprite.play("RocketSmoke")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rocket_body_entered(body):
	#if !body.is_in_group("enemies"):
	#	queue_free()
	pass

func _on_EnemyRocketArea_body_entered(body):
	#if !body.is_in_group("enemies"):
	#	queue_free()
	pass
