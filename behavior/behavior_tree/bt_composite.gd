class_name BTComposite
extends BTNode

var children : Array[BTNode]
var current_child : BTNode

func setup(_agent, _blackboard):
	current_child = null
	children.assign(get_children())
	
func tick(_agent, _blackboard):
	return NodeStatus.Success
