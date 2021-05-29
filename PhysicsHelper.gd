extends Node
class_name PhysicsHelper

const GRAVITY = 20

static func calculate_arc_velocity(point_a, point_b, arc_height, \
	up_gravity = GRAVITY, down_gravity = null):
		
	if down_gravity == null:
		down_gravity = up_gravity
	
	var velocity = Vector2()
	
	var displacement = point_b - point_a
	
	if displacement.y > arc_height:
		var time_up = sqrt(-2 * arc_height / float(up_gravity))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(down_gravity))
	
		velocity.y = -sqrt(-2 * up_gravity * arc_height)
		velocity.x = displacement.x / float(time_up + time_down)
	
	return velocity

