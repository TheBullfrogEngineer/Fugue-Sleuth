class_name EvidenceObject
extends InteractableObject

@export var evidence_card: EvidenceCard
@onready var moving_wall: CSGBox3D = $"../../WorldEnvironment/TestLevel/movingWall"

func _ready() -> void:
	interacted.connect(_on_interacted)


func _on_interacted() -> void:
	EvidenceManager.append_object(evidence_card)
	print("Objetos en el manager: ", EvidenceManager.objects.size())
	var tween = create_tween()
	tween.tween_property(moving_wall, "position:y", moving_wall.position.y + 5.0, 1.5)
