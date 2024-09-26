extends BTLeaf


func tick(worker: Worker, blackboard: Dictionary) -> NodeStatus:
	var source : Source = blackboard['source']
	worker.gather(source)
	return NodeStatus.Success
