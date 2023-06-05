import unittest
import std/os
import mvb

const imagePath = "tests/img/nim-logo.png"
const imageResultPath = "tests/img/nim-logo.test.png"

test "can open image":
  var img: Mat

  #Read file
  if fileExists imagePath:
    img = imread imagePath

  #TODO: Change check to make sure image size is greater than 0 bytes
  check $(img.typeof) == "Mat"

test "can write image":
  # Read file
  var img = imread imagePath

  # Write file
  imwrite imageResultPath, img
  check (fileExists imageResultPath) == true

  # Clean up
  if fileExists imageResultPath:
    removeFile imageResultPath