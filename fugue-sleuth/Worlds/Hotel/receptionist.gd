extends StaticBody3D


var interactable = true
			
func talk():
	if interactable == true:
		interactable = false
		$AudioStreamPlayer2D.play()
