extends CharacterBody2D

@export var speed: float = 40000
@onready var action_area := $BushArea
@onready var main := $"/root/Main"
@onready var sprite = $Sprite2D
@onready var animation_player = $Sprite2D
@onready var audioplayer = $AudioStreamPlayer
var steps = false:
	set(value):
		if steps != value:
			steps = value
			if steps:
				audioplayer.play()
			else:
				audioplayer.stop()


func _physics_process(delta):
	if main.menu.visible:
		return

	var moved = false

	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction != Vector2.ZERO:
		moved = true
		velocity = direction * speed * delta
		if direction.x > 0:
			animation_player.play("walk_right")
		elif direction.x < 0:
			animation_player.play("walk_left")
		elif direction.y > 0:
			animation_player.play("walk_down")
		elif direction.y < 0:
			animation_player.play("walk_up")
		steps = true
	else:
		velocity = Vector2.ZERO
		animation_player.play("idle")
		steps = false

	move_and_slide()

	if moved:
		var rand_num = randf()
		var trigger_bush = rand_num < 0.006

		for body in action_area.get_overlapping_bodies():
			print(body, body is Boss)
			if body is Bush and trigger_bush:
				main.start_battle(body.level)
			if body is Boss:
				main.start_battle(body.body.level, body.body)
