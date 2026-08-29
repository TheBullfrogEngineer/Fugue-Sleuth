extends AnimationPlayer

func _on_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Worlds/Hotel/HotelRoom.tscn")
