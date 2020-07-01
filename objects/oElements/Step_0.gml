var delete_array = array_create(0);
for(var i = 0; i < ds_list_size(global.bolted); i++) {
	var instance = global.bolted[| i];
	if(instance[1] > 0) instance[1]--;
	else delete_array[array_length(delete_array)] = i;
}

for(var i = array_length(delete_array) - 1; i >= 0; i--) {
	ds_list_delete(global.bolted, delete_array[i]);
}