#version  330 core
layout(location = 0) in vec3 vertPos;

// uniform mat4 P;
// uniform mat4 M;
// uniform mat4 V;

out vec2 texCoord;

out vec3 viewPos;

void main()
{
   gl_Position = vec4(vertPos, 1);
	texCoord = (vertPos.xy+vec2(1, 1))/2.0;

   // viewPos = (M * vertPos).xyz;
}
