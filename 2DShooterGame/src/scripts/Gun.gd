extends Area2D

var player: KinematicBody2D
var gun: RigidBody2D
var picked_up = false


func _ready() -> void:
	gun = get_node("..")


func _physics_process(delta: float) -> void:
	print(picked_up)
	if picked_up:
		gun.global_position = player.get_node("GunPosition").global_position
		gun.global_rotation = player.global_rotation
		gun.sleeping = true
	else:
		gun.sleeping = false


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup"):
		if picked_up == false:
			var bodies = get_overlapping_bodies()
			for body in bodies:
				if body.collision_layer == 1:
					picked_up = true
					player = get_node("../../Player")
		elif picked_up == true:
			picked_up = false
