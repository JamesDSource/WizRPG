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
		ds_map_add_list(player_storage, "charms", player_storage_charms);
	
		ds_map_add_map(player, "storage", player_storage);
	
	
		ds_map_add_map(new_save, "player", player);
	#endregion
	
	save_json_to_file(SAVEFILENAME + string(numb) + SAVEFILETYPE, new_save);
	ds_map_destroy(new_save);
}

// encoding item data into a list from storage
function storage_encode(storage, list) {
	ds_list_clear(list);
	var grid = storage.grid;
	for(var r = 0; r < ds_grid_width(grid); r++) {
		for(var c = 0; c < ds_grid_height(grid); c++) {
			var current_item = grid[# r, c];
			if(is_struct(current_item)) {
				var item_map = ds_map_create();
			
				ds_map_add(item_map, "name", current_item.name);
				ds_map_add(item_map, "type", current_item.type);
				ds_map_add(item_map, "sprite", sprite_get_name(current_item.sprite));
				ds_map_add(item_map, "icon", sprite_get_name(current_item.icon));
				ds_map_add(item_map, "action", current_item.action);
			
				ds_list_add(list, item_map);
				ds_list_mark_as_map(list, ds_list_find_index(list, item_map));
			}
		}
	}
	
	return ds_list_size(list);
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
		
		#region player
			if(instance_exists(oPlayer)) {
				var player_data = save_data[? "player"];
				with(oPlayer) {
					var storage_inventory = inventory;
					var storage_toolbar = toolbar;
					var storage_spells = spells;
					var storage_charms = charms;
				}
			
				// storage
				storage_encode(storage_inventory, player_data[? "storage"][? "inventory"]);
				storage_encode(storage_toolbar, player_data[? "storage"][? "toolbar"]);
				storage_encode(storage_spells, player_data[? "storage"][? "spells"]);
				storage_encode(storage_charms, player_data[? "storage"][? "charms"]);
			
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