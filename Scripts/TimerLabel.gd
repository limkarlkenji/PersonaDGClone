extends Node

@export var timer: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.text = str("%.2f" % NoteSpawner.elapsed_time)
