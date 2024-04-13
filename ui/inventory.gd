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

func get_body() -> Body:
	var body = Body.new()
	body.head = head.item
	body.torso = torso.item
	body.left_leg = leg_l.item
	body.right_leg = leg_r.item
	body.left_foot = feet_l.item
	body.right_foot = feet_r.item
	body.left_arm = arm_l.item
	body.right_arm = arm_r.item
	body.left_hand = hand_l.item
	body.right_hand = hand_r.item
	return body