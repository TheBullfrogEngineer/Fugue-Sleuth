extends Control


func resume():
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
#This doesn't work so somebody please fix it
func menu_toggle():
	if Input.is_action_just_pressed("Notepad") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Notepad") and get_tree().paused == true:
		resume()

#Everything down here works fine
func _on_notes_pressed() -> void:
	$Control.visible = false
	$Notes.visible = true

func _on_evidence_pressed() -> void:
	$Control.visible = false
	$Notes.visible = false


func _on_menu_pressed() -> void:
	$Control.visible = true
	$Notes.visible = false
