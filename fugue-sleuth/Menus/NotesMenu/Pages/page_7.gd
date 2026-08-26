extends TextEdit

func _input(event : InputEvent):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE or event.keycode == KEY_DELETE or (event.ctrl_pressed and (event.keycode == KEY_X or event.keycode == KEY_Z or event.keycode == KEY_C)):
			get_viewport().set_input_as_handled()
	
var notes : String = " "

func _on_text_changed() -> void:
	if get_total_visible_line_count() > 15:
		text = notes
		$".".visible = false
		$"../Page8".visible = true
		$"../../PainterImage".check_page()
	elif get_total_visible_line_count() < 16:
		notes = text
