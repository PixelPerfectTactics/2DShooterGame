extends KinematicBody2D

export var speed: Vector2
export var sprint_boost: Vector2
var velocity: Vector2 = Vector2(0, 0)
var is_controller_connected = false
var controller_deadzone = 0.04
onready var name_tag = get_node("NameTag")


func _physics_process(delta: float) -> void:
	global_rotation = get_rotation()
	name_tag.set_rotation(-global_rotation)
	
	velocity = calculate_velocity(speed, sprint_boost) * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	
func _input(event):
	is_controller_connected = (event is InputEventJoypadMotion or event is InputEventJoypadButton)


func calculate_velocity(spd, boost) -> Vector2:
	var return_velocity: Vector2 = velocity
	
	return_velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return_velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if Input.is_action_pressed("sprint"):
		return_velocity *= spd + boost
	else:
		return_velocity *= spd
	
	return return_velocity


func get_rotation() -> float:
	var angle: float = self.global_rotation - deg2rad(90)
	
	if is_controller_connected:
		var direction = Vector2(Input.get_joy_axis(0, 2), Input.get_joy_axis(0, 3))
		
		if abs(direction.x) > controller_deadzone and abs(direction.y) > controller_deadzone:
			angle = direction.angle()
	else:
		var mouse_pos = get_global_mouse_position()
		var dx = mouse_pos.x - global_position.x
		var dy = mouse_pos.y - global_position.y
		angle = atan2(dy, dx)
	return angle + deg2rad(90)
