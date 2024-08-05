extends RigidBody2D
class_name CannonBall

@onready var _camera = get_parent().get_node("Camera2D");

var explosion = preload("res://scenes/explosion.tscn");

## Verifica se bateu em algo explodível
func _on_hit_box_area_entered(area) -> void:
	explode();

## Faz uma explosão na área de contato e a adiciona na árvore de nós
func explode() -> void:
	var _boom = explosion.instantiate();
	_boom.global_position = self.global_position;
	get_parent().call_deferred("add_child", _boom);
	_camera.apply_shake();
	queue_free();
