extends Area2D

func _physics_process(delta):
	look_to_mouse($CannonBarrel);


func look_to_mouse(node):
	node.look_at(get_global_mouse_position());
	node.rotation_degrees = clamp(rad_to_deg(get_angle_to(get_global_mouse_position())),-60,60);
