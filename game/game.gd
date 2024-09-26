extends Node2D

const PAWN = preload("res://units/Worker/worker.tscn")
const ARCHER = preload("res://units/Archer/archer.tscn")
const WARRIOR = preload("res://units/Warrior/warrior.tscn")
const CASTLE = preload("res://buildings/Castle/castle.tscn")
const BUILDING_PLACER = preload("res://game/building_placer.tscn")
@onready var grid_container = $CanvasLayer/Resources/MarginContainer/GridContainer
@onready var canvas_layer = $CanvasLayer
@onready var building_placer = $BuildingPlacer

const colors = ["Blue", "Red", "Purple", "Yellow"]

var current_resources : Cost = Cost.new().w(100).g(100).f(10000)

enum Resources {
	WOOD, GOLD, FOOD
}

enum Buildings {
	CASTLE
}


var currently_building : Buildings
var current_building_cost : Cost

## Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.build_castle.connect(_on_build_castle)
	SignalBus.spawn_pawn.connect(_on_spawn_pawn)
	SignalBus.place_building.connect(_on_place_building)
	SignalBus.refund_building.connect(_on_refund_building)
	SignalBus.resource_gathered.connect(gain_resource)

func _on_refund_building():
	gain_resource(current_building_cost)

func _on_place_building(pos):
	spawn_castle(pos, "Blue")

func gain_resource(res: Cost):
	current_resources.add(res)
	SignalBus.resources_changed.emit(current_resources)

func pay_cost(cost: Cost):
	current_resources.pay(cost)
	SignalBus.resources_changed.emit(current_resources)

func _on_build_castle():
	if current_resources.wood >= 50 and current_resources.gold >= 50:
		var cost = Cost.new().w(50).g(50)
		pay_cost(cost)
		currently_building = Buildings.CASTLE
		current_building_cost = cost
		show_building_placer()

func _on_spawn_pawn(pos, color):
	if current_resources.food >= 50:
		var cost = Cost.new().f(50)
		pay_cost(cost)
		spawn_pawn(pos, color)

func spawn_random_unit(units):
	var random_unit = units[randi_range(0,len(units)-1)]
	var random_color = colors[randi_range(0,len(colors)-1)]
	var random_pos = Vector2(randf()*1000-500,randf()*1000-500)
	random_unit.call(random_pos, random_color)

func spawn_warrior(pos, color):
	var warrior = WARRIOR.instantiate().with_data(color)
	warrior.position = pos
	add_child(warrior)
	
func spawn_archer(pos, color):
	var archer = ARCHER.instantiate().with_data(color)
	archer.position = pos
	add_child(archer)

func spawn_pawn(pos, color):
	var pawn = PAWN.instantiate()
	pawn.color = color
	pawn.position = pos
	add_child(pawn)

func show_building_placer():
	building_placer.activate(CASTLE)

func spawn_castle(pos, color):
	var castle = CASTLE.instantiate().with_data(color)
	castle.position = pos
	add_child(castle)
	$NavigationRegion2D.parse_source_geometry()
