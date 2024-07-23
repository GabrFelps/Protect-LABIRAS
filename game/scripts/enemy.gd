extends CharacterBody2D

@export var MAX_HEALTH : int = 3

var health : int

func _ready() -> void:
	health = MAX_HEALTH;
	velocity.x = -50; # velocidade inicial de tese

## Toma dano
func take_damage(attack: Attack):
	health -= attack.attack_damage; # diminui a vida
	if health <= 0:
		queue_free();

func _physics_process(delta):
	move_and_slide(); # movimento
