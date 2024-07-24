extends CharacterBody2D

@export var my_key : String = ["porco", "café", "preguica"].pick_random();
@export var MAX_HEALTH : int = 3;
@export var DAMAGE : int = 20;
@export var SPEED : int = 12;
@export var POINTS : int = 10;
@onready var sprite_node : AnimatedSprite2D = get_node("Sprite"); 

var health : int

func _ready() -> void:
	health = MAX_HEALTH;
	velocity.x = -50; # velocidade inicial de tese
	initialize()

## Atualiza valores das variáveis conforme o banco de dados
func initialize():
	print("atualizando variáveis do ", name)
	var enemy_struct = Global.get_enemy_struct(my_key);
	MAX_HEALTH = int(enemy_struct["max_health"])
	DAMAGE = int(enemy_struct["damage"])
	SPEED = int(enemy_struct["speed"])
	POINTS = int(enemy_struct["points"])
	sprite_node.sprite_frames = Global.get_enemy_sprite(my_key)	
	sprite_node.play()
	
## Toma dano
func take_damage(attack: Attack):
	health -= attack.attack_damage; # diminui a vida
	if health <= 0:
		queue_free();

func _physics_process(delta):
	move_and_slide(); # movimento
