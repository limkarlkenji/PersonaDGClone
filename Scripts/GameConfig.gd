extends Node

@export_file("*.json") var song : String
@export var noteScene: PackedScene
@export var notePoolSize: int = 20
@export var longNoteScene: PackedScene
@export var longNotePoolSize: int = 20
@export var scratchNoteScene: PackedScene
@export var scratchNotePoolSize: int = 10
@export var particleScene: PackedScene
@export var particlePoolSize: int = 10

func _ready() -> void:
	await get_tree().process_frame
	SongReader.Load(song)
	NotePool.CreateNormal(noteScene, notePoolSize)
	NotePool.CreateLong(longNoteScene, longNotePoolSize)
	NotePool.CreateScratch(scratchNoteScene, scratchNotePoolSize)
	NoteParticlePool.Create(particleScene, particlePoolSize)
