extends Node2D
class_name Note

var targetButton : int
var data : Core_NoteData
var isActive : bool
var elapsed : float
var noteDuration : float = 1 # time it taks for the note to reach the target button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(!isActive):
		return
	
	var targ = GetTarget(targetButton)
	self.rotate(2 * delta)
	
	if elapsed < noteDuration:
		elapsed += delta
		var nt = clamp(elapsed / noteDuration, 0.0, 1.0)
		self.position = lerp(Globals.center.position, targ.position, nt)
		return
	
	# Keep moving the note towards outside the screen
	self.position = self.position.move_toward(targ.position * 1.5, Globals.center.position.distance_to(targ.position)/1 * delta)

	#if outside the hit threshold, miss
	if NoteSpawner.elapsed_time > data.hitTime + Globals.hitErrorThreshold:
		Miss()
		Deactivate()
	

func Activate(_data : Core_NoteData, target : int):
	data = _data
	targetButton = target
	elapsed = 0
	self.visible = true
	self.look_at(GetTarget(targetButton).position)
	
	noteDuration = Globals.noteSpeed
	
	isActive = true

func GetTarget(target : int) -> NoteButton:
	if(target == 1): 
		return Globals.button_right
	elif(target == 2): 
		return Globals.button_down
	elif(target == 3): 
		return Globals.button_s
	elif(target == 4): 
		return Globals.button_a
	elif(target == 5): 
		return Globals.button_w
	return Globals.button_up #0

func Miss():
	GetTarget(targetButton).incomingNotes.pop_front()
	GetTarget(targetButton).playMiss()

func Deactivate():
	isActive = false
	self.visible = false
	NotePool.ReturnToPool(self)
	
