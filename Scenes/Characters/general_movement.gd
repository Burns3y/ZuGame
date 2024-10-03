extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
var new_jump_velocity = JUMP_VELOCITY

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

	if Input.is_action_just_pressed(JUMP) and is_on_floor():
		velocity.y = new_jump_velocity
	#If in water, doesn't need to be on floor
	elif Input.is_action_pressed(JUMP) and JUMP_VELOCITY / 20 == new_jump_velocity and velocity.y >= -150:
		velocity.y += new_jump_velocity
		

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis(LEFT,RIGHT)
	#If player is moving
	if direction:
		#Plays animation and moves
		$AnimationPlayer.play("running")
		velocity.x = direction * SPEED
		#Flips image based on direction
		if direction == -1:
			$Image.flip_h = true
			if self.name == "Zu":
				$Image.offset.x = 17
			elif self.name == "Oscar":
				$Image.offset.x = 27
		elif direction == 1:
			$Image.flip_h = false
			$Image.offset.x = 0
	#If standing still
	else:
		#Stops movement and animation
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.stop()
		#Goes to idle frame
		$Image.frame_coords = Vector2(0, 2)


	move_and_slide()

func swimming_physics(body, is_in_water):
	
	#self.name == body ensures it only applies to the character in the water
	if is_in_water and str(self.name) == str(body):
		#Slower gravity
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 5
		#Less jump
		new_jump_velocity = JUMP_VELOCITY / 20
		if Input.is_action_pressed(JUMP):
			velocity.y += 1200
		
	elif not is_in_water and str(self.name) == str(body):
		#Resets jump and gravity
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		new_jump_velocity = JUMP_VELOCITY
		#velocity.y -= 25

