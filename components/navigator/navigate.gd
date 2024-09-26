extends NavigationAgent2D

signal next_position_changed(pos)
@onready var rays = $"../Rays"
@onready var front_ray = $"../Rays/Front"

var no_progress_timer : Timer = Timer.new()
var lowest_distance: float = INF
var last_path_index: int = INF

func _ready():
	no_progress_timer.one_shot = true
	no_progress_timer.wait_time = .2
	add_child(no_progress_timer)
	path_desired_distance = 5.0
	target_desired_distance = 5.0
	for ray in rays.get_children():
		ray.add_exception(owner)
	path_changed.connect(_on_path_changed)

func _on_path_changed():
	lowest_distance = INF
	last_path_index = INF

func copy_ray(ray: RayCast2D, offset: Vector2) -> RayCast2D:
	var ray_copy = RayCast2D.new()
	ray_copy.position = ray.position + offset
	ray_copy.target_position = ray.target_position + offset
	ray_copy.rotation = ray.rotation
	ray_copy.add_exception(owner)
	ray_copy.hit_from_inside = true
	return ray_copy

func step():
	var pos = get_next_path_position()
	var path_index = get_current_navigation_path_index()
	var old_distance_to_next_path_position = pos.distance_to(owner.global_position)
	rays.rotation = owner.global_position.angle_to_point(pos)
	
	if path_index != last_path_index:
		lowest_distance = INF
		last_path_index = path_index
			
	owner.velocity = Vector2.ZERO
	
	for ray : RayCast2D in rays.get_children():
		#var ray_up = copy_ray(ray, Vector2(10,0).rotated(ray.rotation))
		#var ray_down = copy_ray(ray, Vector2(-10,0).rotated(ray.rotation))
		if not ray.is_colliding():
			owner.velocity = Vector2.RIGHT.rotated(rays.rotation + ray.rotation) * owner.speed
			break
	
	owner.move_and_slide()
	
	var new_distance_to_next_path_position = pos.distance_to(owner.global_position)
	
	var progress = lowest_distance - new_distance_to_next_path_position
	
	if progress > 0.1:
		print(progress)
		lowest_distance = new_distance_to_next_path_position
		no_progress_timer.start()
	
	if no_progress_timer.is_stopped():
		print(progress)
		print('stuck')
		return false
		
	return true
