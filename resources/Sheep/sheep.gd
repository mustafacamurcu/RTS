class_name Sheep
extends Source

const STARTING_AMOUNT = 200
const AMOUNT_MINED = 10

func _ready():
	type = "Sheep"
	amount_left = STARTING_AMOUNT
	super()

func gather(capacity_left) -> Cost:
	var mined = min(amount_left, AMOUNT_MINED, capacity_left)
	amount_left -= mined
	return Cost.new().f(mined)

func _process(_delta):
	if is_depleted():
		queue_free()
