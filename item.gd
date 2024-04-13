extends Resource
class_name Item

const hand_textures = [ preload ("res://assets/Hand_Basic.svg"), preload ("res://assets/Hand_Mutant.svg"), preload ("res://assets/Hand_Spike.svg")]
const foot_textures = [ preload ("res://assets/Foot_Basic.svg"), preload ("res://assets/Foot_Mutant.svg"), preload ("res://assets/Foot_Spike.svg")]
const body_textures = [ preload ("res://assets/Body_Basic.svg"), preload ("res://assets/Body_Mutant.svg"), preload ("res://assets/Body_Spike.svg")]
const extrimity_textures = [ preload ("res://assets/Extrimity_Basic.svg"), preload ("res://assets/Extrimity_Mutant.svg"), preload ("res://assets/Extrimity_Spike.svg")]
const head_textures = [ preload ("res://assets/Head_Basic.svg"), preload ("res://assets/Head_Mutant.svg"), preload ("res://assets/Head_Spike.svg")]

const MAX_LEVEL = 100

enum Part {
    NONE,
    HEAD,
    TORSO,
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

static func get_random_item(type: Part, level: float) -> Item:
    var item = Item.new()

    var part_level = 0

    match type:
        Part.HEAD:
            part_level = pick_index(head_textures, level)
            item.texture = head_textures[part_level]
        Part.TORSO:
            part_level = pick_index(body_textures, level)
            item.texture = body_textures[part_level]
        Part.FEET:
            part_level = pick_index(foot_textures, level)
            item.texture = foot_textures[part_level]
        Part.HANDS:
            part_level = pick_index(hand_textures, level)
            item.texture = hand_textures[part_level]
        Part.EXTRIMITY:
            part_level = pick_index(extrimity_textures, level)
            item.texture = extrimity_textures[part_level]

    item.part = type
    item.damage = randf_range([2, 8, 32][part_level], [8, 32, 128][part_level]) * level
    item.armor = randf_range([1, 5, 10][part_level], [5, 10, 30][part_level]) * level
    item.health = randf_range([5, 20, 80][part_level], [20, 80, 320][part_level]) * level
    item.attack_speed = randf_range([0.001, 0.002, 0.004][part_level], [0.002, 0.004, 0.008][part_level]) * level
    item.health_regen = randf_range([0.1, 0.2, 0.4][part_level], [0.2, 0.4, 0.8][part_level]) * level
    return item

static func pick(list: Array, level: float):
    return list[pick_index(list, level)]

static func pick_index(list: Array, level: float):
    var index = 0
    var value = 0
    var distribution = _bezier_distribution(list.size() - 1, level / MAX_LEVEL)
    var random = randf()

    for i in range(distribution.size()):
        value += distribution[i]
        if random < value:
            index = i
            break

    return index

static func _bezier_distribution(degree: int, value: float):
    var result = []
    for i in range(degree + 1):
        result.append(binomial_coefficient(degree, i) * pow(value, i) * pow(1 - value, degree - i))
    return result

static func binomial_coefficient(n: int, k: int):
    return factorial(n) / (factorial(k) * factorial(n - k))

static func factorial(n: int):
    if n == 0:
        return 1
    return n * factorial(n - 1)