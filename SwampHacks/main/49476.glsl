uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

#define PI 3.14159265359

float s(float x, float b)
{
  return 0.06+sin(x * 2. * PI * b) / b;
}

void main( void )
{
	vec2 position = ( gl_FragCoord.xy / resolution.xy );

	float x = position.x;
	float p = 0.0;
	float q = 0.01;
	for (float i = 1.0; i < 15.0; i += 1.0)
	{
	  p  += s(x + sin(0.05 * time*i), pow(2.1, i));
	  q *= s(x + sin(0.62 * time*i), pow(2.0, i));
	}
	p = 0.07+0.3 * p;
	q = 1.4 * p;

	float color =  0.021 / abs(p - position.y)
		     - 0.011 / abs(q - position.y);

	gl_FragColor = vec4( vec3(q*time/33., p*time/50., 10.0*sin(time))*color, 1.0 );
}
