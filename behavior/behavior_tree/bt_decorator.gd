class_name BTDecorator
extends BTNode

var child : BTNode

func setup(agent, blackboard):
	child.setup(agent, blackboard)

func _ready():
	child = get_child(0)
