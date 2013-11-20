varying vec4 color;
varying vec2 texcoord;

void main()
{	
	gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	
	vec4 point = gl_ModelViewMatrix * gl_Vertex;
	
	texcoord = vec2(gl_MultiTexCoord0);
	
	float b = 0.4708;
	float f = 0.1;
	float s = 1;
	
	float z = (point[2]);
	float w = (point[3]);
	
	if (z > 0)
		z = 0;
		
	float d = (400*s*f*b)/(abs(-z)) / 255;
	
	d = -0.007*z;

    color[0] = d;
    color[1] = d;
    color[2] = d;
    color[3] = 1.0;
	
	//color[0] = mod(gl_Vertex[0] * 10000, 127) / 127;
	//color[1] = mod(gl_Vertex[1] * 10000, 127) / 127;
	//color[2] = mod(gl_Vertex[2] * 10000, 127) / 127;
}