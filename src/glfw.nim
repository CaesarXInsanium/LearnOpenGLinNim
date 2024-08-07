# break dependency on large nimGL

# typedef struct GLFWwindow GLFWwindow;

type
  GLFWwindowType = object
  GLFWwindow* = ptr GLFWwindowType
  GLFWmonitorType = object
  GLFWmonitor = ptr GLFWMonitorType

  GLFWkeyfun* = proc (window: GLFWwindow, key: cint, scancode: cint,
      action: cint, mods: cint): void {.cdecl.}
  GLFWwindowsizefun* = proc (window: GLFWwindow, width: cint,
      height: cint): void {.cdecl.}
  GLFWglproc* = proc (procname: cstring): void {.cdecl.}

# Initiation and Temination

proc glfwInit*(): cint {.importc: "glfwInit", cdecl, header: "GLFW/glfw3.h".}
proc glfwTerminate*(): void {.importc: "glfwTerminate", cdecl,
    header: "GLFW/glfw3.h".}

# GLFW Windows

proc glfwWindowHint*(hint: cint, value: cint): void
  {.importc: "glfwWindowHint", cdecl, header: "GLFW/glfw3.h".}
proc glfwCreateWindow*(width, height: cint, title: cstring,
    monitor: GLFWmonitor, share: GLFWWindow): GLFWwindow
  {.importc: "glfwCreateWindow", cdecl, header: "GLFW/glfw3.h".}
proc glfwDestroyWindow*(window: GLFWwindow): void
  {.importc: "glfwDestroyWindow", cdecl, header: "GLFW/glfw3.h".}
proc glfwWindowShouldClose*(window: GLFWwindow): cint
  {.importc: "glfwWindowShouldClose", cdecl, header: "GLFW/glfw3.h".}
proc glfwSetWindowShouldClose*(window: GLFWwindow, value: cint)
  {.importc: "glfwSetWindowShouldClose", cdecl, header: "GLFW/glfw3.h".}
proc glfwSetKeyCallback*(window: GLFWwindow, callback: GLFWkeyfun): GLFWKeyfun
  {.importc: "glfwSetKeyCallback", cdecl, header: "GLFW/glfw3.h".}
proc glfwSetWindowSizeCallback*(window: GLFWwindow,
    callback: GLFWwindowsizefun): GLFWwindowsizefun
  {.importc: "glfwSetWindowSizeCallback", cdecl, header: "GLFW/glfw3.h".}
proc glfwSwapBuffers*(window: GLFWwindow): void
  {.importc: "glfwSwapBuffers", cdecl, header: "GLFW/glfw3.h".}

# GL Context Management
proc glfwMakeContextCurrent*(window: GLFWwindow): void
  {.importc: "glfwMakeContextCurrent", cdecl, header: "GLFW/glfw3.h".}
proc glfwGetProcAddress*(procname: cstring): GLFWglproc
  {.importc: "glfwGetProcAddress", cdecl, header: "GLFW/glfw3.h".}

# GLFW Event Management
proc glfwPollEvents*(): void
  {.importc: "glfwPollEvents", cdecl, header: "GLFW/glfw3.h".}

# CONSTANTS: use c macro
const GLFW_PRESS*: cint = 1
const GLFW_RELEASE*: cint = 0
const GLFW_TRUE*: cint = 1
const GLFW_FALSE*: cint = 0

# Window Hint Targets
const GLFW_CONTEXT_VERSION_MAJOR*: cint = 0x00022002
const GLFW_CONTEXT_VERSION_MINOR*: cint = 0x00022003
const GLFW_REFRESH_RATE*: cint = 0x0002100F
const GLFW_OPENGL_PROFILE*: cint = 0x00022008
const GLFW_RESIZABLE*: cint = 0x00020003


# Window Hint Answers
const GLFW_OPENGL_ANY_PROFILE*: cint = 0
const GLFW_OPENGL_CORE_PROFILE*: cint = 0x00032001
const GLFW_OPENGL_COMPAT_PROFILE*: cint = 0x00032002


