function array_find_index(array, value) {
	var result = -1;
	for(var i = 0; i < array_length(array); i++) {
		if(array[i] == value) {
			result = i;
			break;
		}
	}
	
	return result;
}