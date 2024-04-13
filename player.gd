extends CharacterBody2D

@export var speed: float = 40000
@onready var action_area := $BushArea
@onready var main := $"/root/Main"

func _physics_process(delta):
    var moved = false

    var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    direction = direction.normalized()

    moved = direction != Vector2.ZERO

    if direction != Vector2.ZERO:
        velocity = direction * speed * delta
    else:
        velocity = Vector2.ZERO

    move_and_slide()

    if moved:
        var rand_num = randf()

        if rand_num < 0.006:
            for body in action_area.get_overlapping_bodies():
                if body is Bush:
                    main.start_battle(body.level)
        