extends Node

@export var Center: Node2D
@export var ButtonUp: NoteButton
@export var ButtonRight: NoteButton
@export var ButtonDown: NoteButton
@export var ButtonS: NoteButton
@export var ButtonA: NoteButton
@export var ButtonW: NoteButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.center = Center
	Globals.button_up = ButtonUp
	Globals.button_right = ButtonRight
	Globals.button_down = ButtonDown
	Globals.button_s = ButtonS
	Globals.button_a = ButtonA
	Globals.button_w = ButtonW
