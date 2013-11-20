varying vec4 old_pos;
varying vec4 new_pos;

attribute vec4 oldModelViewMatrix1;
attribute vec4 oldModelViewMatrix2;
attribute vec4 oldModelViewMatrix3;
attribute vec4 oldModelViewMatrix4;
varying vec2 texcoord;


void main()
{	
	mat4 oldModelViewMatrix = mat4(oldModelViewMatrix1, oldModelViewMatrix2, oldModelViewMatrix3, oldModelViewMatrix4);
	
	old_pos = gl_ProjectionMatrix * oldModelViewMatrix * gl_Vertex;
	new_pos = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	
	gl_Position = new_pos;

	texcoord = vec2(gl_MultiTexCoord0);
}