class_name Warrior
extends Unit

func _ready():
	super()
	sprite.texture = load("res://units/Warrior/Warrior_"+color+".png")
