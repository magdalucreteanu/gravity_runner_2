extends RigidBody2D

const G_Area = preload("res://GravityArea.tscn")

func _on_Bomb_body_entered(body):
	if !body.is_in_group("Player"):
	#	var G_Area_instance = G_Area.instance()
	#	G_Area_instance.position = body.position
	#	get_tree().get_root().call_deferred("add_child", G_Area_instance)
		queue_free()
		
#func launch(target_position):
#
#	var temp = global_transform
#	var scnene = get_tree().current_scene
#	get_parent().remove_child(self)
#	scene.add_child(self)
#	global_transform = temp
#
#	var arc_height = target_position.y - global_position.y - 32
#	arc_height = min(arc_height, - 32)
#	velocity = PhysicsHelper.calculate_arc_velocity(global_position, target_position, arc_height)
#	velocity = velocity.clamped(1000)
#
#	set_physics_process(true)
#	$DamageArea.monitoring = true
#
#func _on_impact(normal : Vector2):
#	velocity = velocity.bounce(normal)
#	velocity *= 0.5 + rand_range(-0.05, 0.05)
#
#func destroy():
#	quene_free()
#
#func _on_DamageArea_entity_damaged(entity):
#	destroy()





















