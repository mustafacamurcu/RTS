extends Node2D

var is_selected = false

signal selected
signal deselected

func _ready():
	SignalBus.selection_updated.connect(_on_selection_updated)

func _on_selection_updated(new_selected):
	is_selected = self in new_selected
	if is_selected:
		selected.emit()
	else:
		deselected.emit()
