class_name GoldMine
extends Source

const STARTING_AMOUNT = 500
const AMOUNT_MINED = 10
@onready var active = $Active
@onready var inactive = $Inactive
@onready var destroyed = $Destroyed

func _ready():
	inactive.show()
	type = "GoldMine"
	amount_left = STARTING_AMOUNT
	super()

func gather(capacity_left) -> Cost:
	var mined = min(amount_left, AMOUNT_MINED, capacity_left)
	amount_left -= mined
	return Cost.new().g(mined)

func _process(_delta):
	if amount_left <= 0:
		destroyed.show()
		inactive.hide()
		active.hide()
		return
	for hotspot in hotspots:
		if is_instance_valid(hotspot['worker']):
			active.show()
			inactive.hide()
			return
	inactive.show()
	active.hide()
