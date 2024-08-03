import glad/gl
import std/enumerate

proc asPointer[T: SomeUnsignedInt](num: T): pointer =
  return cast[pointer](num)

# Vertex Type
type
  Vec2* = array[2, GLfloat]
  Vec3* = array[3, GLfloat]
  Vertex* = object
    pos: Vec3
    color: Vec3
    tex: Vec2
  VertexBuffer = ref object
    id: GLuint
  VertexArray = ref object
    id: GLuint
  VertexDescEntry* = object
    vbo: VertexBuffer
    valueCount: GLint
    dataType: GLenum

proc glTypeSize(t: GLenum): int =
  case t:
    of cGL_FLOAT: return sizeof(GLfloat)
    of GL_UNSIGNED_INT: return sizeof(GLuint)
    else: raise newException(Exception, "Undeclared Type: Check glTypeSize")

proc vertexDescribeGL(vao: VertexArray, entries: seq[VertexDescEntry]) =
  glBindVertexArray(vao.id)
  const vertexStride = sizeof(Vertex)
  var offset = 0
  for i, entry in enumerate(entries):
    glVertexAttribPointer(i.GLuint, entry.valueCount, entry.dataType,
      GL_FALSE.GLboolean, vertexStride.GLsizei, asPointer(0))
    glEnableVertexAttribArray(i.GLuint)
    offset = offset + (entry.valueCount * glTypeSize(entry.dataType))

proc describeVertex(buffer: VertexBuffer, vao: VertexArray) =
  var entries = @[
    VertexDescEntry(vbo: buffer, valueCount: 3.GLint, dataType: cGL_FLOAT),
    VertexDescEntry(vbo: buffer, valueCount: 3.GLint, dataType: cGL_FLOAT),
    VertexDescEntry(vbo: buffer, valueCount: 2.GLint, dataType: cGL_FLOAT),
  ]
  vertexDescribeGL(vao, entries)

const FLOATS_IN_VERTEX: GLuint = 8
