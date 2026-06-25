extends Node

var pool: Array[CPUParticles2D]
var missPool : Array[CPUParticles2D]

# Called when the node enters the scene tree for the first time.
func Create(particleScene : PackedScene, initialSize : int) -> void:
	for i in initialSize:
		var particle = particleScene.instantiate() as CPUParticles2D
		add_child(particle)
		particle.emitting = false
		pool.push_back(particle)
		
func CreateMiss(missParticleScene: PackedScene, initialSize : int) -> void:
	for i in initialSize:
		var particle = missParticleScene.instantiate() as CPUParticles2D
		add_child(particle)
		particle.emitting = false
		missPool.push_back(particle)

func GetMiss(position : Vector2) -> CPUParticles2D:
	var particle = missPool.pop_front()
	particle.position = position
	particle.emitting = true
	return particle

func ReturnMiss(particle : CPUParticles2D) -> void:
	missPool.push_back(particle)

func Get(position : Vector2) -> CPUParticles2D:
	var particle = pool.pop_front()
	particle.position = position
	particle.emitting = true
	return particle
	
func ReturnToPool(particle : CPUParticles2D) -> void:
	pool.push_back(particle)
