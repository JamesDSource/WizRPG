varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vCorner;

uniform vec3 spell_color;

void main() {
    vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float alpha;
	if(base_col.a < 0.001) {
		alpha = 0.0;
	}
	else {
		alpha = smoothstep(0.1, 1.0, v_vCorner.x)/2.0;	
	}
	
	gl_FragColor = vec4(spell_color, alpha);
}
