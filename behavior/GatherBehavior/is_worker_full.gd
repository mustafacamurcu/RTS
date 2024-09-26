extends BTLeaf

func tick(worker: Worker, _blackboard) -> NodeStatus:
	if worker.is_at_carry_capacity():
		return NodeStatus.Success
	else:
		return NodeStatus.Failure
