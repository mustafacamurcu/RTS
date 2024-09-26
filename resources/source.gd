class_name Source
extends StaticBody2D

@onready var selectable = $Selectable
var type : String
var amount_left
var hotspots: Array[Dictionary]

@onready var hotspots_container = $Hotspots

func _ready():
	var hs = hotspots_container.get_children()
	for i in range(hs.size()):
		var hotspot : Node2D = hs[i]
		hotspots.append({
			'position':to_global(hotspot.global_position),
			'direction': hotspot.position.direction_to(Vector2.ZERO),
			'index': i,
			'worker': null})
	
	assert(type != "", "Not Expected! Every source should have a type")
	add_to_group(type)

func available_hotspots() -> Array:
	var available : Array = []
	for hotspot in hotspots:
		if not is_instance_valid(hotspot['worker']):
			available.append(hotspot)
	return available

func is_depleted() -> bool:
	return amount_left <= 0

func gather(_capacity_left) -> Cost:
	push_error("Unimplemented. SHOULD NOT HAPPEN!!")
	return Cost.new()
