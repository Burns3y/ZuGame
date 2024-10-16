extends Node2D

var oscar_is_in_water: bool = false
var zu_is_in_water: bool = true
var players_exiting = 0

var zoom = Vector2(0.7, 0.7)
var target_zoom = Vector2(1.5, 1.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Door/AnimationPlayer.play("doors_opening")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Zooms camera into scene at start
	if $Camera2D.zoom != target_zoom and $Door.frame_coords.x == 6:
		zoom_camera(delta)
		
	#If both players are in their exit spots
	if players_exiting == 2:
		disappear_players(true, true)
		players_exiting = 100


#If in water
func _on_water_body_entered(body):
	#Water physics (general_movement script)
	if body.name == "Oscar":
		$Oscar.swimming_physics(body.name, true)
	elif body.name == "Zu":
		$Zu.swimming_physics(body.name, true)


#Exits water
func _on_water_body_exited(body):
	#Resets physics (general movement script)d
	if body.name == "Oscar":
		$Oscar.swimming_physics(body.name, false)
	elif body.name == "Zu":
		$Zu.swimming_physics(body.name, false)

#When the player enteres the acid
func _on_acid_body_entered(body):
	#Plays player dying function
	player_dies(body)

#If player dies
func player_dies(player):
	player.visible = false

#Plays disappear animation
func disappear_players(Oscar_disappear, Zu_disappear):
	get_tree().paused = true
	if Oscar_disappear:
		$Oscar/AnimationPlayer.play("disappear")
	if Zu_disappear:
		$Zu/AnimationPlayer.play("disappear")


#Checks if the players are inside the areas
func _on_exit_area_zu_body_entered(body):
	if body.name == "Zu":
		players_exiting += 1

func _on_exit_area_zu_body_exited(body):
	if body.name == "Zu":
		players_exiting -= 1

func _on_exit_area_oscar_body_entered(body):
	if body.name == "Oscar":
		players_exiting += 1

func _on_exit_area_oscar_body_exited(body):
	if body.name == "Oscar":
		players_exiting -= 1


func zoom_camera(delta):
	zoom = zoom.slerp(target_zoom, 3 * delta)
	$Camera2D.zoom = zoom
