extends Node2D

# Declare member variables here. Examples:

var player
var enemy3

var respawn_time_enemies = 0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Player")
	enemy3 = get_tree().get_root().get_node("SceneManager/Main/Viewport").get_node("Level_1/Enemy_3")

func generateGroundEnemies():
	if player.get_level_cleared():
		return
		
	var rand = RandomNumberGenerator.new()
	var max_enemies = rand.randi_range(2, 4)
	var enemyScene = load("res://Enemy_1.tscn")
	#max_enemies = 0
	for i in range(0, max_enemies):
		var enemy = enemyScene.instance()
		rand.randomize()
		var x = rand.randi_range(300, 800)
		rand.randomize()
		var y = rand.randi_range(20, 200)
		enemy.position.x = player.position.x + x * (i+1)
		enemy.position.y = y
		enemy.set_name('Enemy_'+str(x)+'_'+str(y))
		add_child(enemy)
		
func generateFlyingEnemies():
	if player.get_level_cleared():
		return
		
	var rand = RandomNumberGenerator.new()
	var max_enemies = 3
	var enemyScene2 = load("res://Enemy_2.tscn")
	#max_enemies = 0
	for i in range(0, max_enemies):
		var enemy2 = enemyScene2.instance()
		rand.randomize()
		var x = rand.randi_range(300, 800)
		rand.randomize()
		var y = rand.randi_range(70, 110)
		enemy2.position.x = player.position.x + x * (i+1)
		enemy2.position.y = y
		enemy2.set_name('Enemy_2_'+str(x)+'_'+str(y))
		add_child(enemy2)
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	respawn_time_enemies -= delta
	
	if respawn_time_enemies < 0:
		respawn_time_enemies = 10
		# mehr Gegner
		generateGroundEnemies()
		generateFlyingEnemies()
	#var visible_enemies = 0;
	#var enemies_list = get_tree().get_nodes_in_group("enemies")
	# wir ignorieren enemies die zu weit werg vom Player sind
	#for enemy in enemies_list:
	#	if (abs(enemy.position.x - player.position.x) < 400
	#		or abs(enemy.position.y - player.position.y) < 200):
	#		visible_enemies += 1
	#if visible_enemies < 3:
	#	# alle Feinde sind tot, es werden neue generiert
	#	generateEnemies()
