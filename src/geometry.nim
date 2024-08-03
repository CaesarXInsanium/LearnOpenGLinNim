# Geometry is a pair of vertices and indices
# the raw data before it it uploaded to the GPU
import glad/gl

type
  Geometry* = object
    vertices: seq[GLfloat]
    indices: Option[seq[GLfloat]]

const CUBE_VERTICES: seq[GLfloat] = @[
    -0.5.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.5.GLfloat, -0.5.GLfloat,
    -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    0.0.GLfloat, 0.5.GLfloat, 0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 1.0.GLfloat, 0.5.GLfloat,
    0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    1.0.GLfloat, 1.0.GLfloat, -0.5.GLfloat, 0.5.GLfloat, -0.5.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,

    -0.5.GLfloat, -0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.5.GLfloat, -0.5.GLfloat,
    0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    0.0.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 1.0.GLfloat, 0.5.GLfloat,
    0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    1.0.GLfloat, 1.0.GLfloat, -0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,

    -0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 1.0.GLfloat, 0.0.GLfloat, -0.5.GLfloat, 0.5.GLfloat,
    -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    1.0.GLfloat, -0.5.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, -0.5.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 1.0.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.5.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    -0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 1.0.GLfloat, 0.0.GLfloat,

    0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 1.0.GLfloat, 0.0.GLfloat, 0.5.GLfloat, 0.5.GLfloat,
    -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    1.0.GLfloat, 0.5.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 0.5.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 1.0.GLfloat, 0.5.GLfloat, -0.5.GLfloat, 0.5.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 1.0.GLfloat, 0.0.GLfloat,

    -0.5.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 0.5.GLfloat, -0.5.GLfloat,
    -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    1.0.GLfloat, 0.5.GLfloat, -0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 0.0.GLfloat, 0.5.GLfloat,
    -0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    1.0.GLfloat, 0.0.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.5.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,

    -0.5.GLfloat, 0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 0.5.GLfloat, 0.5.GLfloat,
    -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat,
    1.0.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0.GLfloat, 0.0.GLfloat, 0.5.GLfloat,
    0.5.GLfloat, 0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    1.0.GLfloat, 0.0.GLfloat, -0.5.GLfloat, 0.5.GLfloat, 0.5.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    -0.5.GLfloat, 0.5.GLfloat, -0.5.GLfloat, 0.0.GLfloat, 0.0.GLfloat,
    0.0.GLfloat, 0.0.GLfloat, 1.0f]
