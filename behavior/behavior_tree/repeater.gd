class_name Repeater
extends BTDecorator

var child_needs_setup = true

func setup(_agent, _blackboard):
	child_needs_setup = true

func tick(agent, blackboard) -> NodeStatus:
	if child_needs_setup:
		child.setup(agent, blackboard)
	var status : NodeStatus = child.tick(agent, blackboard)
	if status == NodeStatus.Success:
		child_needs_setup = true
		return NodeStatus.Running
	elif status == NodeStatus.Running:
		child_needs_setup = false
		return NodeStatus.Running
	else:
		return NodeStatus.Failure
