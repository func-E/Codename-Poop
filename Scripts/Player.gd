extends KinematicBody2D

export var weaponsList = 	[false, 	false,  	false]
						#pistol,	dualUzis, 	shotgun
var inventory = []
var selectedSlot = 0

export var maxHealth = 20
export var health = 20
signal updateHealth(new_health)
export var maxAmmo = 100
export var ammo = 100
signal updateAmmo(new_ammo)

func _ready():
	Update_Inventory()


export var maxSpeed = 40000
export var playerAcceleration = 0.15
var velocity = Vector2(0,0)

export var cameraLag = 40
export var cameraSpeed = 0.2
export var cameraRange = 0.1
export var aimSnapiness = 0.5

func _process(delta):
	#movement
	var target_move_vec = Vector2(0,0)
	if Input.is_action_pressed("moveUp"):
		target_move_vec.y -= 1
	if Input.is_action_pressed("moveDown"):
		target_move_vec.y += 1
	if Input.is_action_pressed("moveLeft"):
		target_move_vec.x -= 1
	if Input.is_action_pressed("moveRight"):
		target_move_vec.x += 1
	target_move_vec = target_move_vec.normalized()
	velocity = lerp(velocity, target_move_vec, playerAcceleration)
	move_and_slide(velocity * maxSpeed * delta)
	
	#looking and camera stuff
	$PlayerCamera.position = lerp($PlayerCamera.position, get_global_mouse_position() * cameraRange + -velocity * cameraLag, cameraSpeed) #moving the camera around so you can see farther in the direction you're pointing
	$PlayerSprite.rotation = lerp_angle($PlayerSprite.rotation, get_local_mouse_position().angle(), aimSnapiness) #rotating the player to face the mouse pointer
	
	if Input.is_action_pressed("Fire") and inventory != []:
		get_node("PlayerSprite").get_node(inventory[selectedSlot]).Shoot()

func _physics_process(delta):
	
	pass

func _input(event):
	#scrolling through the inventory
	if (Input.is_action_just_pressed("nextWeapon") or (event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_WHEEL_DOWN)) and inventory != []:
		selectedSlot += 1
		if selectedSlot > inventory.size() - 1:
			selectedSlot = 0
		print(inventory[selectedSlot])
		ShowHeldWeapon()
	elif (Input.is_action_just_pressed("prevWeapon") or (event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_WHEEL_UP)) and inventory != []:
		selectedSlot -= 1
		if selectedSlot < 0:
			selectedSlot = inventory.size() - 1
		print(inventory[selectedSlot])
		ShowHeldWeapon()

func Update_Inventory():
	inventory = []
	if weaponsList[0]:
		inventory.append("Pistol")
	if weaponsList[1]:
		inventory.append("DualUzis")
	if weaponsList[2]:
		inventory.append("Shotgun")
	ShowHeldWeapon()

func ShowHeldWeapon():
	for i in range(0,inventory.size(),1):
			if i == selectedSlot:
				get_node("PlayerSprite").get_node(inventory[i]).visible = true
			else:
				get_node("PlayerSprite").get_node(inventory[i]).visible = false

func AddAmmo(amount):
	ammo += amount
	ammo = clamp(ammo,0,maxAmmo)
	emit_signal("updateAmmo", ammo)

func ConsumeAmmo(amount):
	ammo -= amount
	ammo = clamp(ammo,0,maxAmmo)
	emit_signal("updateAmmo", ammo)

func Damage(damage):
	var damage_left = damage - health
	health -= damage
	emit_signal("updateHealth", health)
	if health < 1:
		get_tree().reload_current_scene() #placeholder for dieing
	return damage_left

func Heal(amount):
	health += amount
	health = clamp(health, 0, maxHealth)
	emit_signal("updateHealth", health)
