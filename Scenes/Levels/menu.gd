extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_game_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/game_1_level_1.tscn")
