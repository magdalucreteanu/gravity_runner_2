extends Node2D

# Declare member variables here. Examples:

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Level_1/Player")
	generateEnemies()

func generateEnemies():
	var rand = RandomNumberGenerator.new()
	var max_enemies = rand.randf_range(3, 5)
	var enemyScene = load("res://Enemy_1.tscn")
	for i in range(0, max_enemies):
		var enemy = enemyScene.instance()
		rand.randomize()
		var x = rand.randf_range(200, 400)
		rand.randomize()
		var y = rand.randf_range(20, 200)
		enemy.position.x = player.position.x + x * (i+1)
		enemy.position.y = y
		enemy.set_name('Enemy_'+str(x)+'_'+str(y))
		add_child(enemy)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var visible_enemies = 0;
	var enemies_list = get_tree().get_nodes_in_group("enemies")
	# wir ignorieren enemies die zu weit werg vom Player sind
	for enemy in enemies_list:
		if (abs(enemy.position.x - player.position.x) < 800
			or abs(enemy.position.y - player.position.y) < 400):
			visible_enemies += 1
	if visible_enemies == 0:
		# alle Feinde sind tot, es werden neue generiert
		generateEnemies()
