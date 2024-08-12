extends Area2D


func _on_area_entered(area):
	var _areaParent = area.get_parent();
	if _areaParent.has_method("take_damage"):
		var _atk = Attack.new();
		_atk.attack_damage = get_parent().DAMAGE;
		_areaParent.take_damage(_atk);
		show_damage_label(_atk.attack_damage)
		
	get_parent().die(true);
	
func show_damage_label(points):
	var _damageLabel = PointsLabel.new();
	_damageLabel.text = "- " + str(points)+ "HP";
	_damageLabel.scale = Vector2(2.0, 2.0);
	_damageLabel.modulate = Color.RED;
	_damageLabel.global_position = get_parent().global_position - (Vector2(32.0, 20.0) * _damageLabel.scale.x);
	get_parent().get_parent().add_child(_damageLabel);
