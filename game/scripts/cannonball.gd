extends RigidBody2D

func _on_hit_box_area_entered(area):
	print("COLIDIU BATEU EITA PESTE");
	queue_free();
