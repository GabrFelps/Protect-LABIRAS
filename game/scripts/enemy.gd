extends CharacterBody2D

@export var deathParticle : PackedScene;
@export var my_key : String
@export var MAX_HEALTH : int = 3;
@export var DAMAGE : int = 20;
@export var SPEED : int = 12;
@export var POINTS : int = 10;
var wave_min : int;
@onready var sprite_node : AnimatedSprite2D = get_node("Sprite"); 

# signal que é emitido quando todos os inimigos da wave atual morrerem
signal all_enemies_died;
var health : int

func _ready() -> void:
	wave_min = int(Global.enemy_db.get(my_key).get("wave_min"));
	Global.enemyNode = self;
	initialize();

	velocity.x = -SPEED * 15;
	health = MAX_HEALTH;
	

## Atualiza valores das variáveis conforme o banco de dados
func initialize():
	#print("atualizando variáveis do ", my_key)
	var enemy_struct = Global.get_enemy_struct(my_key);
	MAX_HEALTH = int(enemy_struct["max_health"]);
	DAMAGE = int(enemy_struct["damage"]);
	SPEED = int(enemy_struct["speed"]);
	POINTS = int(enemy_struct["points"]);
	
	
## Toma dano
func take_damage(attack: Attack):
	_hit_flash();
	health -= attack.attack_damage; # diminui a vida
	if health <= 0:
		die();

func _physics_process(delta):
	move_and_slide(); # movimento

func _hit_flash():
	var _hit_material = load("res://assets/shaders/hit_flash.gdshader");
	sprite_node.material = ShaderMaterial.new();
	sprite_node.material.shader = _hit_material;
	sprite_node.material.set("shader_parameter/active", true);
	await (get_tree().create_timer(0.15).timeout);
	sprite_node.material.set("shader_parameter/active", false);

func die():
	print("AIAIA")
	Global.dead_enemies_in_wave += 1;
	Global.points += POINTS;
	# verificando se a quantidade de inimigos mortos é igual ao quantidade max de inimigos da wave atual
	if (Global.dead_enemies_in_wave == Global.max_enemy_per_wave):
		emit_signal("all_enemies_died");
	init_explosion();
	queue_free();

## função para acionar partícula de explosão
func init_explosion() -> void:
	var _particle = deathParticle.instantiate();
	get_parent().add_child(_particle);
	_particle.global_position = self.global_position;
	_particle.global_rotation = self.global_rotation;
	_particle.emitting = true;
	
