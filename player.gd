extends CharacterBody2D

@export var speed: float = 40000

func _physics_process(delta):

    var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    direction = direction.normalized()

    if direction != Vector2.ZERO:
        velocity = direction * speed * delta
    else:
        velocity = Vector2.ZERO

    move_and_slide()