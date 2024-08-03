# Geometry is a pair of vertices and indices
# the raw data before it it uploaded to the GPU
import glad/gl

type
  Geometry* = object
    vertices: seq[GLfloat]
    indices: Option[seq[GLfloat]]
