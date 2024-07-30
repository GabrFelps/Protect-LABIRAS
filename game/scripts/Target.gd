extends Area2D

@export var deathParticle : PackedScene;
@export var MAX_HEALTH : int = 1;

signal targetDown

var health : int

func _ready() -> void:
	health = MAX_HEALTH;
	
	
## Toma dano
func take_damage(attack: Attack):
	health -= attack.attack_damage; # diminui a vida
	if health <= 0:
		die();


func die():
	init_explosion();
	queue_free();
	emit_signal("targetDown");

## função para acionar partícula de explosão
func init_explosion() -> void:
	var _particle = deathParticle.instantiate();
	get_parent().add_child(_particle);
	_particle.global_position = self.global_position;
	_particle.global_rotation = self.global_rotation;
	_particle.emitting = true;
	
