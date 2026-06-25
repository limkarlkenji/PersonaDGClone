extends Node

@export var particle : CPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particle.connect("finished", Callable(self, "_on_particles_finished"))

func _on_particles_finished():
	NoteParticlePool.ReturnToPool(particle)
	
