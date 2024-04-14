extends PanelContainer

@onready var title = $VBoxContainer/Title
@onready var damage_label = $VBoxContainer/GridContainer/Damage2
@onready var armor_label = $VBoxContainer/GridContainer/Armor2
@onready var health_label = $VBoxContainer/GridContainer/Health2
@onready var attack_speed_label = $VBoxContainer/GridContainer/AttackSpeed2
@onready var health_regen_label = $VBoxContainer/GridContainer/HealthRegen2

var item = null:
	set(value):
		item = value

		if !is_inside_tree():
			return

		if item == null:
			visible = false
		else:
			title.text = item.name
			visible = true
			damage_label.text = str(round(item.damage))
			armor_label.text = str(round(item.armor))
			health_label.text = str(round(item.health))
			attack_speed_label.text = str(round(item.attack_speed * 1000) / 1000)
			health_regen_label.text = str(round(item.health_regen * 10) / 10)

var compare = null:
	set(value):
		compare = value

		if !is_inside_tree():
			return
		
		if compare == null||compare.damage == item.damage:
			damage_label.add_theme_color_override("font_color", Color(1, 1, 1))
		elif compare.damage > item.damage:
			damage_label.add_theme_color_override("font_color", Color(1, 0, 0))
		else:
			damage_label.add_theme_color_override("font_color", Color(0, 1, 0))

		if compare == null||compare.armor == item.armor:
			armor_label.add_theme_color_override("font_color", Color(1, 1, 1))
		elif compare.armor > item.armor:
			armor_label.add_theme_color_override("font_color", Color(1, 0, 0))
		else:
			armor_label.add_theme_color_override("font_color", Color(0, 1, 0))

		if compare == null||compare.health == item.health:
			health_label.add_theme_color_override("font_color", Color(1, 1, 1))
		elif compare.health > item.health:
			health_label.add_theme_color_override("font_color", Color(1, 0, 0))
		else:
			health_label.add_theme_color_override("font_color", Color(0, 1, 0))

		if compare == null||compare.attack_speed == item.attack_speed:
			attack_speed_label.add_theme_color_override("font_color", Color(1, 1, 1))
		elif compare.attack_speed > item.attack_speed:
			attack_speed_label.add_theme_color_override("font_color", Color(1, 0, 0))
		else:
			attack_speed_label.add_theme_color_override("font_color", Color(0, 1, 0))

		if compare == null||compare.health_regen == item.health_regen:
			health_regen_label.add_theme_color_override("font_color", Color(1, 1, 1))
		elif compare.health_regen > item.health_regen:
			health_regen_label.add_theme_color_override("font_color", Color(1, 0, 0))
		else:
			health_regen_label.add_theme_color_override("font_color", Color(0, 1, 0))