extends Area2D


func _on_area_entered(area):
	var _areaParent = area.get_parent();
	if _areaParent.has_method("take_damage"):
		var _atk = Attack.new();
		_atk.attack_damage = get_parent().DAMAGE;
		_areaParent.take_damage(_atk);
	get_parent().die();
