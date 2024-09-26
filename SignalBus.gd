extends Node

signal move_command_received(pos)
signal interact_command_received(collider: Area2D)

signal selection_updated(selected)

signal resources_changed(remaining: Cost)

signal build_castle
signal spawn_pawn(pos, color)
signal place_building(pos)
signal refund_building

signal resource_gathered(amount: Cost)
