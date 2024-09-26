class_name Worker
extends Unit

@onready var gather_behavior = $Behaviors/GatherBehavior

@onready var wood = $Wood
@onready var meat = $Meat
@onready var gold = $Gold

const CARRY_CAPACITY = 50
var carrying : Cost = Cost.new()
var chopping = false
@export var is_carrying_resources = false

static var TEXTURES = {
	"Blue": preload("res://units/Worker/Pawn_Blue.png"),
	"Purple": preload("res://units/Worker/Pawn_Purple.png"),
	"Red": preload("res://units/Worker/Pawn_Red.png"),
	"Yellow": preload("res://units/Worker/Pawn_Yellow.png"),
	"Icon": preload("res://units/Worker/Pawn_Red_single.png"),
}

func _ready():
	super()
	sprite.texture = load("res://units/Worker/Pawn_"+color+".png")
	unit_hud.actions = [Action.new(Castle.TEXTURES['Icon'], build_castle)]
	unit_hud.update()
	SignalBus.interact_command_received.connect(_on_interact_command_received)

func build_castle():
	SignalBus.build_castle.emit()

func gather(source: Source):
	var mined : Cost = source.gather(CARRY_CAPACITY - carrying.total())
	carrying.add(mined)

func is_at_carry_capacity():
	return carrying.total() >= CARRY_CAPACITY

func deliver():
	SignalBus.resource_gathered.emit(carrying)
	carrying = Cost.new()
	is_carrying_resources = false

func _process(_delta):
	wood.hide()
	meat.hide()
	gold.hide()
	if is_carrying_resources:
		match carrying.highest():
			Cost.WOOD:
				wood.show() 
			Cost.FOOD:
				meat.show() 
			Cost.GOLD:
				gold.show() 

func _on_interact_command_received(area: Area2D):
	if selectable.is_selected:
		if area.get_parent() is Source:
			if area.get_parent().type == 'GoldMine':
				chopping = false
			else:
				chopping = true
			gather_behavior.start(area.get_parent())
