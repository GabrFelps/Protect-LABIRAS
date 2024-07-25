extends CharacterBody2D

@export var my_key : String = ["porco", "café", "preguica", "prostiranha", "formiga"].pick_random();
@export var MAX_HEALTH : int = 3;
@export var DAMAGE : int = 20;
@export var SPEED : int = 12;
@export var POINTS : int = 10;
@onready var sprite_node : AnimatedSprite2D = get_node("Sprite"); 

# signal que é emitido quando todos os inimigos da wave atual morrerem
signal all_enemies_died;
var health : int

func _ready() -> void:
	Global.enemyNode = self;
	initialize()
	velocity.x = -SPEED; # velocidade inicial de tese
	health = MAX_HEALTH;

## Atualiza valores das variáveis conforme o banco de dados
func initialize():
	#print("atualizando variáveis do ", my_key)
	var enemy_struct = Global.get_enemy_struct(my_key);
	MAX_HEALTH = int(enemy_struct["max_health"])
	DAMAGE = int(enemy_struct["damage"])
	SPEED = int(enemy_struct["speed"])
	POINTS = int(enemy_struct["points"])
	sprite_node.sprite_frames = Global.get_enemy_sprite(my_key)	
	sprite_node.play()
	#print(my_key, " velocity: ", SPEED)
	
## Toma dano
func take_damage(attack: Attack):
	health -= attack.attack_damage; # diminui a vida
	if health <= 0:
		Global.dead_enemies_in_wave += 1;
		# verificando se a quantidade de inimigos mortos é igual ao quantidade max de inimigos da wave atual
		if (Global.dead_enemies_in_wave == Global.max_enemy_per_wave):
			emit_signal("all_enemies_died");
		queue_free();

func _physics_process(delta):
	move_and_slide(); # movimento
