// Portions of this were adapted from instructions by Prof. Zoe Wood and
// LearnOpenGL.com's Deferred Shading tutorial.

#version 330 core

in vec2 texCoord;
out vec4 color;

uniform vec3 Ldir;

uniform sampler2D gPosition;
uniform sampler2D gNormal;
uniform sampler2D gColorSpec;

uniform vec3 viewPos; // EPos from our labs.

/* just pass through the texture color we will add to this next lab */
void main(){

   //vec4 texColor = texture(texture0, texCoord);
   
   // retrieve data from gbuffer

   vec3 Diffuse = texture(gColorSpec, texCoord).rgb;
   float alpha = texture(gColorSpec, texCoord).a;
   if (alpha == 0)
   {
      color = vec4(Diffuse, 1.0);
   }

}
