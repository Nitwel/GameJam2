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

func get_part(part: String):
    var part_map = get_map()

    return part_map[part]

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
        sum += part.get(type)

    return sum