extends Node

var elapsed_time := 0.0
var currentIndex : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	currentIndex = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!SongReader.IsReady):
		return
	elapsed_time += delta
	if currentIndex == SongReader.Notes.size():
		return
	
	var currNoteData = SongReader.Notes[currentIndex]
	# subtract 1 to account for lerp
	if(elapsed_time >= currNoteData.hitTime-1):
		# Create notes per target
		for noteTarget in currNoteData.targets:
			if(currNoteData.noteType == 0):
				Spawn(currNoteData, noteTarget)
			elif currNoteData.noteType == 1:
				var currentNote = NotePool.Get(1)
				currentNote.Activate(currNoteData, noteTarget)
				AddNote(noteTarget, currentNote)
			else:
				var currentNote = NotePool.Get(2)
				currentNote.Activate(currNoteData, noteTarget)
				AddNote(noteTarget, currentNote)
		
		currentIndex += 1
		
		# End of song
		#if(currentIndex == SongReader.Notes.size()):
			#SongReader.IsReady = false
			#print("End")
			

func Spawn(data: Core_NoteData, target: int) -> Note:
	var currentNote = NotePool.Get(0)
	currentNote.Activate(data, target)
	AddNote(target, currentNote)
	return currentNote
	

func AddNote(button : int, note : Note):
	if button == 0:
		Globals.button_up.incomingNotes.push_back(note)
	elif button == 1:
		Globals.button_right.incomingNotes.push_back(note)
	elif button == 2:
		Globals.button_down.incomingNotes.push_back(note)
	elif button == 3:
		Globals.button_s.incomingNotes.push_back(note)
	elif button == 4:
		Globals.button_a.incomingNotes.push_back(note)
	elif button == 5:
		Globals.button_w.incomingNotes.push_back(note)
