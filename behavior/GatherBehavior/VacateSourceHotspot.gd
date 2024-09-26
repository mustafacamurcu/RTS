extends BTLeaf


func tick(_worker: Worker, blackboard) -> NodeStatus:
	blackboard['hotspot']['worker'] = null
	return NodeStatus.Success
