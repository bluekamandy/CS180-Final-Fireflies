// Portions of this were adapted from instructions by Prof. Zoe Wood and
// LearnOpenGL.com's Deferred Shading tutorial.

#version 330 core

in vec2 texCoord;
out vec4 color;

uniform vec3 Ldir;

uniform sampler2D gPosition;
uniform sampler2D gNormal;
uniform sampler2D gColorSpec;

const int NR_LIGHTS = 50;
uniform vec3 lightPositions[NR_LIGHTS];
uniform vec3 lightColors[NR_LIGHTS];


uniform vec3 viewPos; // EPos from our labs.

/* just pass through the texture color we will add to this next lab */
void main(){

   //vec4 texColor = texture(texture0, texCoord);
   
   // retrieve data from gbuffer
   vec3 FragPos = texture(gPosition, texCoord).rgb;
   vec3 Normal = texture(gNormal, texCoord).rgb;
   vec3 Diffuse = texture(gColorSpec, texCoord).rgb;
   float Specular = texture(gColorSpec, texCoord).a;

   // then calculate lighting as usual
   vec3 lighting  = Diffuse * 0.0; // hard-coded ambient component
   vec3 viewDir  = normalize(viewPos - FragPos);

   // Keep for when we add more lights.
   for(int i = 0; i < NR_LIGHTS; ++i)
   {
      // diffuse
      vec3 lightDir = normalize(lightPositions[i] - FragPos);
      vec3 diffuse = max(dot(Normal, lightDir), 0.0) * Diffuse * lightColors[i];
      // specular
      vec3 halfwayDir = normalize(lightDir + viewDir);  
      float spec = pow(max(dot(Normal, halfwayDir), 0.0), 16.0);
      vec3 specular = lightColors[i] * spec * Specular;
      // attenuation  HOLD OFF ON ATTENUATION FOR NOW
      // float distance = length(lights[i].Position - FragPos);
      // float attenuation = 1.0 / (1.0 + lights[i].Linear * distance + lights[i].Quadratic * distance * distance);
      // diffuse *= attenuation;
      // specular *= attenuation;
      lighting += diffuse + specular;        
   }

   // FIRST WE DO IT WITH A SINGLE LIGHT

//    vec3 lightDir = normalize(Ldir - FragPos);
//    // vec3 diffuse = max(dot(Normal, lightDir), 0.0) * Diffuse * vec3(1.0); // replaced color with 1.0
//    vec3 diffuse = max(dot(Normal, lightDir), 0.0) * Diffuse; 

//    // specular
//    vec3 halfwayDir = normalize(lightDir + viewDir);  
//    float spec = pow(max(dot(Normal, halfwayDir), 0.0), 16.0);
//    // vec3 specular = vec3(0.0,0.0,0.0) * spec * Specular; // replaced color with 1.0

// ;   // attenuation NO ATTENUATION FOR NOW
// //    float distance = length(Ldir - FragPos);
// //    float attenuation = 1.0 / (1.0 + light.Linear * distance + light.Quadratic * distance * distance);
// //    diffuse *= attenuation;
// //    specular *= attenuation;
//    lighting += diffuse;        

//    // color = vec4(texColor.rgb + lighting, 1.0)
   color = vec4(lighting, 1.0);

   // vec3 tColor = texture(texBuf, texCoord ).rgb;
   // color = vec4(tColor, 1.0);
   // if (abs(tColor.r) > 0.01 || abs(tColor.g) > 0.01)
   //    color = vec4(0.9, 0.9, 0.9, 1.0);

}
