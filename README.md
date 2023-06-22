# mvb
Minimum Viable Bindings to OpenCV for Nim

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

### Read from camera
```bash
nimble i

nim> import mvb
nim> var frame: Mat
nim> let cap = newVideoCapture()
nim> for i in countup(1,100):
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
nim> var img: Mat = imread imagePath
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
nim> var img: Mat = imread imagePath
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