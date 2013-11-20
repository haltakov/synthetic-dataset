varying vec3 eyespace_view_direction;
varying float q; //equivalent to gl_ProjectionMatrix[2].z
varying float qn; //equivalent to gl_ProjectionMatrix[3].z

uniform float znear;

void main()
{
	// Transforming the vertex
	vec4 pos = gl_ModelViewMatrix * gl_Vertex;
	gl_Position = gl_ProjectionMatrix * pos;
	vec3 pos3 = pos.xyz;
	
	eyespace_view_direction = vec3(gl_MultiTexCoord1);
	
	float zfar = -gl_MultiTexCoord1.z;
	float depth = zfar - znear;
	q = -(zfar+znear)/depth;
	qn = -2.0*(zfar*znear)/depth;
}
