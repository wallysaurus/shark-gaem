extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = find_child("StartButton")
	button.pressed.connect(self._button_pressed)
	pass

func _button_pressed():
	print("balls")
	get_tree().change_scene_to_file("res://camera_3d.tscn")
