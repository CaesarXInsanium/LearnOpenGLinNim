import glad/gl
import std/enumerate

import buffer

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
  VertexDesc* = ref object
    id: GLuint
  VertexDescEntry* = object
    buffer: GPUBuffer
    valueCount: GLint
    dataType: GLenum

proc glTypeSize(t: GLenum): int =
  case t:
    of cGL_FLOAT: return sizeof(GLfloat)
    of GL_UNSIGNED_INT: return sizeof(GLuint)
    else: raise newException(Exception, "Undeclared Type: Check glTypeSize")

proc newVertexDesc*(): VertexDesc =
  var id: GLuint
  glGenVertexArrays(1, id.addr)
  return VertexDesc(id: id)

proc newVertexDescEntry*(buffer: GPUBuffer, count: GLint, dataType: GLenum): VertexDescEntry =
  return VertexDescEntry(buffer: buffer, valueCount: count, dataType: dataTYpe)

proc vertexDescribeGL*(vao: VertexDesc, entries: seq[VertexDescEntry]) =
  glBindVertexArray(vao.id)
  const vertexStride = sizeof(Vertex)
  var offset = 0
  for i, entry in enumerate(entries):
    bindBuffer(entry.buffer)
    glVertexAttribPointer(i.GLuint, entry.valueCount, entry.dataType,
      GL_FALSE.GLboolean, vertexStride.GLsizei, asPointer(0))
    glEnableVertexAttribArray(i.GLuint)
    offset = offset + (entry.valueCount * glTypeSize(entry.dataType))
    glEnableVertexAttribArray(i.GLuint)
    bindBuffer(nil)
  glBindVertexArray(0)

proc describeVertex(buffer: GPUBuffer, vao: VertexDesc) =
  var entries = @[
    VertexDescEntry(buffer: buffer, valueCount: 3.GLint, dataType: cGL_FLOAT),
    VertexDescEntry(buffer: buffer, valueCount: 3.GLint, dataType: cGL_FLOAT),
    VertexDescEntry(buffer: buffer, valueCount: 2.GLint, dataType: cGL_FLOAT),
  ]
  vertexDescribeGL(vao, entries)

const FLOATS_IN_VERTEX: GLuint = 8
