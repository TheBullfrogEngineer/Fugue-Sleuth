extends Node

var objects: Array[EvidenceCard] = []

signal object_appended(card: EvidenceCard, index: int)
signal object_restored(card: EvidenceCard, index: int)


func append_object(card: EvidenceCard) -> void:
	if card == null:
		return

	for i in range(objects.size()):
		if objects[i].id == card.id:
			object_restored.emit(card, i)
			return

	objects.append(card)

	var new_index := objects.size() - 1

	object_appended.emit(card, new_index)
