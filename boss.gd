extends StaticBody2D
class_name Boss

@onready var character = $Character

@export var body: Body

func _ready():
    character.load(body)