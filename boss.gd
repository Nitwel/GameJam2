extends StaticBody2D
class_name Boss

@onready var main = $"/root/Main"
@onready var character = $Character

@export var level: int = 1
@export var body: Body

func _ready():
    if body == null:
        body = Body.get_random_body(level)
    character.load(body)

    await main.ready

    main.battle.on_battle_over.connect(func(looser):
        if looser == body:
            queue_free()
    )
