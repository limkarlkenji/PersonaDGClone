extends Note
class_name LongNote

@export var head: Node2D
@export var body: Line2D
@export var tail: Node2D
var isHolding: bool
var tailTimer: float
var tailElapsed : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if(!isActive):
		return

	# Connect head and tail
	body.points[0] = body.to_local(head.global_position)
	body.points[1] = body.to_local(tail.global_position)

	# Move the tail on time
	tailTimer += delta
	if tailTimer > data.duration:
		if tailElapsed < noteDuration:
			tailElapsed += delta
			var tailT = clamp(tailElapsed / noteDuration, 0.0, 1.0)
			tail.global_position = lerp(Globals.center.position, GetTarget(targetButton).position, tailT)
			tail.rotate(3 * delta)
			
	# Move head to target
	if elapsed < noteDuration:
		elapsed += delta
		var nt = clamp(elapsed / noteDuration, 0.0, 1.0)
		head.global_position = lerp(Globals.center.position, GetTarget(targetButton).position, nt)
		head.rotate(3 * delta)
		return
	
	# if outside the hit threshold, miss
	if NoteSpawner.elapsed_time - data.hitTime > Globals.hitErrorThreshold && !isHolding:
		Miss()
		Deactivate()
	
	# If the head has reached the target and the button is held, wait till the tail passes to call miss
	if isHolding && tailElapsed < 1:
		return
	

func Hold():
	isHolding = true

func Release():
	isHolding = false
	
func Activate(_data : Core_NoteData, target : int):
	super.Activate(_data, target)
	tailTimer = 0
	tailElapsed = 0
	isHolding = false
	
