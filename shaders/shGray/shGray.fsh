//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
	float average = (col.r + col.g + col.b)/3.0;
    gl_FragColor = vec4(vec3(average), col.a);
}
