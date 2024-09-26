class_name StartNavigationToTarget extends BTLeaf

func tick(unit: Unit, blackboard) -> NodeStatus:
	var target : Vector2 = blackboard['navigation_target']
	unit.navigator.target_position = target
	return NodeStatus.Success
