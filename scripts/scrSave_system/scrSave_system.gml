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
		var player_storage_main = ds_list_create();
		ds_map_add_list(player_storage, "main", player_storage_main);
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
			
				item_map[? "name"] = current_item.name;
				item_map[? "type"] = current_item.type;
				item_map[? "sprite"] = sprite_get_name(current_item.sprite);
				item_map[? "icon"] = sprite_get_name(current_item.icon);
				item_map[? "action"] = current_item.action;
				
				// adds spell components if the item is a spell
				if(current_item.type == ITEMTYPE.SPELL) {
					var spell_components_map = ds_map_create();
					spell_components_map[? "base"] = current_item.components.base;
					spell_components_map[? "element_type"] = current_item.components.element_type;
					
					ds_map_add_map(item_map, "components", spell_components_map);
				}
				else item_map[? "components"] = -1;
			
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
					entity_save_data[? "object name"] = object_get_name(object_index);				
					entity_save_data[? "x"] = x;				
					entity_save_data[? "y"] = y;				
					entity_save_data[? "z"] = z;											
				
					ds_list_add(room_data, entity_save_data);
					ds_list_mark_as_map(room_data, ds_list_find_index(room_data, entity_save_data));
				}
			}
		#endregion
		
		#region player
			if(instance_exists(oPlayer)) {
				var player_data = save_data[? "player"];
				with(oPlayer) {
					var storage_main = main;
					var storage_toolbar = toolbar;
					var storage_spells = spells;
					var storage_charms = charms;
				}
			
				// storage
				storage_encode(storage_main, player_data[? "storage"][? "main"]);
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