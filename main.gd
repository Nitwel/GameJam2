extends Node2D

@onready var inventory = $CanvasLayer/Inventory
@onready var battle = $Battle
@onready var player = $Player
@onready var map = $Map

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func start_battle():
	remove_child(player)
	remove_child(map)
	add_child(battle)
	inventory.disabled = true
	battle.start()
