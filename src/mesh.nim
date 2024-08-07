import glad/gl
import pipeline
import vertex
import buffer
import pipeline

type
  Elements* = object
    id: GLuint
  Mesh* = object
    buffer: GPUBuffer
    indices: seq[Elements]
  MeshSlice* = ref object
    mesh: Mesh
    indices: Elements
    start: GLuint
    count: GLuint

# upload data to the GPU
proc newMesh(buffer: GPUBuffer, idx: seq[Elements]): Mesh =
  result.buffer = buffer
  result.indices = idx
