extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_next_page_pressed() -> void:
	if $Panel/Page1.visible == true:
		$Panel/Page1.visible = false
		$Panel/Page2.visible = true
		$PainterImage.check_page()
	elif $Panel/Page2.visible == true:
		$Panel/Page2.visible = false
		$Panel/Page3.visible = true
		$PainterImage.check_page()
	elif $Panel/Page3.visible == true:
		$Panel/Page3.visible = false
		$Panel/Page4.visible = true
		$PainterImage.check_page()
	elif $Panel/Page4.visible == true:
		$Panel/Page4.visible = false
		$Panel/Page5.visible = true
		$PainterImage.check_page()
	elif $Panel/Page5.visible == true:
		$Panel/Page5.visible = false
		$Panel/Page6.visible = true
		$PainterImage.check_page()
	elif $Panel/Page6.visible == true:
		$Panel/Page6.visible = false
		$Panel/Page7.visible = true
		$PainterImage.check_page()
	elif $Panel/Page7.visible == true:
		$Panel/Page7.visible = false
		$Panel/Page8.visible = true
		$PainterImage.check_page()
	elif $Panel/Page8.visible == true:
		$Panel/Page8.visible = false
		$Panel/Page9.visible = true
		$PainterImage.check_page()
	elif $Panel/Page9.visible == true:
		$Panel/Page9.visible = false
		$Panel/Page10.visible = true
		$PainterImage.check_page()
	elif $Panel/Page10.visible == true:
		$Panel/Page10.visible = false
		$Panel/Page1.visible = true
		$PainterImage.check_page()

func _on_previous_page_pressed() -> void:
	if $Panel/Page1.visible == true:
		$Panel/Page1.visible = false
		$Panel/Page10.visible = true
		$PainterImage.check_page()
	elif $Panel/Page2.visible == true:
		$Panel/Page2.visible = false
		$Panel/Page1.visible = true
		$PainterImage.check_page()
	elif $Panel/Page3.visible == true:
		$Panel/Page3.visible = false
		$Panel/Page2.visible = true
		$PainterImage.check_page()
	elif $Panel/Page4.visible == true:
		$Panel/Page4.visible = false
		$Panel/Page3.visible = true
		$PainterImage.check_page()
	elif $Panel/Page5.visible == true:
		$Panel/Page5.visible = false
		$Panel/Page4.visible = true
		$PainterImage.check_page()
	elif $Panel/Page6.visible == true:
		$Panel/Page6.visible = false
		$Panel/Page5.visible = true
		$PainterImage.check_page()
	elif $Panel/Page7.visible == true:
		$Panel/Page7.visible = false
		$Panel/Page6.visible = true
		$PainterImage.check_page()
	elif $Panel/Page8.visible == true:
		$Panel/Page8.visible = false
		$Panel/Page7.visible = true
		$PainterImage.check_page()
	elif $Panel/Page9.visible == true:
		$Panel/Page9.visible = false
		$Panel/Page8.visible = true
		$PainterImage.check_page()
	elif $Panel/Page10.visible == true:
		$Panel/Page10.visible = false
		$Panel/Page9.visible = true
		$PainterImage.check_page()
