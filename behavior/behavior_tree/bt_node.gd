class_name BTNode
extends Node

enum NodeStatus {
	Success, Failure, Running
}

func setup(_agent, _blackboard):
	pass

func tick(_agent, _blackboard) -> NodeStatus:
	return NodeStatus.Success
