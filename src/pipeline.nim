# Pipeline Object is a single strategy to draw a thing
# nim has garbage collection
import shader
import vertex
import glad/gl
import mesh

type
  DrawMode* = enum
    GL_POINTS = 0x0000
    GL_LINES = 0x0001,
    GL_LINE_LOOP = 0x0002,
    GL_LINE_STRIP = 0x0003,
    GL_TRIANGLES = 0x0004,
    GL_TRIANGLE_STRIP = 0x0005,
    GL_TRIANGLE_FAN = 0x0006,
    GL_QUADS= 0x0007,
  Pipeline* = ref object
    shader: ShaderProgram
    desc: VertexDesc
    mode: DrawMode

proc newPipeline*(s: ShaderProgram, desc: VertexDesc, m: DrawMode):Pipeline =
  result.shader = s
  result.desc = desc
  result.mode = DrawMode

proc draw*(self: Pipeline, slice: MeshSlice) =
  useShaderProgram(self.shader)
  bindVertexDesc(self.desc)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, slice.indices.id)
  glDrawElements(self.mode.GLenum, slice.count, slice.indices.dataType, slice.start)
