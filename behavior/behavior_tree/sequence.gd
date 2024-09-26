class_name Sequence
extends BTComposite

func tick(agent, blackboard) -> NodeStatus:
	if current_child:
		var status : NodeStatus = current_child.tick(agent, blackboard)
		if status == NodeStatus.Running or status == NodeStatus.Failure:
			return status
	
	while !children.is_empty():
		current_child = children.pop_front()
		current_child.setup(agent, blackboard)
		var status : NodeStatus = current_child.tick(agent, blackboard)
		if status == NodeStatus.Running:
			return NodeStatus.Running
		if status == NodeStatus.Failure:
			return NodeStatus.Failure
	return NodeStatus.Success
