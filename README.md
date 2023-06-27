# mvb
Minimum Viable Bindings to OpenCV for Nim

These are new bindings compatible with the latest version of OpenCV. (4.7.x as of today.) MVB stands for "Minimum Viable Bindings" and/or "Machine Vision Bindings" (🖥️👁️📒). The library is minimal at the moment, but it can read and display from the camera, and read/write and encode files. These are the absolute minimum features required for a viable OpenCV binding. The plan is to keep improving the bindings until MVB is an acronym for "Maximum Viable Bindings".

## Installation

### Prerequisite: Install OpenCV

#### Linux (Debian/Ubuntu)
```bash
sudo apt install libopencv-dev
```

#### macOS
```bash
homebrew install opencv
```

#### Windows
```bash
choco install opencv
```


### Install MVB
```bash
nimble install mvb
```

## Demo

First, check out the code
```bash
git clone https://github.com/tapsterbot/mvb-opencv.git
cd mvb-opencv
```

Then run this demo...
(Using OpenCV's built-in GUI)
```bash
nimble demo
```

Or this demo...
(Viewable in any browser at http://127.0.0.1:8080/
```bash
nimble webdemo
```

## Interactive Demo

**Interactive Nim (INim) is required**
```bash
nimble install inim
```

### Read from camera
```bash
nimble i

nim> import mvb
nim> var frame: Mat
nim> let cap = newVideoCapture()
nim> for i in 1 .. 100:
....   cap.read frame
....   imshow "MVB - OpenCV Demo", frame
....   waitKey(5)
....
nim>
```

### Read from file
```bash
nimble i

nim> import mvb
nim> const imagePath = "tests/img/nim-logo.png"
nim> var img = imread imagePath
nim> imshow "MVB - OpenCV Demo", img
nim> waitKey(0)
nim>
```

### Write to file
```bash
nimble i

nim> import os
nim> import mvb
nim> const imagePath = "tests/img/nim-logo.png"
nim> const imageResultPath = "tests/img/nim-logo.test.png"
nim> var img = imread imagePath
nim>
nim> fileExists imageResultPath
false == type bool
nim>
nim> imwrite imageResultPath, img
nim>
nim> fileExists imageResultPath
true == type bool
nim>
```
