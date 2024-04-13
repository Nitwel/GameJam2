extends CharacterBody2D

@export var speed: float = 40000
@onready var action_area := $BushArea
@onready var main := $"/root/Main"
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _physics_process(delta):

	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction != Vector2.ZERO:
		velocity = direction * speed * delta
		if direction.x > 0:
			animation_player.play("walk_right")
		elif direction.x < 0:
			animation_player.play("walk_left")
		elif direction.y > 0:
			animation_player.play("walk_down")
		elif direction.y < 0:
			animation_player.play("walk_up")
	else:
		velocity = Vector2.ZERO
		animation_player.play("idle")
		

	move_and_slide()

	if action_area.has_overlapping_bodies():
		main.start_battle()
