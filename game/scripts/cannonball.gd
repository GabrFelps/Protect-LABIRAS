extends RigidBody2D
class_name CannonBall

var explosion = preload("res://scenes/explosion.tscn");

func _on_hit_box_area_entered(area) -> void:
	explode();

func explode() -> void:
	var _boom = explosion.instantiate();
	_boom.global_position = self.global_position;
	get_parent().call_deferred("add_child", _boom);
	queue_free();
