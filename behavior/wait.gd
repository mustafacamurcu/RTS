extends BTLeaf

@export var wait_time_in_s: int
var timer: Timer

func tick(_agent, _blackboard: Dictionary) -> NodeStatus:
	if not timer:
		timer = Timer.new()
		timer.one_shot = true
		add_child(timer)
		timer.start(wait_time_in_s)
		return NodeStatus.Running
	elif timer.is_stopped():
		timer.queue_free()
		timer = null
		return NodeStatus.Success
	else:
		return NodeStatus.Running
