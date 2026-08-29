extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_run_pressed() -> void:
	get_tree().change_scene_to_file("res://Cutscenes/run.tscn")


func _on_become_pressed() -> void:
	get_tree().change_scene_to_file("res://Cutscenes/become.tscn")


func _on_turn_in_pressed() -> void:
	get_tree().change_scene_to_file("res://Cutscenes/turnin.tscn")


func _on_give_up_pressed() -> void:
	get_tree().change_scene_to_file("res://Cutscenes/giveup.tscn")
