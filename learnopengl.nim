# generated by glad
import glad/gl

# external libraries
import nimgl
import nimgl/glfw
import nimPNG
import shader

type
  Texture* = object
    id: GLuint
    index: GLuint

const vertexShaderSource = staticRead("shaders/vertex.glsl")
const fragShaderSource = staticRead("shaders/frag.glsl")

proc keyProc(window: GLFWWindow, key: int32, scancode: int32, action: int32,
    mods: int32): void {.cdecl.} =
  if key == GLFWKey.Escape and action == GLFWPress:
    window.setWindowShouldClose(true)
  if key == GLFWKey.Space:
    glPolygonMode(GL_FRONT_AND_BACK, if action !=
        GLFWRelease: GL_LINE else: GL_FILL)

proc resize_callback(window: GLFWwindow, width: int32, height: int32): void {.cdecl.} =
  echo "Window ResizeCAllback called"
  glViewPort(0,0,width,height)

proc main =
  # GLFW
  doAssert glfwInit()
  defer: glfwTerminate()

  glfwWindowHint(GLFWContextVersionMajor, 4)
  glfwWindowHint(GLFWContextVersionMinor, 6)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  let w: GLFWWindow = glfwCreateWindow(800, 600, "NimGL", nil, nil)
  defer: w.destroyWindow
  doAssert w != nil

  discard w.setKeyCallback(keyProc)
  discard w.setWindowSizeCallback(resize_callback)
  w.makeContextCurrent
  doAssert gladLoadGL(glfwGetProcAddress)
  w.makeContextCurrent
  # OpenGL code
  #
  var vertices: array[6,GLfloat] = [-0.5, 0.0, 0.5, 0.0, 0.0, 0.5]
  var indices: array[3,GLuint] = [0,1,2]

  # upload vertices to buffer
  var triangleBuffer: GLuint
  glCreateBuffers(1, triangleBuffer.addr)
  var size: GLsizeiptr = cast[GLsizeiptr](vertices.len() * sizeof(GLfloat))
  glNamedBufferStorage(triangleBuffer, size, vertices.addr().pointer, 0.GLBitfield)

  # vertex description
  var triangleVAO: GLuint
  glGenVertexArrays(1, triangleVAO.addr)
  glBindVertexArray(triangleVAO)
  glBindBuffer(GL_ARRAY_BUFFER, triangleBuffer)
  glVertexAttribPointer(0.GLuint, 2.GLint, cGL_FLOAT, GL_FALSE.GLboolean, 0.GLsizei, cast[pointer](0))
  glEnableVertexAttribArray(0)

  # Define and compile shader objects
  var vertexShader =  glCreateShader(GL_VERTEX_SHADER)
  var fragmentShader = glCreateShader(GL_FRAGMENT_SHADER)
  var x = allocCStringArray([vertexShaderSource])
  var y = allocCStringArray([fragShaderSource])
  glShaderSource(vertexShader, 1.GLsizei, x, cast[ptr GLint](0))
  glShaderSource(fragmentShader, 1.GLsizei, x, cast[ptr GLint](0))

  glCompileShader(vertexShader)
  doAssert GL_TRUE == shaderObjectCompileStatus(vertexShader)

  glCompileShader(fragmentShader)
  var fragmentShaderStatus: GLint
  glGetShaderiv(fragmentShader, GL_COMPILE_STATUS,  fragmentShaderStatus.addr)

  doAssert GL_TRUE == fragmentShaderStatus

  # LinkShaders
  var shaderProgram = glCreateProgram()
  glAttachShader(shaderProgram, vertexShader)
  glAttachShader(shaderProgram, fragmentShader)
  glLinkProgram(shaderProgram)
  var shaderProgramStatus: GLint
  glGetProgramiv(shaderProgram, GL_LINK_STATUS, shaderProgramStatus.addr)
  # doAssert GL_TRUE == shaderProgramStatus
  shaderProgramLog(shaderProgram)

  while not w.windowShouldClose:
    var bg: array[4,GLfloat] = [0.1, 0.2, 0.3, 1.0]
    glClearBufferfv(GL_COLOR, 0.GLint, bg[0].addr)
    
    glUseProgram(shaderProgram)

    w.swapBuffers
    glfwPollEvents()

when isMainModule:
  echo "Hello World!"
  main()
