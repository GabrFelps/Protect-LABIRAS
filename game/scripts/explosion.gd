extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D;

# Quando a animação de explosão acabar, a explosão é apagada do mundo
func _ready() -> void:
	await $Sprite.animation_finished;
	queue_free();


func _physics_process(_delta : float) -> void:
	# Desabilita a colisão em um determinado frame da animacao
	# a fim de inimigos não serem detectados por um tempo muito longo
	if ($Sprite.frame >= 2) and collision != null:
		collision.queue_free();


## Verifica se a explosão atingiu um inimigo
func _on_area_entered(area):
	var _attack = Attack.new();
	# pega o dano do canhão
	_attack.attack_damage = get_parent().get_node("Cannon").damage;
	
	# danifica o inimigo atingido, passando um objeto do tipo Attack
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(_attack);
	
