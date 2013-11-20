varying float z;
varying vec2 texcoord;

void main()
{	
	gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	
	vec4 point = gl_ModelViewMatrix * gl_Vertex;
	
	texcoord = vec2(gl_MultiTexCoord0);
		
	z = (point[2] / point[3]);
		
	if (z > 0)
		z = 0;
	
	//color[0] = mod(gl_Vertex[0] * 10000, 127) / 127;
	//color[1] = mod(gl_Vertex[1] * 10000, 127) / 127;
	//color[2] = mod(gl_Vertex[2] * 10000, 127) / 127;
}