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

function wave(from, to, duration, offset) {
	a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi*2)) * a4;
	
}