extends Control

var unlocked_notes: Array[int] = [1,2] 

var current_note_index: int = 0 

func _ready() -> void:
	_update_page_visibility()

func _on_next_page_pressed() -> void:
	if unlocked_notes.is_empty(): return
	current_note_index = (current_note_index + 1) % unlocked_notes.size()
	_update_page_visibility()

func _on_previous_page_pressed() -> void:
	if unlocked_notes.is_empty(): return
	current_note_index = (current_note_index - 1 + unlocked_notes.size()) % unlocked_notes.size()
	_update_page_visibility()

func _update_page_visibility() -> void:
	if unlocked_notes.is_empty(): return
	for i in range(1, 11):
		var page = get_node("Panel/Page" + str(i))
		if page != null:
			page.visible = false
	var active_page_number = unlocked_notes[current_note_index]
	var active_page = get_node("Panel/Page" + str(active_page_number))
	if active_page != null:
		active_page.visible = true
	$"../NewPage".play()
	$PainterImage.check_page()

func unlock_new_note(page_num: int) -> void:
	if not unlocked_notes.has(page_num):
		unlocked_notes.append(page_num)
		unlocked_notes.sort()
