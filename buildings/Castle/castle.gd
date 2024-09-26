class_name Castle
extends Building

static var TEXTURES = {
	"Blue": preload("res://buildings/Castle/Castle_Blue.png"),
	"Purple": preload("res://buildings/Castle/Castle_Purple.png"),
	"Red": preload("res://buildings/Castle/Castle_Red.png"),
	"Yellow": preload("res://buildings/Castle/Castle_Yellow.png"),
	"Icon": preload("res://buildings/Castle/Castle_Blue.png"),
}

func spawn_position():
	return position + Vector2((randf()-.5)*30,100+(randf()-.5)*30)

func _ready():
	super()
	add_to_group('Castle')
	sprite.texture = load("res://buildings/Castle/Castle_"+color+".png")
	unit_hud.actions = [Action.new(Worker.TEXTURES['Icon'], spawn_pawn)]
	unit_hud.update()

func spawn_pawn():
	SignalBus.spawn_pawn.emit(spawn_position(), color)

func _process(_delta):
	pass
