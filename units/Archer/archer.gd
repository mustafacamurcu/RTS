class_name Archer
extends Unit

func _ready():
	super()
	sprite.texture = load("res://units/Archer/Archer_"+color+".png")
