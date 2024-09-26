class_name Building
extends StaticBody2D

@onready var sprite : Sprite2D = $Sprite
@onready var unit_hud = $UnitHUD
@onready var selectable = $Selectable
@onready var collision_shape_2d : CollisionShape2D = $CollisionShape2D

var color : String = "Red";

func with_data(color_): 
	color = color_
	return self

func _ready():
	add_to_group('Building')
	selectable.selected.connect(_on_selected)
	selectable.deselected.connect(_on_deselected)

func _on_selected():
	sprite.material.set("shader_parameter/highlight_enabled", true)
	unit_hud.activate()

func _on_deselected():
	sprite.material.set("shader_parameter/highlight_enabled", false)
	unit_hud.deactivate()

func _process(_delta):
	pass
