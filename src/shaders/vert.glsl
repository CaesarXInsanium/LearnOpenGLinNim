#version 450 core

layout (location = 0) in vec2 aPos;

out vec3 ourColor;


void main(){
  gl_Position = vec4(aPos, 1.0, 1.0);
  ourColor = vec3(0.2, 0.4, 0.8);
};
