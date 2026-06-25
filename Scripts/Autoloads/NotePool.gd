extends Node

var pool: Array[Note]
var longPool: Array[Note]
var scratchPool: Array[Note]

# Called when the node enters the scene tree for the first time.
func CreateNormal(noteScene : PackedScene, initialSize : int) -> void:
	for i in initialSize:
		var note = noteScene.instantiate() as Note
		add_child(note)
		note.visible = false
		pool.push_back(note)
		
func CreateLong(noteScene : PackedScene, initialSize : int) -> void:
	for i in initialSize:
		var longNote = noteScene.instantiate() as LongNote
		add_child(longNote)
		longNote.visible = false
		longPool.push_back(longNote)

func CreateScratch(noteScene: PackedScene, initialSize: int) -> void:
	for i in initialSize:
		var scratchNote = noteScene.instantiate() as ScratchNote
		add_child(scratchNote)
		scratchNote.visible = false
		scratchPool.push_back(scratchNote)

func Get(noteType : int) -> Note:
	if noteType == 1:
		return longPool.pop_front()
	if noteType == 2:
		return scratchPool.pop_front()
	return pool.pop_front()
	
func ReturnToPool(note : Note) -> void:
	note.visible = false
	if note.data.noteType == 0:
		pool.push_back(note)
	if note.data.noteType == 1:
		longPool.push_back(note)
	if note.data.noteType == 2:
		scratchPool.push_back(note)
