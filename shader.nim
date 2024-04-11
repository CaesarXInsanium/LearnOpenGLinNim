import glad/gl

type
  ShaderObject* = ref object
    source: cstring
    id: Gluint

proc shaderObjectCompileStatus*(shaderObject: GLuint): GLint =
  var status: GLint
  glGetShaderiv(shaderObject, GL_COMPILE_STATUS,  status.addr)
  return status

proc shaderObjectLog*(shaderObject: GLuint) = 
  var loglen: GLint = 0
  glGetShaderiv(shaderObject, GL_INFO_LOG_LENGTH, loglen.addr)
  doAssert(loglen != 0)
  var log = newString(loglen)
  glGetShaderInfoLog(shaderObject, loglen, loglen.addr, log.cstring)

proc shaderProgramLog*(shaderProgram: GLuint) = 
  var loglen: GLint = 0
  glGetProgramiv(shaderProgram, GL_INFO_LOG_LENGTH, loglen.addr)
  doAssert(loglen != 0)
  var log = newString(loglen)
  glGetProgramInfoLog(shaderProgram, loglen, cast[ptr GLsizei](0), log.cstring)
  echo log