# KEYS
const GLFW_KEY_UNKNOWN*: cint = -1
const GLFW_KEY_SPACE*: cint = 32
const GLFW_KEY_APOSTROPHE*: cint = 39
const GLFW_KEY_COMMA*: cint = 44
const GLFW_KEY_MINUS*: cint = 45
const GLFW_KEY_PERIOD*: cint = 46
const GLFW_KEY_SLASH*: cint = 47
const GLFW_KEY_0*: cint = 48
const GLFW_KEY_1*: cint = 49
const GLFW_KEY_2*: cint = 50
const GLFW_KEY_3*: cint = 51
const GLFW_KEY_4*: cint = 52
const GLFW_KEY_5*: cint = 53
const GLFW_KEY_6*: cint = 54
const GLFW_KEY_7*: cint = 55
const GLFW_KEY_8*: cint = 56
const GLFW_KEY_9*: cint = 57
const GLFW_KEY_SEMICOLON*: cint = 59
const GLFW_KEY_EQUAL*: cint = 61
const GLFW_KEY_A*: cint = 65
const GLFW_KEY_B*: cint = 66
const GLFW_KEY_C*: cint = 67
const GLFW_KEY_D*: cint = 68
const GLFW_KEY_E*: cint = 69
const GLFW_KEY_F*: cint = 70
const GLFW_KEY_G*: cint = 71
const GLFW_KEY_H*: cint = 72
const GLFW_KEY_I*: cint = 73
const GLFW_KEY_J*: cint = 74
const GLFW_KEY_K*: cint = 75
const GLFW_KEY_L*: cint = 76
const GLFW_KEY_M*: cint = 77
const GLFW_KEY_N*: cint = 78
const GLFW_KEY_O*: cint = 79
const GLFW_KEY_P*: cint = 80
const GLFW_KEY_Q*: cint = 81
const GLFW_KEY_R*: cint = 82
const GLFW_KEY_S*: cint = 83
const GLFW_KEY_T*: cint = 84
const GLFW_KEY_U*: cint = 85
const GLFW_KEY_V*: cint = 86
const GLFW_KEY_W*: cint = 87
const GLFW_KEY_X*: cint = 88
const GLFW_KEY_Y*: cint = 89
const GLFW_KEY_Z*: cint = 90
const GLFW_KEY_LEFT_BRACKET*: cint = 91
const GLFW_KEY_BACKSLASH*: cint = 92
const GLFW_KEY_RIGHT_BRACKET*: cint = 93
const GLFW_KEY_GRAVE_ACCENT*: cint = 96
const GLFW_KEY_WORLD_1*: cint = 161
const GLFW_KEY_WORLD_2*: cint = 162
const GLFW_KEY_ESCAPE*: cint = 256
const GLFW_KEY_ENTER*: cint = 257
const GLFW_KEY_TAB*: cint = 258
const GLFW_KEY_BACKSPACE*: cint = 259
const GLFW_KEY_INSERT*: cint = 260
const GLFW_KEY_DELETE*: cint = 261
const GLFW_KEY_RIGHT*: cint = 262
const GLFW_KEY_LEFT*: cint = 263
const GLFW_KEY_DOWN*: cint = 264
const GLFW_KEY_UP*: cint = 265
const GLFW_KEY_PAGE_UP*: cint = 266
const GLFW_KEY_PAGE_DOWN*: cint = 267
const GLFW_KEY_HOME*: cint = 268
const GLFW_KEY_END*: cint = 269
const GLFW_KEY_CAPS_LOCK*: cint = 280
const GLFW_KEY_SCROLL_LOCK*: cint = 281
const GLFW_KEY_NUM_LOCK*: cint = 282
const GLFW_KEY_PRINT_SCREEN*: cint = 283
const GLFW_KEY_PAUSE*: cint = 284
const GLFW_KEY_F1*: cint = 290
const GLFW_KEY_F2*: cint = 291
const GLFW_KEY_F3*: cint = 292
const GLFW_KEY_F4*: cint = 293
const GLFW_KEY_F5*: cint = 294
const GLFW_KEY_F6*: cint = 295
const GLFW_KEY_F7*: cint = 296
const GLFW_KEY_F8*: cint = 297
const GLFW_KEY_F9*: cint = 298
const GLFW_KEY_F10*: cint = 299
const GLFW_KEY_F11*: cint = 300
const GLFW_KEY_F12*: cint = 301
const GLFW_KEY_F13*: cint = 302
const GLFW_KEY_F14*: cint = 303
const GLFW_KEY_F15*: cint = 304
const GLFW_KEY_F16*: cint = 305
const GLFW_KEY_F17*: cint = 306
const GLFW_KEY_F18*: cint = 307
const GLFW_KEY_F19*: cint = 308
const GLFW_KEY_F20*: cint = 309
const GLFW_KEY_F21*: cint = 310
const GLFW_KEY_F22*: cint = 311
const GLFW_KEY_F23*: cint = 312
const GLFW_KEY_F24*: cint = 313
const GLFW_KEY_F25*: cint = 314
const GLFW_KEY_KP_0*: cint = 320
const GLFW_KEY_KP_1*: cint = 321
const GLFW_KEY_KP_2*: cint = 322
const GLFW_KEY_KP_3*: cint = 323
const GLFW_KEY_KP_4*: cint = 324
const GLFW_KEY_KP_5*: cint = 325
const GLFW_KEY_KP_6*: cint = 326
const GLFW_KEY_KP_7*: cint = 327
const GLFW_KEY_KP_8*: cint = 328
const GLFW_KEY_KP_9*: cint = 329
const GLFW_KEY_KP_DECIMAL*: cint = 330
const GLFW_KEY_KP_DIVIDE*: cint = 331
const GLFW_KEY_KP_MULTIPLY*: cint = 332
const GLFW_KEY_KP_SUBTRACT*: cint = 333
const GLFW_KEY_KP_ADD*: cint = 334
const GLFW_KEY_KP_ENTER*: cint = 335
const GLFW_KEY_KP_EQUAL*: cint = 336
const GLFW_KEY_LEFT_SHIFT*: cint = 340
const GLFW_KEY_LEFT_CONTROL*: cint = 341
const GLFW_KEY_LEFT_ALT*: cint = 342
const GLFW_KEY_LEFT_SUPER*: cint = 343
const GLFW_KEY_RIGHT_SHIFT*: cint = 344
const GLFW_KEY_RIGHT_CONTROL*: cint = 345
const GLFW_KEY_RIGHT_ALT*: cint = 346
const GLFW_KEY_RIGHT_SUPER*: cint = 347
const GLFW_KEY_MENU*: cint = 348
const GLFW_KEY_LAST*: cint = GLFW_KEY_MENU
