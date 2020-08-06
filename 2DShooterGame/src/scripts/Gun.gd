extends Pickable

export var bullet_speed: Vector2
var bullet_scene: PackedScene = preload("res://src/objects/Bullet.tscn")


func fire_bullet() -> void:
	var fire_velocity: Vector2
	fire_velocity.x = cos(player.global_rotation - deg2rad(90))
	fire_velocity.y = sin(player.global_rotation - deg2rad(90))
	fire_velocity *= bullet_speed
	
	var start_pos: Vector2 = global_position
	var offset: float = 30.0
	start_pos.x += cos(player.global_rotation - deg2rad(90)) * offset
	start_pos.y += sin(player.global_rotation - deg2rad(90)) * offset
	
	var bullet = bullet_scene.instance()
	bullet.linear_velocity = fire_velocity
	bullet.global_position = start_pos
	bullet.gravity_scale = 0
	bullet.global_rotation = player.global_rotation
	
	get_node("..").add_child(bullet)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and picked_up == true:
		fire_bullet()
