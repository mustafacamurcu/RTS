extends BTLeaf

const search_range: int = 10000

func tick(worker: Worker, blackboard) -> NodeStatus:
	var sources = get_tree().get_nodes_in_group(blackboard['source_type'])
	
	if sources.is_empty():
		return NodeStatus.Failure
	
	var closest_source = sources[0]
	var closest_hotspot = {'position':Vector2(INF,INF)}
	for source: Source in sources:
		if source.is_depleted():
			continue
		var hotspots = source.available_hotspots()
		for hotspot in hotspots:
			var distance = hotspot['position'].distance_to(worker.global_position)
			if distance < closest_hotspot['position'].distance_to(worker.global_position):
				closest_hotspot = hotspot
				closest_source = source
	
	if closest_hotspot['position'].distance_to(worker.global_position) > search_range:
		return NodeStatus.Failure
	
	blackboard['source'] = closest_source
	blackboard['navigation_target'] = closest_hotspot['position']
	blackboard['hotspot'] = closest_hotspot
	blackboard['animation_direction'] = closest_hotspot['direction']
	blackboard['source_type'] = closest_source.type
	closest_hotspot['worker'] = worker
	
	return NodeStatus.Success
