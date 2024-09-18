extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1000.0

var JUMP
var LEFT
var RIGHT

func _ready():
	#Setting up the basic movement jeys
	if self.name == "Zu":
		JUMP = "Player1Jump"
		LEFT = "Player1Left"
		RIGHT = "Player1Right"
		
	elif self.name == "Oscar":
		JUMP = "Player2Jump"
		LEFT = "Player2Left"
		RIGHT = "Player2Right"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#If the player is in water
	if $"..".player_is_in_water == true:
		swimming_physics()
	
	#If the player is not in water, normal jump + gravity
	else:
		if Input.is_action_just_pressed(JUMP) and is_on_floor():
			velocity.y = JUMP_VELOCITY
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis(LEFT,RIGHT)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func swimming_physics():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 5
	if Input.is_action_pressed(JUMP):
			velocity.y = JUMP_VELOCITY / 5
	
