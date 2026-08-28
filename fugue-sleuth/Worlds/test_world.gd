extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"John Detective".give_notes.connect($Control.notes_visible)
