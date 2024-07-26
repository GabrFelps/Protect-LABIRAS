extends CharacterBody2D

@export var my_key : String
@export var MAX_HEALTH : int = 3;
@export var DAMAGE : int = 20;
@export var SPEED : int = 12;
@export var POINTS : int = 10;
var wave_min : int;
@onready var sprite_node : AnimatedSprite2D = get_node("Sprite"); 
@onready var label = $Label

# signal que é emitido quando todos os inimigos da wave atual morrerem
signal all_enemies_died;
var health : int

func _ready() -> void:
	wave_min = int(Global.enemy_db.get(my_key).get("wave_min"));
	Global.enemyNode = self;
	initialize()
	velocity.x = -SPEED;
	health = MAX_HEALTH;
	label.text = my_key +"\nmax health: " + str(MAX_HEALTH);

## Atualiza valores das variáveis conforme o banco de dados
func initialize():
	#print("atualizando variáveis do ", my_key)
	var enemy_struct = Global.get_enemy_struct(my_key);
	MAX_HEALTH = int(enemy_struct["max_health"]);
	DAMAGE = int(enemy_struct["damage"]);
	SPEED = int(enemy_struct["speed"]);
	POINTS = int(enemy_struct["points"]);
	#sprite_node.sprite_frames = Global.get_enemy_sprite(my_key)
	#sprite_node.play()
	#print(my_key, " velocity: ", SPEED)
	
## Toma dano
func take_damage(attack: Attack):
	_hit_flash();
	health -= attack.attack_damage; # diminui a vida
	if health <= 0:
		Global.dead_enemies_in_wave += 1;
		# verificando se a quantidade de inimigos mortos é igual ao quantidade max de inimigos da wave atual
		if (Global.dead_enemies_in_wave == Global.max_enemy_per_wave):
			emit_signal("all_enemies_died");
		queue_free();

func _physics_process(delta):
	move_and_slide(); # movimento

func _hit_flash():
	var _hit_material = load("res://assets/shaders/hit_flash.gdshader");
	sprite_node.material = ShaderMaterial.new();
	sprite_node.material.shader = _hit_material;
	sprite_node.material.set("shader_parameter/active", true);
	await (get_tree().create_timer(0.15).timeout);
	sprite_node.material.set("shader_parameter/active", false);

