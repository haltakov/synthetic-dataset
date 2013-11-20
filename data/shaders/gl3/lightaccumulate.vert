#version 330

invariant gl_Position;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
uniform vec3 frustumLL;
uniform vec3 frustumBROffset;
uniform vec3 frustumTLOffset;

uniform float zfar;
uniform float znear;

in vec3 vertexPosition;
in vec3 vertexNormal;
in vec3 vertexTangent;
in vec3 vertexBitangent;
in vec3 vertexColor;
in vec3 vertexUv0;
in vec3 vertexUv1;
in vec3 vertexUv2;

out vec3 normal;
#ifdef NORMALMAPS
out vec3 tangent;
out vec3 bitangent;
#endif
out vec3 uv;
out vec3 eyespacePosition;

void main(void)
{
	// compute the model view matrix
	mat4 modelViewMatrix = viewMatrix*modelMatrix;
	
	// transform the normal into eye space
	normal = (modelViewMatrix*vec4(vertexNormal,0.0)).xyz;
	
	// transform the tangent and bitangent into eye space
	#ifdef NORMALMAPS
	tangent = (modelViewMatrix*vec4(vertexTangent,1.0)).xyz;
	bitangent = (modelViewMatrix*vec4(vertexBitangent,1.0)).xyz;
	#endif
	
	// pass along the uv unmodified
	uv = vertexUv0;
	
	// transform the position into eye space
	eyespacePosition = (modelViewMatrix*vec4(vertexPosition, 1.0)).xyz;
	
	// transform the position into screen space
	gl_Position = projectionMatrix*(vec4(eyespacePosition, 1.0));
}
