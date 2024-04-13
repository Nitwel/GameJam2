extends Control

@onready var close_btn = $MarginContainer/AspectRatioContainer/PanelContainer/Button

func _ready():
	close_btn.pressed.connect(func():
		visible=false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	)

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED)