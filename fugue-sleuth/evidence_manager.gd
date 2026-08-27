extends Node

var objects: Array[EvidenceCard] = []

signal object_appended(card: EvidenceCard, index: int)
 
 
func append_object(card: EvidenceCard) -> void:
	if card == null:
		return
	for existing in objects:
		if existing.id == card.id:
			return
 
	objects.append(card)
	var new_index := objects.size() - 1
	object_appended.emit(card, new_index)
