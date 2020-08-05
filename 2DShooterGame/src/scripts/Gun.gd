extends Pickable

export var bullet_speed: Vector2
var bullet_scene: PackedScene = preload("res://src/objects/Bullet.tscn")


func fire_bullet() -> void:
	var fire_velocity: Vector2
	fire_velocity.x = cos(player.global_rotation - deg2rad(90))
	fire_velocity.y = sin(player.global_rotation - deg2rad(90))
	fire_velocity *= bullet_speed
	
	var bullet = bullet_scene.instance()
	bullet.linear_velocity = fire_velocity
	bullet.global_position = global_position
	bullet.gravity_scale = 0
	bullet.global_rotation = player.global_rotation
	
	get_node("..").add_child(bullet)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and picked_up == true:
		fire_bullet()