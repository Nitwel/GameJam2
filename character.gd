extends Node2D

@onready var main = $"/root/Main"
@onready var body_parts = $BodyParts

func load_from_inventory():
    for body_part in body_parts.get_children():
        for mesh in body_part.get_children():
            mesh.visible = mesh.texture == main.inventory.get_item(body_part.name)
