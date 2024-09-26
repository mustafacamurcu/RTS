class_name Succeeder
extends BTDecorator

func tick(agent: Unit, blackboard) -> NodeStatus:
	var status : NodeStatus = child.tick(agent, blackboard)
	if status == NodeStatus.Success or status == NodeStatus.Failure:
		return NodeStatus.Success
	else:
		return NodeStatus.Running
