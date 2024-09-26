class_name BehaviorTree extends Node

var child : BTNode
var active = false
var _blackboard = {}

signal behavior_success(behavior: BehaviorTree)
signal behavior_failure(behavior: BehaviorTree)

func _ready():
	child = get_child(0)

func _physics_process(_delta):
	if active:
		var status : BTNode.NodeStatus = child.tick(owner, _blackboard)
		if status == BTNode.NodeStatus.Success:
			behavior_success.emit(self)
			active = false
		elif status == BTNode.NodeStatus.Failure:
			behavior_failure.emit(self)
			active = false

func _activate():
	for behavior in owner.behaviors:
		behavior._deactivate()
	active = true
	child.setup(owner, _blackboard)

func _deactivate():
	active = false
