extends Control

# Declare member variables here. Examples:
onready var sceneManager = get_node('/root/SceneManager')

func _ready():
	$HSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	
func _on_Back_pressed():
	var previousScene = load("res://screens/Menu.tscn") 
	sceneManager.popScene(previousScene.instance())


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
