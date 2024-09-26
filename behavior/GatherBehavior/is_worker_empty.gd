extends BTLeaf

func tick(worker: Worker, _blackboard) -> NodeStatus:
	if worker.carrying.total() == 0:
		return NodeStatus.Success
	else:
		return NodeStatus.Failure
