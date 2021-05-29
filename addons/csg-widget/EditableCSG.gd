tool
extends CSGCombiner

export(Material) var material setget update_mesh_material
export var show_widgets = true setget update_show_widgets
onready var core = $'Core'
onready var front = $'Front'
onready var back = $'Back'
onready var left = $'Left'
onready var right = $'Right'
onready var top = $'Top'
onready var bottom = $'Bottom'

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		get_tree().queue_delete(front)
		get_tree().queue_delete(back)
		get_tree().queue_delete(left)
		get_tree().queue_delete(right)
		get_tree().queue_delete(top)
		get_tree().queue_delete(bottom)
	update_mesh()
	pass

func update_show_widgets(val):
	show_widgets = val
	if Engine.is_editor_hint():
		if not front: return
		if not back: return
		if not left: return
		if not right: return
		if not top: return
		if not bottom: return

		if not val:
			front.set_visible(false)
			back.set_visible(false)
			left.set_visible(false)
			right.set_visible(false)
			top.set_visible(false)
			bottom.set_visible(false)
		else:
			front.set_visible(true)
			back.set_visible(true)
			left.set_visible(true)
			right.set_visible(true)
			top.set_visible(true)
			bottom.set_visible(true)

func update_mesh_material(mat):
	material = mat
	if core:
		core.set_surface_material(0, mat)
	

func rebuild_mesh(w,h,d):
	var w2 = w/2
	var h2 = h/2
	var d2 = d/2
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(material)
	
	# back
	st.add_uv(Vector2(0.0*-w, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,-d2))
	
	st.add_uv(Vector2(1.0*-w, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,-d2))
	
	st.add_uv(Vector2(0.0*-w, 1.0*-h))
	st.add_vertex(Vector3(-w2,h2,-d2))
	
	
	st.add_uv(Vector2(1.0*-w, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,-d2))
	
	st.add_uv(Vector2(0.0*-w, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,-d2))
	
	st.add_uv(Vector2(1.0*-w, 0.0*-h))
	st.add_vertex(Vector3(w2,-h2,-d2))
	
	# front
	st.add_uv(Vector2(0.0*w, 1.0*-h))
	st.add_vertex(Vector3(-w2,h2,d2))
	
	st.add_uv(Vector2(1.0*w, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,d2))
	
	st.add_uv(Vector2(0.0*w, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,d2))
	
	
	st.add_uv(Vector2(1.0*w, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,d2))
	
	st.add_uv(Vector2(1.0*w, 0.0*-h))
	st.add_vertex(Vector3(w2,-h2,d2))
	
	st.add_uv(Vector2(0.0*w, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,d2))
	
	# left
	st.add_uv(Vector2(0.0*-d, 0.0*-h))
	st.add_vertex(Vector3(w2,-h2,-d2))
	
	st.add_uv(Vector2(1.0*-d, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,d2))
	
	st.add_uv(Vector2(0.0*-d, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,-d2))
	
	
	st.add_uv(Vector2(0.0*-d, 0.0*-h))
	st.add_vertex(Vector3(w2,-h2,-d2))
	
	st.add_uv(Vector2(1.0*-d, 0.0*-h))
	st.add_vertex(Vector3(w2,-h2,d2))
	
	st.add_uv(Vector2(1.0*-d, 1.0*-h))
	st.add_vertex(Vector3(w2,h2,d2))
	
	#top
	st.add_uv(Vector2(0.0*w, 1.0*d))
	st.add_vertex(Vector3(-w2,h2,d2))
	
	st.add_uv(Vector2(0.0*w, 0.0*d))
	st.add_vertex(Vector3(-w2,h2,-d2))
	
	st.add_uv(Vector2(1.0*w, 1.0*d))
	st.add_vertex(Vector3(w2,h2,d2))
	
	
	st.add_uv(Vector2(0.0*w, 0.0*d))
	st.add_vertex(Vector3(-w2,h2,-d2))
	
	st.add_uv(Vector2(1.0*w, 0.0*d))
	st.add_vertex(Vector3(w2,h2,-d2))
	
	st.add_uv(Vector2(1.0*w, 1.0*d))
	st.add_vertex(Vector3(w2,h2,d2))
	
	# right
	st.add_uv(Vector2(1.0*d, 1.0*-h))
	st.add_vertex(Vector3(-w2,h2,d2))
	
	st.add_uv(Vector2(0.0*d, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,-d2))
	
	st.add_uv(Vector2(0.0*d, 1.0*-h))
	st.add_vertex(Vector3(-w2,h2,-d2))
	
	
	st.add_uv(Vector2(1.0*d, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,d2))
	
	st.add_uv(Vector2(0.0*d, 0.0*-h))
	st.add_vertex(Vector3(-w2,-h2,-d2))
	
	st.add_uv(Vector2(1.0*d, 1.0*-h))
	st.add_vertex(Vector3(-w2,h2,d2))
	
	#bottom
	st.add_uv(Vector2(0.0*w, 0.0*-d))
	st.add_vertex(Vector3(-w2,-h2,-d2))
	
	st.add_uv(Vector2(0.0*w, 1.0*-d))
	st.add_vertex(Vector3(-w2,-h2,d2))
	
	st.add_uv(Vector2(1.0*w, 1.0*-d))
	st.add_vertex(Vector3(w2,-h2,d2))
	
	
	st.add_uv(Vector2(1.0*w, 0.0*-d))
	st.add_vertex(Vector3(w2,-h2,-d2))
	
	st.add_uv(Vector2(0.0*w, 0.0*-d))
	st.add_vertex(Vector3(-w2,-h2,-d2))
	
	st.add_uv(Vector2(1.0*w, 1.0*-d))
	st.add_vertex(Vector3(w2,-h2,d2))
	
	st.generate_normals()
	st.index()
	
	var msh = Mesh.new()
	st.commit(msh)
	core.set_mesh(msh)

var initial_update = true
var prev_dist_x = 0
var prev_dist_y = 0
var prev_dist_z = 0

func update_mesh(force = false):
	if not front: return
	if not back: return
	if not left: return
	if not right: return
	if not top: return
	if not bottom: return

	var dist_z = front.translation.z - back.translation.z
	var pos_z = (front.translation.z + back.translation.z) / 2
	core.translation.z = pos_z
	left.translation.z = pos_z
	right.translation.z = pos_z
	top.translation.z = pos_z
	bottom.translation.z = pos_z

	var dist_x = left.translation.x - right.translation.x
	var pos_x = (left.translation.x + right.translation.x) / 2
	core.translation.x = pos_x
	top.translation.x = pos_x
	bottom.translation.x = pos_x
	front.translation.x = pos_x
	back.translation.x = pos_x

	var dist_y = top.translation.y - bottom.translation.y
	var pos_y = (top.translation.y + bottom.translation.y) / 2
	core.translation.y = pos_y
	left.translation.y = pos_y
	right.translation.y = pos_y
	front.translation.y = pos_y
	back.translation.y = pos_y
	
	if prev_dist_x != dist_x or prev_dist_y != dist_y or prev_dist_z != dist_z or force:
		prev_dist_x = dist_x
		prev_dist_y = dist_y
		prev_dist_z = dist_z
		rebuild_mesh(dist_x, dist_y, dist_z)

func _process(delta):
		if Engine.is_editor_hint():
			update_mesh()