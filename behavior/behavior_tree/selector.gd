class_name Selector
extends BTComposite

func tick(agent, blackboard) -> NodeStatus:
	if current_child:
		var status : NodeStatus = current_child.tick(agent, blackboard)
		if status == NodeStatus.Running or status == NodeStatus.Success:
			return status
	
	while !children.is_empty():
		current_child = children.pop_front()
		current_child.setup(agent, blackboard)
		var status : NodeStatus = current_child.tick(agent, blackboard)
		if status == NodeStatus.Running or status == NodeStatus.Success:
			return status

	return NodeStatus.Failure
