extends Node
class_name NoteButton

@export var buttonValue : String
@export var incomingNotes : Array[Note]
@export var longNoteEffect : AnimationPlayer
@export var missNoteEffect : AnimationPlayer

var holdDuration : float
var isInputValid : bool
var noInput : bool

func _ready() -> void:
	await get_tree().process_frame
	longNoteEffect.current_animation = "Rotate"

func _process(delta : float) -> void:
	noInput = true
	if Input.is_action_just_pressed(buttonValue):
		ValidateTap()
	if Input.is_action_pressed(buttonValue):
		ValidateHold(delta)
	if Input.is_action_just_released(buttonValue):
		ValidateRelease()
		
func ValidateHold(delta : float):
	if incomingNotes.is_empty():
		return
	var front = incomingNotes.front()
		
	holdDuration += delta
	if front.data.noteType == 1:
		front.Hold()


func ValidateTap():
	if(incomingNotes.is_empty()):
		return
	var front = incomingNotes.front()
	isInputValid = Helper.IsInThreshold(NoteSpawner.elapsed_time, front.data.hitTime, Globals.hitErrorThreshold)
	if isInputValid:
		noInput = false
	
	print(isInputValid, ' >>>> ', NoteSpawner.elapsed_time, ' >>>> ', front.data.hitTime)

func ValidateRelease():
	if(incomingNotes.is_empty()): return
	var front = incomingNotes.front()
	
	if !isInputValid:
		return
	
	if front.data.noteType == 0:
		# tap
		if holdDuration < 0.2:
			var particle = NoteParticlePool.Get(front.position)
			front.Deactivate()
			incomingNotes.pop_front()
	
	if front.data.noteType == 1:
		front.Release()
		if Helper.IsInThreshold(holdDuration, front.data.duration, Globals.hitErrorThreshold):
			var particle = NoteParticlePool.Get(self.position)
			front.Deactivate()
			incomingNotes.pop_front()
		
	isInputValid = false
	holdDuration = 0
	noInput = true
	

func playMiss():
	missNoteEffect.current_animation = "Miss"
