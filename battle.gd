extends Node2D

@onready var main = $"/root/Main"
@onready var player = $Player
@onready var enemy = $Enemy
@onready var animation = $CanvasLayer/AnimationPlayer
@onready var area_lava = $ArenaLava
@onready var area_forest = $ArenaForest

signal on_battle_over(looser: Body)

func start(level: float, enemy_body=null):
	var body = main.inventory.get_body()

	area_lava.visible = enemy_body != null
	area_forest.visible = enemy_body == null

	player.load(body)
	enemy.load(enemy_body if enemy_body else Body.get_random_body(level))
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

	on_battle_over.emit(player_lost.body)

	main.battle_over()
