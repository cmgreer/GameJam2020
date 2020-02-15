extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camera_origin
var player_origin


# Called when the node enters the scene tree for the first time.
func _ready():
	player_origin=globalSingleton.playerPosition
	camera_origin=self.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
# warning-ignore:standalone_expression
	self.position = camera_origin+globalSingleton.playerPosition-Vector2(0,1493.96)+Vector2(0,1600.73)
