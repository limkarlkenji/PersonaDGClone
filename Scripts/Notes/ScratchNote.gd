extends Note
class_name ScratchNote

var nScale : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	noteDuration = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!isActive):
		return
	
	var targ = GetTarget(targetButton)
	self.rotate(3 * delta)
	
	if elapsed < noteDuration:
		elapsed += delta
		var nt = clamp(elapsed / noteDuration, 0.0, 1.0)
		var targScale = (self.position.distance_to(GetTarget(0).position)) / ($Border.texture.get_size().x/2) + 0
		self.scale = lerp(Vector2.ZERO, Vector2.ONE * targScale, nt)
		
		print()
		return
	
	# Keep moving the note towards outside the screen
	if elapsed >= 1:
		self.scale = lerp(Vector2.ZERO, Vector2.ONE * 5, 2 * delta)

	#if outside the hit threshold, miss
	if NoteSpawner.elapsed_time - data.hitTime > Globals.hitErrorThreshold:
		Deactivate()
	

func Activate(_data : Core_NoteData, target : int):
	data = _data
	targetButton = target
	elapsed = 0
	isActive = true
	self.visible = true
	self.scale = Vector2.ZERO

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
	
func Deactivate():
	isActive = false
	self.visible = false
	NotePool.ReturnToPool(self)
	
