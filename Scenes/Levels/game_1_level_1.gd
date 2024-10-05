extends Node2D

var oscar_is_in_water: bool = false
var zu_is_in_water: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#If in water
func _on_water_body_entered(body):
	#Water physics (general_movement script)
	if body.name == "Oscar":
		$Oscar.swimming_physics(body.name, true)
	elif body.name == "Zu":
		$Zu.swimming_physics(body.name, true)


#Exits water
func _on_water_body_exited(body):
	#Resets physics (general movement script)
	if body.name == "Oscar":
		$Oscar.swimming_physics(body.name, false)
	elif body.name == "Zu":
		$Zu.swimming_physics(body.name, false)


func _on_acid_body_entered(body):
	player_dies(body)
	print(str(body), "died")


func player_dies(player):
	player.visible = false
