extends Resource
class_name Body

var head: Item
var torso: Item
var left_arm: Item
var right_arm: Item
var left_leg: Item
var right_leg: Item
var left_foot: Item
var right_foot: Item
var left_hand: Item
var right_hand: Item
var level: float

func get_part(part: String):
    var part_map = get_map()

    return part_map[part]

func get_random_item():
    var part = randi() % 10

    match part:
        0:
            return head
        1:
            return torso
        2:
            return left_arm
        3:
            return right_arm
        4:
            return left_leg
        5:
            return right_leg
        6:
            return left_foot
        7:
            return right_foot
        8:
            return left_hand
        9:
            return right_hand

func get_map():
    return {
        "Head": head,
        "Torso": torso,
        "ArmR": right_arm,
        "ArmL": left_arm,
        "LegR": right_leg,
        "LegL": left_leg,
        "FootR": right_foot,
        "FootL": left_foot,
        "HandR": right_hand,
        "HandL": left_hand
    }

func get_stat(type: String):
    var sum = 0

    for part in get_map().values():
        if part != null:
            sum += part.get(type)

    return sum

static func get_random_body(level: float):
    var body = Body.new()
    body.level = level
    body.head = Item.get_random_item(Item.Part.HEAD, level)
    body.torso = Item.get_random_item(Item.Part.TORSO, level)
    body.left_arm = Item.get_random_item(Item.Part.EXTRIMITY, level)
    body.right_arm = Item.get_random_item(Item.Part.EXTRIMITY, level)
    body.left_leg = Item.get_random_item(Item.Part.EXTRIMITY, level)
    body.right_leg = Item.get_random_item(Item.Part.EXTRIMITY, level)
    body.left_foot = Item.get_random_item(Item.Part.FEET, level)
    body.right_foot = Item.get_random_item(Item.Part.FEET, level)
    body.left_hand = Item.get_random_item(Item.Part.HANDS, level)
    body.right_hand = Item.get_random_item(Item.Part.HANDS, level)

    return body