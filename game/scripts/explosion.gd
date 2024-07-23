extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D;

func _ready() -> void:
	await $Sprite.animation_finished;
	queue_free();

func _physics_process(_delta : float) -> void:
	if ($Sprite.frame >= 2) and collision != null:
		collision.queue_free();


func _on_area_entered(area):
	var _attack = Attack.new()
	#_attack.attack_damage = damage;
