extends KinematicBody2D

export var speed = 400

var velocity = Vector2()

func walk(vel):
	$Standing.hide()
	$WalkingBackward.hide()
	$WalkingForward.hide()
	$WalkingLeft.hide()
	$WalkingRight.hide()
	if(vel.x>0):
		$WalkingRight.show()
	elif(vel.x<0):
		$WalkingLeft.show()
	elif(vel.y>0):
		$WalkingForward.show()
	elif(vel.y<0):
		$WalkingBackward.show()
	else:
		$Standing.show()

func get_input():
	# Detect up/down/left/right keystate and only move when pressed
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if(not globalSingleton.player_frozen):
		get_input()
		move_and_collide(velocity * delta)
		walk(velocity)
		globalSingleton.playerPosition = get_position()
	else:
		walk(Vector2.ZERO)
