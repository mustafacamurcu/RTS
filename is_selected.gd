class_name IsSelected extends BTLeaf

func tick(agent: Unit, blackboard) -> NodeStatus:
	if agent.selectable.is_selected:
		return NodeStatus.Success
	else:
		return NodeStatus.Failure
