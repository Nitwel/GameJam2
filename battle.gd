extends Node2D

@onready var main = $"/root/Main"
@onready var player = $Player
@onready var enemy = $Enemy
@onready var animation = $CanvasLayer/AnimationPlayer

func start(level: float):
	var body = main.inventory.get_body()

	player.load(body)
	enemy.load(Body.get_random_body(level))
	animation.play("start")
	await animation.animation_finished
	player.start()
	enemy.start()

func battle_over(player_lost: BattleCharacter):
	player.stop()
	enemy.stop()
	if player_lost != player:
		main.inventory.add_item(enemy.body.get_random_item())
		animation.play("win")
	else:
		animation.play("lost")
	
	await animation.animation_finished
	main.battle_over()
