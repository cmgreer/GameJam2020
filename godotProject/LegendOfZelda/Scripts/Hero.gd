extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pop = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_7UP_body_entered(body):
	if(body.get_name() == "Player"):
		pop = get_child(2)
		pop.popup_centered(Vector2(100,50))
		pop.set_position(get_position()+Vector2(-50, -20))
	

