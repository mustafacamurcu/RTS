class_name AnimationStarter extends BTLeaf

@export var animation_state : String

func tick(agent: Unit, blackboard) -> NodeStatus:
	if 'animation_direction' in blackboard:
		agent.animation_direction = blackboard['animation_direction']
	agent.animation_tree.travel(animation_state)
	return NodeStatus.Success
