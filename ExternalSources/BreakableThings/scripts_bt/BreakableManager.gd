extends Node2D

@onready var tilemap = $TileMap
const DESTROYED_FLAG = -1

func _ready():
	pass 

func _unhandled_input(event):
	if event.is_action_pressed("Left Click"):
		damage_block(get_global_mouse_position())

func damage_block(pos, damage = 1):
	
	#Convert the pos to Vector2i tilemap
	if pos is Vector2:
		pos = tilemap.local_to_map(pos)
		
	#Get atlas coordinates from the tileset
	var atlas_coord = tilemap.get_cell_atlas_coords(0,pos,true)
	
	#Retreive the block type from position
	var block_type = retrieve_terrain(pos)
	
	#Variable to store the next atlas coordinates This is so we can check if the tile been destroyed
	var new_atlas_coord
	
	#Check Tile's atlas coordinate if its valid
	if atlas_coord != Vector2i(-1,-1):
		AudioManager.play_audio("STONE_HIT")
		var new_cell_atlas_cord = atlas_coord - Vector2i(damage,0)
		tilemap.set_cell(0, pos, 1, new_cell_atlas_cord)
		new_atlas_coord = tilemap.get_cell_atlas_coords(0,pos,true)
		#Check again if negative destroy block
		if new_atlas_coord.x <= -1:
			destroy_block(pos,atlas_coord, block_type)

	#Return new atlas coord
	return new_atlas_coord

# Create same terrain phsyics block to fall and create particles on click
func spawn_block_particles(block_type = "DIRT", max_particles = 6, pos = Vector2(0,0), start_collision = true):
	#TODO() this is a fucking json make a folder add json data read from there. Even read globaly start of game.
	var block_types = {
	"DIRT": {"PARTICLE_TYPE":"DIRT"}, 
	"STONE": {"PARTICLE_TYPE":"STONE"}, 
	"SAND": {"PARTICLE_TYPE":"DIRT"}, 
	"BRICK": {"PARTICLE_TYPE":"STONE"}
	}
	if block_type in block_types:
		if "PARTICLE_TYPE" in block_types[block_type]:
			block_type = block_types[block_type]["PARTICLE_TYPE"]
	var particles_amount = randi_range(1,max_particles)
	for i in range(particles_amount):
		#Instantiate particle
		var block_particle = load("res://ExternalSources/BreakableThings/physics-block/BlockParticle.tscn").instantiate()
		add_child(block_particle)
		block_particle.setup(pos, block_type, start_collision)

func destroy_block(pos,atlas_coord,block_type = "DIRT", apply_force = true):
	#Setting the cell in the tilemap to negative value to erase
	tilemap.set_cell(0,pos,0,Vector2(-1,-1))
	#Load Phsyics block
	var physics_block = load("res://ExternalSources/BreakableThings/physics-block/PhysicsBlock.tscn").instantiate()
	self.add_child(physics_block)
	#Setup function to instantiate proper block matching to destroyed
	physics_block.setup(atlas_coord,tilemap.map_to_local(pos),block_type, apply_force)
	#Spawn some particles with them.
	spawn_block_particles(block_type, 4, tilemap.map_to_local(pos))

func retrieve_terrain(pos):
	#Convert the pos to Vector2i tilemap
	if pos is Vector2:
		pos = tilemap.local_to_map(pos)
	#Get the cell data at the position
	var tile_data = tilemap.get_cell_tile_data(0,pos,true)
	#Variable to store the name
	var terrain_string
	#Checks if there is tile at the position
	if tile_data:
		var terrain_set = tile_data.terrain_set
		var terrain_id = tile_data.terrain
		terrain_string = tilemap.tile_set.get("terrain_set_%s/terrain_%s/name"%[terrain_set,terrain_id])
		print(terrain_string)
	return terrain_string
