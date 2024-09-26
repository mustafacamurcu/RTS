class_name Cost extends RefCounted

enum {
	WOOD, GOLD, FOOD
}

var wood = 0
var gold = 0
var food = 0

func _init():
	pass

func w(amt):
	wood+=amt
	return self
func g(amt):
	gold+=amt
	return self
func f(amt):
	food+=amt
	return self
func add(c: Cost):
	wood += c.wood
	gold += c.gold
	food += c.food
func pay(c: Cost):
	wood -= c.wood
	gold -= c.gold
	food -= c.food
func has_enough(c: Cost):
	return wood>=c.wood and gold>=c.gold and food>=c.food
func total():
	return gold+food+wood
func highest():
	if wood >= gold and wood >= food:
		return WOOD
	elif food >= gold:
		return FOOD
	else:
		return GOLD
