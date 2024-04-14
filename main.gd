extends Node2D

@onready var inventory = $CanvasLayer/Inventory
@onready var menu = $CanvasLayer/Menu
@onready var battle = $Battle
@onready var player = $Player
@onready var map = $Map

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_menu()

	if Input.is_action_just_pressed("inventory")&&!menu.visible:
		toggle_inventory()

func start_battle(level: float):
	remove_child(player)
	remove_child(map)
	add_child(battle)
	inventory.disabled = true
	toggle_inventory(false)
	battle.start(level)

func battle_over():
	remove_child(battle)
	add_child(player)
	add_child(map)
	inventory.disabled = false
	toggle_inventory(true)

func toggle_menu(value=!menu.visible):
	menu.visible = value
	menu.start_button.text = "Resume"
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if menu.visible or inventory.visible else Input.MOUSE_MODE_CAPTURED)

func toggle_inventory(value=!inventory.visible):
	inventory.visible = value
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if inventory.visible else Input.MOUSE_MODE_CAPTURED)
