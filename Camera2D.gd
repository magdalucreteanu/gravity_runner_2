extends Camera2D

var shaking = false
var boss_dead = false

var decay = 0.8  # How quickly the shaking stops [0, 1].

var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.

var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var player  # Assign the node this camera will follow.


var trauma = 1.0  # Current shake strength.

var trauma_power = 2  # Trauma exponent. Use [2, 3].

var wait_start_end_music = 2

var portalAnimationSprite

func set_shaking(value):
	shaking = value

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func is_boss_dead():
	return boss_dead

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Player")

	portalAnimationSprite = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/PortalAnimatedSprite")
	portalAnimationSprite.visible = false

	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shaking:
		global_position = player.global_position
		if trauma:
			var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Sounds").get_node("EndExplosionAudioStreamPlayer")
			if !audioPlayer.is_playing():
				audioPlayer.play()
			trauma = max(trauma - decay * delta, 0)
			shake()
			boss_dead = true
	if boss_dead:
		var audioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Player").get_node("AudioStreamPlayer")
		audioPlayer.stop()
		wait_start_end_music -= delta
		if wait_start_end_music < 0:
			portalAnimationSprite.visible = true
			portalAnimationSprite.play("default")
			var endGameAudioPlayer = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Player").get_node("EndGameAudioStreamPlayer")
			if !endGameAudioPlayer.is_playing():
				endGameAudioPlayer.play()


func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
