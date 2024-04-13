extends Node2D

@onready var main = $"/root/Main"
@onready var player = $Player
@onready var enemy = $Enemy

func start(level: float):
	var body = main.inventory.get_body()

	player.start(body)
	enemy.start(Body.get_random_body(level))

func battle_over(player_lost: BattleCharacter):
	if player_lost != player:
		main.inventory.add_item(enemy.body.get_random_item())

	main.battle_over()
