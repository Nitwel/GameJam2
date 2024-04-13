extends Panel
class_name UISlot

@onready var item_place = $ItemPlace
@export var delete = false

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()

	preview_texture.texture = item_place.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(64, 64)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	return self

func _can_drop_data(at_position, data):
	return data is UISlot

func _drop_data(at_position, data):
	if delete:
		data.item_place.texture = null
		return

	var temp = data.item_place.texture
	data.item_place.texture = item_place.texture
	item_place.texture = temp

func get_item():
	return item_place.texture