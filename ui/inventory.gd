extends Control

@onready var main = $"/root/Main"

@onready var close_btn = $MarginContainer/AspectRatioContainer/PanelContainer/Button

@onready var head = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/Head
@onready var torso = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/Torso
@onready var leg_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/LegR
@onready var leg_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/LegL
@onready var feet_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/FeetL
@onready var feet_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/FeetR
@onready var arm_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/ArmR
@onready var arm_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/ArmL
@onready var hand_r = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/HandR
@onready var hand_l = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Monster/HandL

@onready var inventory = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/GridContainer
@onready var tooltip_container = $Node2D/HBoxContainer
@onready var tooltip = $Node2D/HBoxContainer/Tooltip
@onready var tooltip_compare = $Node2D/HBoxContainer/TooltipCompare

@onready var health_label = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Stats/GridContainer/Health
@onready var damage_label = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Stats/GridContainer/Damage
@onready var armor_label = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Stats/GridContainer/Armor
@onready var attack_speed_label = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Stats/GridContainer/AttackSpeed
@onready var health_regen_label = $MarginContainer/AspectRatioContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Stats/GridContainer/HealthRegen

var hovering = null:
	set(value):
		hovering = value

		if !is_inside_tree():
			return
		
		update_tooltip()

var dragging = null:
	set(value):
		dragging = value

		if !is_inside_tree():
			return

		update_tooltip()

var disabled = false

func _ready():
	tooltip.visible = false
	close_btn.pressed.connect(func():
		main.toggle_inventory()
	)

	var start_body = Body.get_random_body(25)
	head.item = start_body.head
	torso.item = start_body.torso
	leg_r.item = start_body.left_leg
	leg_l.item = start_body.right_leg
	feet_l.item = start_body.left_foot
	feet_r.item = start_body.right_foot
	arm_r.item = start_body.left_arm
	arm_l.item = start_body.right_arm
	hand_r.item = start_body.left_hand
	hand_l.item = start_body.right_hand

	await main.ready

	update_stats()

func update_stats():
	var body = get_body()

	var damage = main.battle.player.base_damage + body.get_stat("damage")
	var armor = main.battle.player.base_armor + body.get_stat("armor")
	var health = main.battle.player.base_health + body.get_stat("health")
	var attack_speed = main.battle.player.base_attack_speed + body.get_stat("attack_speed")
	var health_regen = body.get_stat("health_regen")

	damage_label.text = str(round(damage))
	armor_label.text = str(round(armor))
	health_label.text = str(round(health))
	attack_speed_label.text = str(round(attack_speed * 1000) / 1000)
	health_regen_label.text = str(round(health_regen * 10) / 10)

func update_tooltip():
	update_stats()

	if hovering == null&&dragging == null:
		tooltip.item = null
		tooltip_compare.item = null

		tooltip.compare = null
		tooltip_compare.compare = null
	elif hovering != null&&dragging == null:
		tooltip.item = hovering
		tooltip_compare.item = null

		tooltip.compare = null
		tooltip_compare.compare = null
	elif hovering == null&&dragging != null:
		tooltip.item = dragging
		tooltip_compare.item = null

		tooltip.compare = null
		tooltip_compare.compare = null
	elif hovering != dragging:
		tooltip.item = dragging
		tooltip_compare.item = hovering

		tooltip.compare = hovering
		tooltip_compare.compare = dragging

func _process(delta):
	if main.menu.visible:
		return

	if Input.is_action_just_released("click")&&dragging != null:
		dragging = null

	tooltip_container.position = get_local_mouse_position() - Vector2(tooltip_compare.size.x + 5, 0)

func add_item(item: Item):
	for slot in inventory.get_children():
		if slot.item == null:
			slot.item = item
			return true
	return false

func get_body() -> Body:
	var body = Body.new()
	body.head = head.item
	body.torso = torso.item
	body.left_leg = leg_l.item
	body.right_leg = leg_r.item
	body.left_foot = feet_l.item
	body.right_foot = feet_r.item
	body.left_arm = arm_l.item
	body.right_arm = arm_r.item
	body.left_hand = hand_l.item
	body.right_hand = hand_r.item
	return body