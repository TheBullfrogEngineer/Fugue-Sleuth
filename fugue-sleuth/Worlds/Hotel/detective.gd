extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func last_cutscene() -> void:
	get_tree().change_scene_to_file("res://Cutscenes/closing_scene.tscn")
