class_name TreeSource
extends Source

const STARTING_AMOUNT = 300
const AMOUNT_MINED = 10
@onready var full_sprite = $FullSprite
@onready var empty_sprite = $EmptySprite

func _ready():
	type = "Tree"
	full_sprite.show()
	amount_left = STARTING_AMOUNT
	super()

func gather(capacity_left) -> Cost:
	var mined = min(amount_left, AMOUNT_MINED, capacity_left)
	amount_left -= mined
	if amount_left <= 0:
		full_sprite.hide()
		empty_sprite.show()
	return Cost.new().w(mined)
