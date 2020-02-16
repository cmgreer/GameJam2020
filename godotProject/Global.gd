extends Node



#character_status 0==dead/not unlocked, 1==injured, 2==Healthy
var character_status = [2,0,2,2,2,2,2]
var character_name = ["Player", "Hunter", "Witch", "Dwarf", "Brad Bart", "Woodsman", "Tinker"]

var player_frozen = false

var playerPosition = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
