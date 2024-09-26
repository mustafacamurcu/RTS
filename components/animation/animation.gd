extends AnimationTree

func _process(_delta):
	if !owner.velocity.is_zero_approx():
		self['parameters/Walk/blend_position'] = owner.velocity.normalized().x
		self['parameters/Idle/blend_position'] = owner.velocity.normalized().x
		self['parameters/Carry/blend_position'].x = owner.velocity.normalized().x

	self['parameters/Carry/blend_position'].y = owner.velocity.length()
	self['parameters/Mine/blend_position'].x = owner.animation_direction.x
	self['parameters/Mine/blend_position'].y = 1 if owner.chopping else -1

func travel(animation_state):
	if (animation_state == "Carry"):
		owner.is_carrying_resources = true
	else:
		if owner is Worker:
			owner.is_carrying_resources = false

	self['parameters/playback'].travel(animation_state)
