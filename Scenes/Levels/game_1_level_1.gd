extends Node2D

var oscar_is_in_water: bool = false
var zu_is_in_water: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_water_body_entered(body):
	if body.name == "Oscar":
		$Oscar.swimming_physics(body.name, true)
		$Oscar.velocity.y = 0
	elif body.name == "Zu":
		$Zu.swimming_physics(body.name, true)
		$Zu.velocity.y /= 4



func _on_water_body_exited(body):
	if body.name == "Oscar":
		$Oscar.swimming_physics(body.name, false)
	elif body.name == "Zu":
		$Zu.swimming_physics(body.name, false)
