class_name Core_NoteData

var targets : Array[int]
var hitTime : float
var noteType : int
var duration: float
var notes = {}
	
func _init(_targets : Array[int], _hitTime : float = 0, _noteType: int = 0, _duration: float = 0):
	targets = _targets
	hitTime = _hitTime
	noteType = _noteType
	duration = _duration
