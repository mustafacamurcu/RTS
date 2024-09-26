class_name Walk extends BTLeaf

var unit: Unit
	
func tick(agent: Unit, _blackboard):
	if agent.navigator.is_navigation_finished():
		agent.velocity = Vector2.ZERO
		return NodeStatus.Success

	var not_blocked = agent.navigator.step()
	if not not_blocked:
		return NodeStatus.Failure
	
	return NodeStatus.Running
