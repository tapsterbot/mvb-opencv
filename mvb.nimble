# Package

version       = "0.1.0"
author        = "Jason Huggins"
description   = "Minimum viable bindings for OpenCV"
license       = "MIT"
srcDir        = "src"
backend       = "cpp"

# Dependencies

requires "nim >= 1.6.12"
requires "cppstl"

task i, "\t\tRun INim interpreter configured to use MVB":
  exec "inim -d:--backend:cpp -d:'--passL:\"-lopencv_core -lopencv_imgcodecs -lopencv_highgui -lopencv_videoio\"'"

task demo, "\t\tRun the demo":
  exec "nim cpp -r --hints:off examples/demo.nim"

task web_demo, "\tRun the web demo":
  exec "nim cpp -r --hints:off examples/webdemo.nim"

task test, "\t\tRun the test suite":
  exec "nim cpp -r --hints:off tests/test1.nim"
  exec "nim cpp -r --hints:off tests/test2.nim"

task gendoc, "\t\tGenerate the documentation":
  exec "nim doc --backend:cpp --git.url:https://github.com/tapsterbot/mvb-opencv --git.commit:v0.1.0 --outdir:docs src/mvb.nim"

import distros
when defined(nimdistros):
  if detectOs(MacOSX):
    # homebrew install opencv
    foreignDep "opencv"

  elif detectOs(Debian) or detectOs(Ubuntu):
    # sudo apt install libopencv-dev
    foreignDep "libopencv-dev"

  elif detectOS(Windows):
    # choco install opencv
    foreignDep "opencv"

task install_opencv, "\tInstall OpenCV":
  when defined(nimdistros):
    if detectOs(MacOSX):
      # Install opencv using homebrew
      echo "Installing opencv..."
      exec "brew install opencv"

      # Fix paths
      echo "Fixing paths..."
      exec "ln -sf /usr/local/include/opencv4/opencv2 /usr/local/include/opencv2"

    elif detectOs(Debian) or detectOs(Ubuntu):
      exec "sudo apt install libopencv-dev"

    else:
      # TODO: Test on Windows
      # TODO: Test on Raspberry Pi OS & Raspberry Pi Zero / Pi 4
      discard

    echo "Done."
