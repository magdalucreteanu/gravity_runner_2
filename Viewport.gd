extends Viewport

func _ready():
	get_tree().get_root().get_node("SceneManager/Main/Viewport").connect("size_changed", self, "window_resize")
	window_resize()

func window_resize():
	size = get_tree().get_root().get_node("SceneManager/Main/Viewport").size
	set_size_override(true, size)
	
