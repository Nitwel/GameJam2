extends Control

@onready var close_btn = $MarginContainer/AspectRatioContainer/PanelContainer/Button

@onready var head = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/Head
@onready var torso = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/Torso
@onready var leg_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/LegR
@onready var leg_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/LegL
@onready var feet_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/FeetL
@onready var feet_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/FeetR
@onready var arm_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/ArmR
@onready var arm_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/ArmL
@onready var hand_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/HandR
@onready var hand_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/Monster/HandL

@onready var part_map = {
	"Head": head,
	"Torso": torso,
	"LegR": leg_r,
	"LegL": leg_l,
	"FootL": feet_l,
	"FootR": feet_r,
	"ArmR": arm_r,
	"ArmL": arm_l,
	"HandR": hand_r,
	"HandL": hand_l
}

var disabled = false:
	set(value):
		disabled = value
		visible = !value
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if disabled else Input.MOUSE_MODE_CAPTURED)

func _ready():
	close_btn.pressed.connect(func():
		visible=false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	)

func _process(delta):
	if disabled:
		return

	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED)

func get_item(body_part: String):
	return part_map[body_part].get_item()