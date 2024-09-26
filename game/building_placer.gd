extends Sprite2D

#var size : Vector2

const red_modulate = Color(1.0,0,0,0.3)
const green_modulate = Color(0,1.0,0,0.3)

var building : Building

func _ready():
	visible = false

func activate(b: Resource):
	if is_instance_valid(building):
		building.queue_free()
	building = b.instantiate()
	building.collision_layer = 0
	add_child(building)
	visible = true
	position = get_global_mouse_position()-building.sprite.position
	update_modulate()

func update_modulate():
	if isEmpty():
		modulate = green_modulate
	else:
		modulate = red_modulate

func _unhandled_input(event):
	if visible and event is InputEventMouseMotion:
		position = get_global_mouse_position()-building.sprite.position
		update_modulate()
	elif visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		position = get_global_mouse_position()-building.sprite.position
		if isEmpty():
			SignalBus.place_building.emit(position)
			visible = false
	elif visible and event.is_action_pressed('cancel'):
		visible = false
		SignalBus.refund_building.emit()
		

func isEmpty():
	# Create and send Shape query to Physics
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = building.collision_shape_2d.shape
	query.transform = Transform2D(0, position)
	return space.intersect_shape(query).size() == 0
