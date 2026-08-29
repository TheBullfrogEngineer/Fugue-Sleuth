extends StaticBody3D


var interactable = true
			
func elevator():
	if interactable == true:
		interactable = false
		$"../AnimationPlayer".play("ElevatorOpen")
