#version 330 core
layout (location = 0) out vec3 gPosition;
layout (location = 1) out vec3 gNormal;
layout (location = 2) out vec4 gAlbedoSpec;

uniform sampler2D texture0;
in vec2 texCoord;

in vec3 fragPos;
in vec3 fragNor;

uniform vec3 MatAmb;
uniform vec3 MatDif;

void main()
{
    // READ IN TEXTURE IF THERE IS ONE
    vec4 texColor = texture(texture0, texCoord);

    // store the fragment position vector in the first gbuffer texture
    gPosition = fragPos;
    // also store the per-fragment normals into the gbuffer
    gNormal = normalize(fragNor);
    // and the diffuse per-fragment color
    // NOTE: mixed in texColor.rgb because this seems to be the only place it makes sense to do that.
    gAlbedoSpec.rgb = mix(MatDif, texColor.rgb, 0.5);
    // store specular intensity in gAlbedoSpec's alpha component
	 //constant could be from a texture
    gAlbedoSpec.a = 0.5;
} 
