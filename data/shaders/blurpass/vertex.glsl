varying vec4 oldpos;
varying vec4 newpos;

//uniform mat4 prev_modelview;
uniform mat4 prev_modelviewproj;

void main()
{
	vec4 new_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	vec4 old_Position = prev_modelviewproj * gl_Vertex; //TODO: should use old_Vertex passed in by CPU for dynamic objects
	/*vec4 old_eyepos = prev_modelview * gl_Vertex; //TODO: should use old_Vertex passed in by CPU for dynamic objects
	vec4 eyepos = gl_ModelViewMatrix * gl_Vertex;
	//vec3 clipmotionvector = gl_Position.xyz - old_Position.xyz;
	
	vec3 eyemotionvector = old_eyepos.xyz - eyepos.xyz;
	
	bool flag = dot(eyemotionvector, eyespacenormal) > 0.0;
	vec4 stretch = flag ? new_Position : old_Position;
	//gl_Position = ftransform();
	//gl_Position = stretch; //TODO: comment back in
	gl_Position = new_Position;
	//gl_Position = old_Position;
	//gl_Position = prev_modelviewproj * gl_Vertex;*/
	
	gl_Position = new_Position;
	oldpos = old_Position;
	newpos = new_Position;
	/*new_Position.xyz = new_Position.xyz / new_Position.w;
	old_Position.xyz = old_Position.xyz / old_Position.w;
	stretch.xyz = stretch.xyz / stretch.w;
	vec2 vel2 = new_Position.xy - old_Position.xy;*/
}
