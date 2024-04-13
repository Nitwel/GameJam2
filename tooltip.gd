extends PanelContainer

@onready var damage_label = $VBoxContainer/GridContainer/Damage2
@onready var armor_label = $VBoxContainer/GridContainer/Armor2
@onready var health_label = $VBoxContainer/GridContainer/Health2
@onready var attack_speed_label = $VBoxContainer/GridContainer/AttackSpeed2
@onready var health_regen_label = $VBoxContainer/GridContainer/HealthRegen2

var item = null:
    set(value):
        item = value

        if !is_inside_tree():
            return

        if item == null:
            visible = false
        else:
            visible = true
            damage_label.text = str(round(item.damage))
            armor_label.text = str(round(item.armor))
            health_label.text = str(round(item.health))
            attack_speed_label.text = str(round(item.attack_speed * 1000) / 1000)
            health_regen_label.text = str(round(item.health_regen * 10) / 10)
        