// #ifdef GL_ES
// 	precision mediump float;
// #endif
//
// #extension GL_OES_standard_derivatives : enable
//
uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

uniform sampler2D backbuffer;

const bool high_life = false;

void main(void) {
	// get the current normalized position

	mediump vec2 iPos = floor(gl_FragCoord.xy);
	vec2 st = gl_FragCoord.xy / resolution.xy;
	mediump vec2 iMouse = floor(mouse*resolution.xy);

	vec4 color=texture2D(backbuffer,st);
	vec2 pixel = 1./resolution;


	vec2 radius=vec2(16.0)/resolution;
	float nx=1.0/resolution.x;
	float ny=1.0/resolution.y;

	int sum = 0;
	if (texture2D(backbuffer,st+vec2(-nx,ny)).g>0.9)	sum+=1;
	if (texture2D(backbuffer,st+vec2(0.,ny)).g>0.9) 	sum+=1;
	if (texture2D(backbuffer,st+vec2(nx,ny)).g>0.9) 	sum+=1;
	if (texture2D(backbuffer,st+vec2(-nx,0.)).g>0.9) 	sum+=1;
	if (texture2D(backbuffer,st+vec2(nx,0.)).g>0.9) 	sum+=1;
	if (texture2D(backbuffer,st+vec2(-nx,-ny)).g>0.9) 	sum+=1;
	if (texture2D(backbuffer,st+vec2(0.,-ny)).g>0.9) 	sum+=1;
	if (texture2D(backbuffer,st+vec2(nx,-ny)).g>0.9)	sum+=1;

	if (high_life && (sum==3 || sum==6) || (sum==3)) {
		color=vec4(1.0);
	} else if (sum<2 || sum>3) {
		if (color.r!=0.){
//			vec3 new_rgb = max(color.rgb - vec3(0.1),vec3(0.1,0.1,0.15));
			vec3 new_rgb = vec3(0.,0.2,0.2);
			color=vec4(new_rgb,1.);
		}

	}
	float r = 0.03;

	// draw r pentonimo under mouse cursor
	if (
		iPos == iMouse.xy
	   	|| iPos == iMouse.xy + vec2(0.,1.)
	   	|| iPos == iMouse.xy + vec2(0.,-1.)
	   	|| iPos == iMouse.xy + vec2(-1.,0.)
		|| iPos == iMouse.xy + vec2(1.,1.)
	) {
		color = vec4(0.5,1.,0.,1.);
	}


	gl_FragColor = color;
}
