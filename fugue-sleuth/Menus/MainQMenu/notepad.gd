extends Control

var is_paused = false

func _ready() -> void:
	self.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Notepad"):
		pause_toggle()
		
func pause_toggle():
	if is_paused:
		resume()
	else:
		pause()


func pause() -> void:
	is_paused = true
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func resume() -> void:
	is_paused = false
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	

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
