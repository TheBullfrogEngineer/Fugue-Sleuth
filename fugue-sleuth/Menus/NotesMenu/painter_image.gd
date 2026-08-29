extends Sprite2D

@export var paint_color : Color = Color.BLACK
@export var img_size := Vector2i(800, 1100)
@export var brush_size := 1

var imgs : Array[Image] = []
var page := 0

func check_page():
	if $"../Panel/Page1".visible:
		page = 0
	elif $"../Panel/Page2".visible:
		page = 1
	elif $"../Panel/Page3".visible:
		page = 2
	elif $"../Panel/Page4".visible:
		page = 3
	elif $"../Panel/Page5".visible:
		page = 4
	elif $"../Panel/Page6".visible:
		page = 5
	elif $"../Panel/Page7".visible:
		page = 6
	elif $"../Panel/Page8".visible:
		page = 7
	elif $"../Panel/Page9".visible:
		page = 8
	elif $"../Panel/Page10".visible:
		page = 9
		
	texture.update(imgs[page])

func _ready() -> void:
	for i in 10:
		var img = Image.create_empty(img_size.x, img_size.y, false, Image.FORMAT_RGBA8)
		img.fill(Color.WHITE)
		imgs.append(img)
	texture = ImageTexture.create_from_image(imgs[0])
	
func _paint_tex(pos) -> void:
	imgs[page].fill_rect(Rect2i(pos, Vector2i(1,1)).grow(brush_size), paint_color)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if $"../AudioStreamPlayer2D".playing == false:
				$"../AudioStreamPlayer2D".play()
			var lpos = to_local(event.position)
			var impos = lpos-offset+get_rect().size/2.0
			if event.relative.length_squared() > 0:
				var num := ceili(event.relative.length())
				var target_pos = impos - (event.relative)
				for i in num:
					impos = impos.move_toward(target_pos, 1.0)
					_paint_tex(impos)
			texture.update(imgs[page])
		else:
			$"../AudioStreamPlayer2D".stop()
