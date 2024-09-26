class_name Idle
extends BTLeaf

func tick(_agent: Unit, _blackboard) -> NodeStatus:
	return NodeStatus.Running
