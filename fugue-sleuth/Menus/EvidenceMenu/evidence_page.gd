extends Control

var current_page := 0

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


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	EvidenceManager.object_appended.connect(_on_evidence_added)
	
	update_page()


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


func _on_previous_page_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		update_page()


func _on_next_page_pressed() -> void:
	if (current_page + 1) * 4 < EvidenceManager.objects.size():
		current_page += 1
		update_page()
