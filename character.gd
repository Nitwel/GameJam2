extends Node2D

class_name BattleCharacter

@onready var main = $"/root/Main"
@onready var body_parts = $BodyParts
@onready var timer = $Timer
@onready var regen_timer = $Regen
@onready var bar = $ProgressBar
@onready var animation = $AnimationPlayer
@onready var level_label = $ProgressBar/PanelContainer/Label

@export var base_health: float = 100
@export var base_armor: float = 10
@export var base_damage: float = 10
@export var base_attack_speed: float = 1
var max_health = 100:
	set(value):
		max_health = value

		if !is_inside_tree():
				return

		bar.max_value = value
var health = 100:
	set(value):
		health = clamp(value, 0, max_health)

		if !is_inside_tree():
			return

		bar.value = health
var armor = 10
var damage = 10
var attack_speed = 1
var health_regen = 0
var active = false
@export var flipped = false:
	set(value):
		flipped = value

		if !is_inside_tree():
			return

		scale.x = -1 if flipped else 1
		bar.scale.x = -1 if flipped else 1

@export var enemy: BattleCharacter
@export var body: Body

func _ready():
	flipped = flipped

	regen_timer.timeout.connect(func():
		if !active:
			return

		health += health_regen
	)

	timer.timeout.connect(func():
		if !active:
			return

		enemy.take_damage(damage)
		var target_animation="kick" if randf() > 0.5 else "punsh"
		var duration=animation.get_animation(target_animation).length
		animation.speed_scale=attack_speed / duration
		animation.play(target_animation)

	)

func start(body: Body):
	self.body = body
	load_from_inventory()

	max_health = base_health + body.get_stat("health")
	armor = base_armor + body.get_stat("armor")
	damage = base_damage + body.get_stat("damage")
	attack_speed = base_attack_speed + body.get_stat("attack_speed")
	health_regen = body.get_stat("health_regen")
	health = max_health

	print("Player: ", " ".join([health, armor, damage, attack_speed, health_regen]))

	active = true

	level_label.text = str(floor(body.level))

	timer.wait_time = 1.0 / attack_speed
	timer.start()

func load_from_inventory():
	for body_part in body_parts.get_children():
		var item = body.get_part(body_part.name)

		for mesh in body_part.get_children():
			mesh.visible = mesh.texture == item.texture

func take_damage(amount):
	health -= amount * (100 / (100 + armor))
	if health <= 0:
		active = false
		main.battle.battle_over(self)
