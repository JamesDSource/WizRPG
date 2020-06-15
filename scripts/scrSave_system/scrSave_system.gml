#macro SAVEFILENAME "save"
#macro SAVEFILETYPE ".arc"

function save_json_to_file(filename, map) {
	var str = json_encode(map);
	var save_buffer = buffer_create(string_byte_length(str)+1, buffer_fixed, 1);
	buffer_write(save_buffer, buffer_string, str);
	buffer_save(save_buffer, filename);
	buffer_delete(save_buffer);
}

function load_json_from_file(filename) {
	var save_buffer = buffer_load(filename);
	var str = buffer_read(save_buffer, buffer_string);
	buffer_delete(save_buffer);
	
	return json_decode(str);
}

// creating a save file
function init_save_file(numb) {
	var new_save = ds_map_create();
	
	// rooms
	var rooms = ds_map_create();
	ds_map_add_map(new_save, "rooms", rooms);
	
	#region player
		var player = ds_map_create();
		
		// stats
		var player_stats = ds_map_create();
		ds_map_add_map(player, "stats", player_stats);


		// storage
		var player_storage = ds_map_create();
		//		inventory
		var player_storage_inventory = ds_list_create();
		ds_map_add_list(player_storage, "inventory", player_storage_inventory);
		//		toolbar
		var player_storage_toolbar = ds_list_create();
		ds_map_add_list(player_storage, "toolbar", player_storage_toolbar);
		//		spells
		var player_storage_spells = ds_list_create();
		ds_map_add_list(player_storage, "spells", player_storage_spells);
		//		charms
		var player_storage_charms = ds_list_create();
		ds_map_add_list(player_storage, "toolbar", player_storage_charms);
	
		ds_map_add_map(player, "storage", player_storage);
	
	
		ds_map_add_map(new_save, "player", player);
	#endregion
	
	save_json_to_file(SAVEFILENAME + string(numb) + SAVEFILETYPE, new_save);
	ds_map_destroy(new_save);
}

// saving
function save(numb) {
	var file = SAVEFILENAME + string(numb) + SAVEFILETYPE;
	if(file_exists(file)) {
		var save_data = load_json_from_file(file);
		
		#region room data
			var room_string = room_get_name(room);
			var room_data = save_data[? "rooms"][? room_string];
		
			if(is_undefined(room_data)) {
				room_data = ds_list_create();
				ds_map_add_list(save_data[? "rooms"], room_string, room_data);	
			}
			else ds_list_clear(room_data);
			
			with(oEntity) {
				if(save_me) { 
					var entity_save_data = ds_map_create();	
					ds_map_add(entity_save_data, "object name", object_get_name(object_index));				
					ds_map_add(entity_save_data, "x", x);				
					ds_map_add(entity_save_data, "y", y);				
					ds_map_add(entity_save_data, "z", z);				
				
					ds_list_add(room_data, entity_save_data);
					ds_list_mark_as_map(room_data, ds_list_find_index(room_data, entity_save_data));
				}
			}
		#endregion
		save_json_to_file(file, save_data);
		ds_map_destroy(save_data);
	}
}

// loading save file
function load(numb) {
	var file = SAVEFILENAME + string(numb) + SAVEFILETYPE;
	if(file_exists(file)) {
		
	}
}