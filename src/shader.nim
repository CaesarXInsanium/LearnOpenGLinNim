import glad/gl
import std/options

const loglen: GLsizei = 1024

type
  ShaderObjectType* = enum
    Fragment = GL_FRAGMENT_SHADER
    Vertex = GL_VERTEX_SHADER
    Geometry = GL_GEOMETRY_SHADER
  # Object represents compiled shader source file
  ShaderObject* = ref object
    id: Gluint
    shader_type: ShaderObjectType
  ShaderProgram* = ref object
    id: GLuint

proc shaderObjectCompileStatus*(shaderObject: GLuint): GLint =
  var status: GLint
  glGetShaderiv(shaderObject, GL_COMPILE_STATUS, status.addr)
  return status

proc shaderObjectLog*(shaderObject: GLuint) =
  var log = newString(loglen)
  var l: GLsizei = 1
  glGetShaderInfoLog(shaderObject, loglen, l.addr, log.cstring)
  echo log

proc newShaderObject*(source: string, stype: ShaderObjectType): Option[ShaderObject] =
  var id = glCreateShader(stype.GLenum)
  var source = allocCStringArray([source])
  glShaderSource(id, 1.GLsizei, source, cast[ptr GLint](0))
  deallocCStringArray(source)
  glCompileShader(id)
  if shaderObjectCompileStatus(id) == GL_TRUE:
    return some(ShaderObject(id: id))
  else:
    shaderObjectLog(id)
    return none[ShaderObject]()

proc shaderProgramLog*(shaderProgram: GLuint) =
  var log = newString(loglen)
  glGetProgramInfoLog(shaderProgram, loglen, cast[ptr GLsizei](0), log.cstring)
  echo log

proc programFromShaderObjects*(objs: seq[ShaderObject]): Option[ShaderProgram] =
  var shaderProgram = glCreateProgram()
  for shaderObject in objs:
    glAttachShader(shaderProgram, shaderObject.id)
  glLinkProgram(shaderProgram)
  var shaderProgramStatus: GLint
  glGetProgramiv(shaderProgram, GL_LINK_STATUS, shaderProgramStatus.addr)
  if shaderProgramStatus != GL_TRUE:
    shaderProgramLog(shaderProgram)
    return none[ShaderProgram]()
  else:
    return some(ShaderProgram(id: shaderProgram))

proc useShaderProgram*(program: ShaderProgram) =
  glUseProgram(program.id)
