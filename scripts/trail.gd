extends Line2D

var point

func _ready() -> void:
	set_as_top_level(true)

func _process(delta: float) -> void:
	var moving_forward = Input.get_axis("forward", "backwards") != 0
	var turning = Input.get_axis("turn_anticlockwise", "turn_clockwise") != 0
	
	point = get_parent().global_position
	if moving_forward and turning:
		add_point(point)
	if points.size() > 7:
		remove_point(0)
