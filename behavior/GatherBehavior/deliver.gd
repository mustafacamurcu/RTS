class_name Deliver extends BTLeaf

func tick(agent: Worker, _blackboard) -> NodeStatus:
	agent.deliver()
	return NodeStatus.Success
