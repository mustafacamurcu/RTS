extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.resources_changed.connect(_on_resources_changed)
	
func _on_resources_changed(remaining):
	text = str(remaining.food)
