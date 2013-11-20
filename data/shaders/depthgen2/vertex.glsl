//varying vec2 tu0coord;

void main()
{
	// Transforming the vertex
	gl_Position = ftransform();
	
	//tu0coord = vec2(gl_MultiTexCoord0);
}
