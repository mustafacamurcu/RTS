class_name NavigateBehavior extends BehaviorTree

func start(target: Vector2):
	_blackboard['target_location'] = target
	_activate()
