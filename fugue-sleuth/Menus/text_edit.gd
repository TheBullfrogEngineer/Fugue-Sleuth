extends TextEdit

var safe_text : String = ""

func _input(event : InputEvent):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE or event.keycode == KEY_DELETE or (event.ctrl_pressed and (event.keycode == KEY_X or event.keycode == KEY_Z or event.keycode == KEY_C)):
			get_viewport().set_input_as_handled()
	


func _on_text_changed() -> void:
	if get_visible_line_count() > 15:
		text = safe_text
	elif get_visible_line_count() < 14:
		safe_text = text
