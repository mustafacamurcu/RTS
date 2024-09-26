extends Node2D

var dragging = false
var drag_start = Vector2.ZERO
var rect_to_draw : Rect2;

func _draw():
	if dragging:
		# Semi Transparent Filled Rect
		draw_rect(rect_to_draw, Color(0,0,0,0.15), true)
		# White Border
		draw_rect(rect_to_draw, Color(1,1,1,0.8), false)

func getUnitsInBox(start, end):
	# Create rectangle of selection
	var selection_rect : RectangleShape2D = RectangleShape2D.new()
	selection_rect.size = abs(end - start)
	# Create and send Shape query to Physics
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = selection_rect
	query.transform = Transform2D(0,(start+end)/2)
	query.collide_with_bodies = false
	query.collide_with_areas = true
	return space.intersect_shape(query).map(func (x): return x.collider)

func getUnitUnderClick(click_pos):
	# Create and send Point query to Physics
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.position = click_pos
	var space = get_world_2d().direct_space_state
	var candidates:  = space.intersect_point(query)
	# Select only the top rendered unit (using y-sort)
	if candidates.size() > 0:
		var top_most = candidates[0]
		for candidate in candidates:
			if candidate.collider.get_parent().position.y > top_most.collider.get_parent().position.y:
				top_most = candidate
		return [top_most.collider]
	return []

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Group Selection on Double Click
			#if event.double_click:
				#var unit = getUnitUnderClick(get_global_mouse_position())
				#var offset = Vector2(500,500)
				#var unit_pos = unit.position
				#var selected = getUnitsInBox(unit_pos - offset, unit_pos + offset)
				#SignalBus.selection_updated.emit(selected)
			# Start tracking selection box on mouse down
			if event.pressed:
				drag_start = get_global_mouse_position()
				dragging = true
			
			# Release after clicking
			elif dragging:
				dragging = false
				var drag_end = get_global_mouse_position()
				var distance : Vector2 = abs(drag_end - drag_start)
				if distance.length() < 5: # If regular click, select first unit under
					var selected = getUnitUnderClick((drag_end))
					SignalBus.selection_updated.emit(selected)
				else: #  Select all in box
					var is_unit = func is_unit(unit): return unit.get_parent() is Unit
					var selected = getUnitsInBox(drag_start, drag_end).filter(is_unit)
					SignalBus.selection_updated.emit(selected)
				queue_redraw()
		
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var collider = getUnitUnderClick(get_global_mouse_position())
			if collider.is_empty() or collider[0].get_parent() is Unit:
				SignalBus.move_command_received.emit(get_global_mouse_position())
			else:
				SignalBus.interact_command_received.emit(collider[0])

	if dragging and event is InputEventMouseMotion:
		var drag_end = get_global_mouse_position()
		rect_to_draw = Rect2(drag_start,drag_end-drag_start)
		queue_redraw()

