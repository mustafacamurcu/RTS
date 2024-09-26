extends BTLeaf

const search_range: int = 10000

func tick(agent: Unit, _blackboard) -> NodeStatus:
	var members = get_tree().get_nodes_in_group('Castle')
	
	if members.is_empty():
		return NodeStatus.Failure
	
	var closest = members[0]
	var closest_distance = members[0].global_position.distance_to(agent.global_position)
	for member in members:
		var distance = member.global_position.distance_to(agent.global_position)
		if distance < closest_distance:
			closest = member
			closest_distance = distance
	
	if closest_distance > search_range:
		return NodeStatus.Failure
	agent.navigator.target_position = closest.selectable.global_position
	return NodeStatus.Success
