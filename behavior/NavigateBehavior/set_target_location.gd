class_name SetTargetPosition extends BTLeaf

func tick(agent: Unit, blackboard):
	agent.navigator.target_position = blackboard['target_location']
