class_name GatherBehavior extends BehaviorTree

func start(source: Source):
	_blackboard['source'] = source
	_blackboard['source_type'] = source.type
	_activate()

func _deactivate():
	if 'hotspot' in _blackboard:
		_blackboard['hotspot']['worker'] = null
	super()
