extends Resource
class_name Item

enum Part {
    NONE,
    HEAD,
    TURSO,
    FEET,
    HANDS,
    EXTRIMITY
}

@export var texture: CompressedTexture2D

@export var part: Part = Part.NONE
@export var damage: float = 0
@export var armor: float = 0
@export var health: float = 0
@export var attack_speed: float = 0
@export var health_regen: float = 0