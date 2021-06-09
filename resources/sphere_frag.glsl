#version 330 core

layout(location = 0) out vec4 color;

uniform vec3 MatAmb;
uniform vec3 MatDif;

void main()
{           
    color = vec4(MatDif, 1.0);
}