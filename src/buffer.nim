import glad/gl
type
  GPUUsageType* = enum
    Vertices = 0x8892,
    Indices = 0x8893
  GPUBuffer* = ref object
    id: GLuint
    dataType: GLenum
    usageType: GPUUsageType

proc newGPUBuffer*[T](usageType: GPUUsageType,data: seq[T]): GPUBuffer =
  result = new(GPUBuffer)
  var id: GLuint = 0
  glCreateBuffers(1, id.addr)
  var size: GLsizeiptr = cast[GLsizeiptr](data.len() * sizeof(T))
  glNamedBufferStorage(id, size, data[0].addr().pointer, 0.GLBitfield)
  result.id = id
  result.dataType = cGL_FLOAT
  result.usageType = usageType
  glBindBuffer(GPUUsageType.Vertices.GLenum, 0)
  return result

proc bindBuffer*(self: GPUBuffer) =
  if self == nil:
    glBindBuffer(GL_ARRAY_BUFFER, 0)
  else:
    glBindBuffer(self.usageType.GLenum, self.id)
# proc multipleGPUBuffers
