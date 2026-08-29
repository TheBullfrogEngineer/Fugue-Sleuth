extends StaticBody3D


var interactable = true
			
func elevator_two():
	if interactable == true:
		interactable = false
		$"../AnimationPlayer".play("OpenElevator2")
