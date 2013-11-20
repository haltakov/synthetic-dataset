uniform vec3 lightposition;
//varying float lightdotnorm;
varying vec2 texcoord;
varying vec3 eyespacenormal;

void main()
{
	// Transforming the vertex
	gl_Position = ftransform();
	
	texcoord = vec2(gl_MultiTexCoord0);
	
	//correct surface acne
	/*float ldo = dot(gl_Normal.xyz,lightposition);
	ldo = max(ldo,0.0);
	ldo = ldo * 0.95 + 0.999;
	gl_Position.w = gl_Position.w * ldo;*/
	
	/*vec4 ldo;
	ldo.x = dot(gl_ModelViewMatrix[0].xyz,lightposition);
	ldo.y = dot(gl_ModelViewMatrix[1].xyz,lightposition);
	ldo.z = dot(gl_ModelViewMatrix[2].xyz,lightposition);
	ldo.w = dot((gl_NormalMatrix*gl_Normal).xyz,ldo.xyz);
	ldo.w = max(ldo.w,0.0);
	ldo.w = ldo.w * 0.95 + 0.999;
	gl_Position.w = gl_Position.w * ldo.w;*/
	
	/*mat3 tmat;
	tmat[0] = gl_TextureMatrix[1][0].xyz;
	tmat[1] = gl_TextureMatrix[1][1].xyz;
	tmat[2] = gl_TextureMatrix[1][2].xyz;
	vec3 normal = (tmat * gl_NormalMatrix) * gl_Normal;*/
	
	eyespacenormal = normalize(gl_NormalMatrix * gl_Normal);
	//gl_Position.xyz = gl_Position.xyz - eyespacenormal * 0.01;
	//float lightdotnorm = max(eyespacenormal.z,0.0);
	//lightdotnorm *= lightdotnorm;
	//gl_Position.w *= mix(0.98,0.999,lightdotnorm);
	
	//lightdotnorm = (1.0-lightdotnorm)*0.95 + 0.999*(lightdotnorm);
	//gl_Position.w = gl_Position.w * lightdotnorm;
	
	//gl_Position.w *= 0.95;
}
