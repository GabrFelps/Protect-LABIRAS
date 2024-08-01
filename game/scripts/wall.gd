extends Area2D

@export var MAX_HEALTH : float;
@onready var health: float;

@onready var health_particles : PackedScene = preload("res://scenes/health_particles.tscn");


func _ready():
	Global.update_game_properties.connect(update_max_health);
	Global.update_game_properties.connect(restore_health);
	Global.wave_changed.connect(restore_health);
	update_max_health();
	health = MAX_HEALTH;
	update_health_label();
	restore_health();

## Atualiza a vida máxima do muro com base no banco de dados do jogo
func update_max_health():
	MAX_HEALTH = int(Global.game_db[str(Global.current_wave)]["wall_health"]);
	print("wall health: ", MAX_HEALTH);

# Restaura 15% do hp do muro
func restore_health():
	var _prevHealth = health;
	health = clamp(health+(MAX_HEALTH*0.15), 0, MAX_HEALTH);
	var _particles : CPUParticles2D = health_particles.instantiate();
	_particles.emitting = true;
	add_child(_particles);
	update_health_label();
	get_parent().update_healthbar(MAX_HEALTH, health, health/MAX_HEALTH * 100);

## Toma dano
func take_damage(attack : Attack):
	var _prevHealth = health;
	health -= attack.attack_damage;
	if health <= 0:
		pass;
	update_health_label();
	get_parent().update_healthbar(MAX_HEALTH, max(health, 0), (health/MAX_HEALTH * 100));

func update_health_label():
	$Label.text = "Health: " + str(int(health)) + "\nMax Health: " + str(int(MAX_HEALTH));

