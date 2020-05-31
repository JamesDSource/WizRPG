function approach(a, b, amount) {
	if (a < b) {
	    a += amount;
	    if (a > b)
	        return b;
	}
	else {
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}

function get_delta() {
	var target_delta = 1/60; // we're measuring in miliseconds
	var delta = delta_time/1000000;
	return delta/target_delta;
}