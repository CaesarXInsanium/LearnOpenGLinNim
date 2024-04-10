# generated by glad
import glad/gl

# external libraries
import nimgl
import nimgl/glfw
import nimPNG

type
  Texture* = object
    id: GLuint
    index: GLuint

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

  glfwWindowHint(GLFWContextVersionMajor, 4)
  glfwWindowHint(GLFWContextVersionMinor, 6)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  let w: GLFWWindow = glfwCreateWindow(800, 600, "NimGL", nil, nil)
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
  # TODO!: Load Shader
  

  while not w.windowShouldClose:
    var bg: array[4,GLfloat] = [0.1, 0.2, 0.3, 1.0]
    glClearBufferfv(GL_COLOR, 0.GLint, bg[0].addr)

    w.swapBuffers
    glfwPollEvents()

  w.destroyWindow()

  glfwTerminate()

when isMainModule:
  echo "Hello World!"
  main()