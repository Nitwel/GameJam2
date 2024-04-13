extends Node2D

@onready var inventory = $CanvasLayer/Inventory
@onready var battle = $Battle
@onready var player = $Player
@onready var map = $Map

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func start_battle(level: float):
	remove_child(player)
	remove_child(map)
	add_child(battle)
	inventory.disabled = true
	battle.start(level)

func battle_over():
	remove_child(battle)
	add_child(player)
	add_child(map)
	inventory.disabled = false