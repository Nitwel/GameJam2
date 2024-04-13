extends Control

func _get_drag_data(at_position):
	print("get drag data")
	var item = get_children()[0]

	var preview_texture = TextureRect.new()

	preview_texture.texture = item.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(64, 64)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	remove_child(item)
	return item

func _can_drop_data(at_position, data):
	return data is TextureRect

func _drop_data(at_position, data):
	print("drop data")
	pass

func _input(event):
	if event is InputEventMouseButton:
		print("Clicked On Object")
