extends StaticBody3D

var interactable = true
			
func notepad():
	if interactable == true:
		interactable = false
		$"..".visible = false
		$CollisionShape3D.disabled = true
