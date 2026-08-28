extends StaticBody3D

var toggle = false
var interactable = true

func interact():
	if interactable == true:
		interactable = false
		toggle = !toggle
		if toggle == false:
			$"../../AnimationPlayer".play("Close")
		if toggle == true:
			$"../../AnimationPlayer".play("Open")
		$"../../Timer".start()
		


func _on_timer_timeout() -> void:
	interactable = true
