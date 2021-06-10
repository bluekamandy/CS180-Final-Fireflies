// Portions of this were adapted from instructions by Prof. Zoe Wood and
// LearnOpenGL.com's Deferred Shading tutorial.

#version 330 core

in vec2 texCoord;
out vec4 color;

uniform vec3 Ldir;

uniform sampler2D gPosition;
uniform sampler2D gNormal;
uniform sampler2D gColorSpec;

const int NR_LIGHTS = 250;
uniform vec3 lightPositions[NR_LIGHTS];
uniform vec3 lightColors[NR_LIGHTS];

uniform mat4 P;
uniform mat4 V;
uniform mat4 M;

// You could make this into an array if you wanted different strength lights.
// float linear = -5.0;
// float quadratic = -1.0;

float linear = -5.0;
float quadratic = 15.0;

uniform vec3 viewPos; // EPos from our labs. But here we set it as a uniform.

/* just pass through the texture color we will add to this next lab */
void main(){

   //vec4 texColor = texture(texture0, texCoord);
   
   // retrieve data from gbuffer
   vec3 FragPos = texture(gPosition, texCoord).rgb;
   vec3 Normal = texture(gNormal, texCoord).rgb;
   vec3 Diffuse = texture(gColorSpec, texCoord).rgb;
   float Specular = texture(gColorSpec, texCoord).a;

   // then calculate lighting as usual
   vec3 lighting  = Diffuse * 0.1; // hard-coded ambient component
   vec3 viewDir  = normalize(viewPos - FragPos);

   mat4 verticalShift = mat4(1.0, 0.0, 0.0, 0.0,  0.0, 1.0, 0.0, 0.0,  0.0, 0.0, 1.0, 0.0,  0.0, -0.75, 0.0, 1.0);

   // Keep for when we add more lights.
   for(int i = 0; i < NR_LIGHTS; ++i)
   {
      // This works, but the lights are too high.
      vec4 transformedLight = verticalShift * V * vec4(lightPositions[i], 1);

      // Slows down computer. Rotation of lights seems amplified.
      // vec4 transformedLight = P * V * vec4(lightPositions[i], 1);

      // This doesn't work. The light is way too bright and it's slow.
      // vec4 transformedLight = P * V * M * vec4(lightPositions[i], 1);
      
      // diffuse
      vec3 lightDir = normalize(transformedLight.xyz - FragPos);
      vec3 diffuse = max(dot(Normal, lightDir), 0.0) * Diffuse * lightColors[i];
      // specular
      vec3 halfwayDir = normalize(lightDir + viewDir);  
      float spec = pow(max(dot(Normal, halfwayDir), 0.0), 16.0);
      vec3 specular = lightColors[i] * spec * Specular;
      // attenuation  HOLD OFF ON ATTENUATION FOR NOW
      float distance = length(transformedLight.xyz - FragPos);
      float attenuation = 1.0 / (1.0 + linear * distance + quadratic * distance * distance);
      diffuse *= attenuation;
      specular *= attenuation;
      lighting += diffuse + specular;        
   }

   color = vec4(lighting, 1.0);

}
