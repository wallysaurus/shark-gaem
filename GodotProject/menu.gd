extends Control
@onready var onstart : int = 0
@onready var button = find_child("StartButton")
# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(self._button_pressed)
	pass

func _button_pressed():
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://camera_3d.tscn")
