extends Control

@onready var weapon1_button = $HBoxContainer/Weapon1Button
@onready var weapon2_button = $HBoxContainer/Weapon2Button

@export var player: Player

var weapon1: Node2D
var weapon2: Node2D

func _ready() -> void:
	# Connect button signals
	weapon1_button.toggled.connect(_on_weapon1_button_toggled)
	weapon2_button.toggled.connect(_on_weapon2_button_toggled)
	
	# Find weapon nodes
	weapon1 = player.get_node("Weapon")
	weapon2 = player.get_node("Weapon2")
	
	# Set initial state
	_on_weapon1_button_toggled(true)

func _on_weapon1_button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		weapon2_button.button_pressed = false
		_activate_weapon(weapon1, weapon2)
		weapon1_button.modulate = Color(0.7, 1, 0.7) # Light green tint
	else:
		weapon1_button.modulate = Color.WHITE

func _on_weapon2_button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		weapon1_button.button_pressed = false
		_activate_weapon(weapon2, weapon1)
		weapon2_button.modulate = Color(0.7, 1, 0.7) # Light green tint
	else:
		weapon2_button.modulate = Color.WHITE

func _activate_weapon(active_weapon: Node2D, inactive_weapon: Node2D) -> void:
	if active_weapon and inactive_weapon:
		active_weapon.visible = true
		active_weapon.process_mode = Node.PROCESS_MODE_INHERIT
		inactive_weapon.visible = false
		inactive_weapon.process_mode = Node.PROCESS_MODE_DISABLED 