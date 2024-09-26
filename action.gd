class_name Action extends RefCounted

var texture: Texture2D
var action: Callable

func _init(t, a):
	texture = t
	action = a

