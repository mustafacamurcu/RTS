class_name Unit
extends CharacterBody2D

@export var speed = 200.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite = $Sprite
@onready var selectable = $Selectable
@onready var unit_hud = $UnitHUD
@onready var navigator : NavigationAgent2D = $Navigator

var behaviors : Array[BehaviorTree]
@onready var idle_behavior : BehaviorTree = $"Behaviors/IdleBehavior"
@onready var navigate_behavior : NavigateBehavior = $Behaviors/NavigateBehavior

var color : String = "Red";
var animation_direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true
	animation_player.active = false
	selectable.selected.connect(_on_selected)
	selectable.deselected.connect(_on_deselected)
	
	
	behaviors.assign($Behaviors.get_children())
	for behavior : BehaviorTree in behaviors:
		behavior.behavior_success.connect(_on_behavior_success)
		behavior.behavior_failure.connect(_on_behavior_failure)
	idle_behavior.start()
	
	SignalBus.move_command_received.connect(_on_move_command_received)

func _on_behavior_success(_behavior_tree: BehaviorTree):
	idle_behavior.start()

func _on_behavior_failure(_behavior_tree: BehaviorTree):
	idle_behavior.start()

func _on_selected():
	sprite.material.set("shader_parameter/highlight_enabled", true)
	unit_hud.activate()

func _on_deselected():
	sprite.material.set("shader_parameter/highlight_enabled", false)
	unit_hud.deactivate()

func update_velocity(next_pos):
	velocity = global_position.direction_to(next_pos) * speed

func _on_move_command_received(pos):
	if selectable.is_selected:
		navigate_behavior.start(pos)
	
func _on_interact_command_received(_collider: Area2D):
	pass
