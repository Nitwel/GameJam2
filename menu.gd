extends Control

@onready var main = $"/root/Main"

@onready var start_button = $CenterContainer/VBoxContainer/Start
@onready var close_button = $CenterContainer/VBoxContainer/Exit

func _ready():
    start_button.pressed.connect(func():
        main.toggle_menu()
    )

    close_button.pressed.connect(func():
        get_tree().quit()
    )
