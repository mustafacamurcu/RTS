extends BTLeaf

func tick(worker:Worker, blackboard) -> NodeStatus:
	var source : Source = blackboard['source']
	var hotspots: Array = source.available_hotspots()
	if hotspots.is_empty():
		return NodeStatus.Failure
	
	var closest_hotspot = hotspots[0]
	for hotspot in hotspots:
		if (worker.global_position.distance_to(hotspot['position'])
			< worker.global_position.distance_to(closest_hotspot['position'])):
			closest_hotspot = hotspot
	
	blackboard['navigation_target'] = closest_hotspot['position']
	blackboard['hotspot'] = closest_hotspot
	blackboard['animation_direction'] = closest_hotspot['direction']
	blackboard['source_type'] = blackboard['source'].type
	closest_hotspot['worker'] = worker
	return NodeStatus.Success
