extends RigidBody2D

var player: KinematicBody2D
var detector: Area2D
var picked_up = false


func _ready() -> void:
	detector = get_node("PickUpDetector")


func _physics_process(delta: float) -> void:
	print(picked_up)
	if picked_up:
		global_position = player.get_node("GunPosition").global_position
		global_rotation = player.global_rotation + deg2rad(90)
		sleeping = true
	else:
		sleeping = false


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup"):
		if picked_up == false:
			var bodies = detector.get_overlapping_bodies()
			for body in bodies:
				if body.collision_layer == 1:
					picked_up = true
					player = body
		elif picked_up == true:
			picked_up = false
