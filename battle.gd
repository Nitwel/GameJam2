extends Node2D

@onready var main = $"/root/Main"
@onready var player = $Player
@onready var enemy = $Enemy

func start():
	var body = main.inventory.get_body()

	player.start(body)
	enemy.start()

func game_over():
	pass