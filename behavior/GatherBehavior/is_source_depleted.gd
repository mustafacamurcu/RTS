extends BTLeaf

func tick(_worker: Worker, blackboard) -> NodeStatus:
	if not is_instance_valid(blackboard['source']):
		return NodeStatus.Success
	var source : Source = blackboard['source']
	if source.is_depleted():
		return NodeStatus.Success
	else:
		return NodeStatus.Failure
