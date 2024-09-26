extends GridContainer


const ACTION_BUTTON = preload("res://ui/action_button.tscn")

var actions : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	deactivate()
	pass # Replace with function body.

func update():
	for action in actions:
		var button_container = ACTION_BUTTON.instantiate()
		var button = button_container.get_child(0)
		button.get_child(0).get_child(0).texture = action.texture
		button.pressed.connect(action.action)
		add_child(button_container)
 
func activate():
	show()
	set_process(true)
	set_process_input(true)
	set_process_unhandled_input(true)
	set_process_unhandled_key_input(true)
	set_process_shortcut_input(true)
	
func deactivate():
	#get_child(0).queue_free()
	hide()
	set_process(false)
	set_process_input(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	set_process_shortcut_input(false)
