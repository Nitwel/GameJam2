extends Node2D

@onready var main = $"/root/Main"
@onready var player = $Player
@onready var enemy = $Enemy

func start():
	player.load_from_inventory()
