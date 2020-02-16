extends Node



#character_status 0==dead/not unlocked, 1==injured, 2==Healthy
var character_status = [2,0,2,0,1,1,0]
var character_name = ["Player", "Hunter", "Witch", "Dwarf", "Brad Bard", "Woodsman", "Tinker"]
var next_scene = 1
var beast_status = 1 #beast alive
var witch_potion = 1 #num of witch potions
var injured_char
var run_beast = 0

var player_frozen = 0

var playerPosition = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
