extends Panel
class_name UISlot

@onready var main := $"/root/Main"

@onready var item_place = $ItemPlace
@export var delete = false
@export var item: Item = null:
	set(value):
		item = value

		if is_inside_tree() == false:
			return

		update()
@export var slot_type: Item.Part = Item.Part.NONE

func _ready():
	update()

	mouse_entered.connect(func():
		main.inventory.hovering=item
	)

	mouse_exited.connect(func():
		main.inventory.hovering=null
	)

func update():
	if item:
		item_place.texture = item.texture
	else:
		item_place.texture = null

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()

	preview_texture.texture = item_place.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(64, 64)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	main.inventory.dragging = item

	return self

func _can_drop_data(at_position, data):
	return slot_type == Item.Part.NONE or (data.item != null and data.item.part == slot_type)

func _drop_data(at_position, data):
	if delete:
		data.item = null
		main.inventory.dragging = null
		return

	var temp = data.item
	data.item = item
	item = temp
	main.inventory.dragging = null
