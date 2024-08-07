# OpenGL in Nim

~~I have just realized just how stupid this is. I am spending more time dealing
with Nim than I am with learning OpenGL.~~

I have decided to fix this issue by simply relying entirely on Nim. I don't know
how I am going to deal with CGLM. Right now I want to catch up with my C implementation
of the OpenGL tutorial by Joey de Vries.

I got to a point in which I can draw a simple blue triangle.

## TODO

- [x] drop nimGL
- [x] drop nimPNG
- [ ] add cglm
- fix the dissapearing triangle
- restart the project
- begin by designing something completely new
- save glfw bindings to new repo

## Ideas

- I have an array of vertex data.
- I want to have an abstract wrapper around the idea of a single set of vertices
  and indices that can then be rendered
- then there is a VAO which describes the format of the data
- vertices can be rendered according to shaders, descriptor and style (triangles, line strip, points)
- we can have a pipeline object
  - shader
  - descriptor
  - drawing method
- to draw a thing, multiple calls can be chained to draw one frame
  - mesh
  - shader

  - count
  - indices
  - starting count

What if the pipeline object contains the vertex descriptors. It will interpret vertices
according to how the descriptor describes them
