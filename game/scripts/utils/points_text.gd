extends Label
class_name PointsLabel

func _ready():
	self.theme = load("res://assets/themes/menu.tres");
	fadeTextAnimation();
	set_process(false);
	await(get_tree().create_timer(1.3).timeout);
	set_process(true);

func _process(delta):
	visible = !visible;

func fadeTextAnimation():
	var _posTween = get_tree().create_tween();
	_posTween.tween_property(
		self,
		"position",
		Vector2(position.x, position.y - 32),
		2.0
	).set_trans(Tween.TRANS_SINE);
	await _posTween.finished;
	queue_free();
	
