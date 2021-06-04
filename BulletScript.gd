extends RigidBody2D

onready var anim_player = $AnimationPlayer

func _ready():
	play_anim("Shooting")


func _on_Bullet_body_entered(body):
	if !body.is_in_group("Player"):
		queue_free()

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
