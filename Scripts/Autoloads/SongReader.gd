extends Node

var Notes : Array[Core_NoteData]
var IsReady : bool

# Called when the node enters the scene tree for the first time.
func Load(song : String) -> void:
	var text := FileAccess.get_file_as_string(song)
	var json = JSON.new()
	if json.parse(text) == OK:
		var data = json.data
		for note in data:
			var targets : Array[int]
			for target in note.target:
				targets.push_back(int(target))
			Notes.push_back(Core_NoteData.new(targets, note.hitTime, int(note.type), note.duration))
			print(note)
		IsReady = true
