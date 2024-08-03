import glad/gl

type
  ShaderObject* = ref object
    source: cstring
    id: Gluint

proc shaderObjectCompileStatus*(shaderObject: GLuint): GLint =
  var status: GLint
  glGetShaderiv(shaderObject, GL_COMPILE_STATUS, status.addr)
  return status

const loglen: GLsizei = 1024

proc shaderObjectLog*(shaderObject: GLuint) =
  var log = newString(loglen)
  var l: GLsizei = 1
  glGetShaderInfoLog(shaderObject, loglen, l.addr, log.cstring)
  echo log

proc shaderProgramLog*(shaderProgram: GLuint) =
  var log = newString(loglen)
  glGetProgramInfoLog(shaderProgram, loglen, cast[ptr GLsizei](0), log.cstring)
  echo log
