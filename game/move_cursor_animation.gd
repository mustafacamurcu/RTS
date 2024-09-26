extends AnimatedSprite2D


func _ready():
	SignalBus.move_command_received.connect(_on_move_command_received)

func _on_move_command_received(move_pos):
	position = move_pos
	frame = 0
	play()
