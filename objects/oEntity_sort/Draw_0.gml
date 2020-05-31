var amount = instance_number(oEntity);
ds_grid_resize(depth_grid, 2, amount);

var index = 0;
with(oEntity) {
	other.depth_grid[# 0, index] = bbox_bottom;
	other.depth_grid[# 1, index] = id;
	index++;
}

ds_grid_sort(depth_grid, 0, true);

for(var i = 0; i < amount; i++) {
	var inst = depth_grid[# 1, i];	
	with(inst) event_perform(ev_draw, 0);
}