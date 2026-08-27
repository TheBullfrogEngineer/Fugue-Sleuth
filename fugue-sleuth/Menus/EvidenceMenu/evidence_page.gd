extends Control

var current_page := 0
var selected_evidence := -1

@onready var texture_rects = [
	$MarginContainer/VBoxContainer/GridContainer/TextureRect,
	$MarginContainer/VBoxContainer/GridContainer/TextureRect2,
	$MarginContainer/VBoxContainer/GridContainer/TextureRect3,
	$MarginContainer/VBoxContainer/GridContainer/TextureRect4
]

@onready var labels = [
	$MarginContainer/VBoxContainer/GridContainer/Label,
	$MarginContainer/VBoxContainer/GridContainer/Label2,
	$MarginContainer/VBoxContainer/GridContainer/Label3,
	$MarginContainer/VBoxContainer/GridContainer/Label4
]

@onready var selected_texture: TextureRect = $SelectedEvidence


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	EvidenceManager.object_appended.connect(_on_evidence_added)

	for i in range(texture_rects.size()):
		texture_rects[i].gui_input.connect(_on_texture_gui_input.bind(i))

	selected_texture.visible = false

	update_page()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		selected_texture.visible = false
		selected_evidence = -1


func _on_evidence_added(card: EvidenceCard, index: int) -> void:
	update_page()


func update_page() -> void:
	var objects = EvidenceManager.objects

	for i in range(4):
		var index := current_page * 4 + i

		if index < objects.size():
			var card: EvidenceCard = objects[index]

			labels[i].text = card.display_name
			texture_rects[i].texture = card.visual

			labels[i].visible = true
			texture_rects[i].visible = true
		else:
			labels[i].text = ""
			texture_rects[i].texture = null

			labels[i].visible = false
			texture_rects[i].visible = false


func _on_texture_gui_input(event: InputEvent, index: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			show_evidence(index)


func show_evidence(index: int) -> void:
	var objects = EvidenceManager.objects
	var real_index := current_page * 4 + index

	if real_index >= objects.size():
		return

	var card: EvidenceCard = objects[real_index]

	selected_evidence = real_index
	selected_texture.texture = card.visual
	selected_texture.visible = true

	var final_size := Vector2(500, 500)
	var screen_size := get_viewport_rect().size
	var target_position := (screen_size - final_size) / 2.0

	selected_texture.size = Vector2(150, 150)
	selected_texture.position = (screen_size - selected_texture.size) / 2.0

	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		selected_texture,
		"size",
		final_size,
		0.35
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	tween.tween_property(
		selected_texture,
		"position",
		target_position,
		0.35
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _on_previous_page_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		update_page()


func _on_next_page_pressed() -> void:
	if (current_page + 1) * 4 < EvidenceManager.objects.size():
		current_page += 1
		update_page()
