class_name EvidenceObject
extends InteractableObject

@export var evidence_card: EvidenceCard

func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted() -> void:
	EvidenceManager.append_object(evidence_card)
	print("Objetos en el manager: ", EvidenceManager.objects.size())
