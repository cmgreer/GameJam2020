extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var status

func color_status():
	for i in range(1,7):
		status = globalSingleton.character_status[i]
		if status == 0: #dead/not unlocked
			get_child(i).get_child(1).color = Color(0.235, 0.156, 0.156, 0.7)
		elif status == 1: #injured
			get_child(i).get_child(1).color = Color(0.7, 0.188, 0.188, 0.3)
		elif status ==2: #healthy
			get_child(i).get_child(1).color = Color(0,0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	color_status()


		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
