class_name Inverter
extends BTDecorator

func tick(agent: Unit, blackboard) -> NodeStatus:
	var status : NodeStatus = child.tick(agent, blackboard)
	if status == NodeStatus.Success:
		return NodeStatus.Failure
	else:
		return NodeStatus.Success
