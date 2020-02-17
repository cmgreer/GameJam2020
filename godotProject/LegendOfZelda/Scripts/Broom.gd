extends KinematicBody2D

export var speed = 200

var velocity = Vector2()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_sync_to_physics(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (globalSingleton.player_frozen >= 0):
		var distance=self.position-globalSingleton.playerPosition
		self.look_at(globalSingleton.playerPosition)
		if(abs(distance.x)+abs(distance.y)<300):
			velocity=polar2cartesian(1,self.rotation)
		else:
			velocity=Vector2.ZERO
		velocity = velocity.normalized() * speed * Vector2(-1,-1)
	# warning-ignore:return_value_discarded
		move_and_collide(velocity * delta)


func _on_Area2D_body_entered(body):
	if(body.get_name() == "Player"):
		globalSingleton.Items_collected.append($AnimatedSprite)
		globalSingleton.item_dictionary["Broom"] = true
		self.position=Vector2(5000,5000)
