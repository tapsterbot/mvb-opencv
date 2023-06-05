import cppstl/std_string

#{.passl: "-lopencv_core -lopencv_imgcodecs -lopencv_highgui -lopencv_videoio".}

const
  mat = "<opencv2/core/mat.hpp>"
  imgcodecs = "<opencv2/imgcodecs.hpp>"
  highgui = "<opencv2/highgui.hpp>"
  #video = "<opencv2/video.hpp>"
  videoio = "<opencv2/videoio.hpp>"
  #core = "<opencv2/core.hpp>"
  string = "<opencv2/core/cvstd.hpp>"


type
  Mat* {.importcpp: "cv::Mat", header: mat.} = object
  String* {.importcpp: "cv::String", header: string.} = object
  VideoCapture* {.importcpp: "cv::VideoCapture", header: videoio.} = object

  ImreadModes* = enum
    IMREAD_UNCHANGED = -1,      ## !< If set, return the loaded image as is (with alpha channel, otherwise it gets cropped). Ignore EXIF orientation.
    IMREAD_GRAYSCALE = 0,       ## !< If set, always convert image to the single channel grayscale image (codec internal conversion).
    IMREAD_COLOR = 1,           ## !< If set, always convert image to the 3 channel BGR color image.
    IMREAD_ANYDEPTH = 2,        ## !< If set, return 16-bit/32-bit image when the input has the corresponding depth, otherwise convert it to 8-bit.
    IMREAD_ANYCOLOR = 4,        ## !< If set, the image is read in any possible color format.
    IMREAD_LOAD_GDAL = 8,       ## !< If set, use the gdal driver for loading the image.
    IMREAD_REDUCED_GRAYSCALE_2 = 16, ## !< If set, always convert image to the single channel grayscale image and the image size reduced 1/2.
    IMREAD_REDUCED_COLOR_2 = 17, ## !< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/2.
    IMREAD_REDUCED_GRAYSCALE_4 = 32, ## !< If set, always convert image to the single channel grayscale image and the image size reduced 1/4.
    IMREAD_REDUCED_COLOR_4 = 33, ## !< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/4.
    IMREAD_REDUCED_GRAYSCALE_8 = 64, ## !< If set, always convert image to the single channel grayscale image and the image size reduced 1/8.
    IMREAD_REDUCED_COLOR_8 = 65, ## !< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/8.
    IMREAD_IGNORE_ORIENTATION = 128

  VideoCaptureAPIs* = enum
    CAP_ANY = 0,                ## !< Auto detect == 0
    CAP_VFW = 200,              ## !< Video For Windows (obsolete, removed)
    CAP_FIREWIRE = 300,         ## !< IEEE 1394 drivers
    CAP_QT = 500,               ## !< QuickTime (obsolete, removed)
    CAP_UNICAP = 600,           ## !< Unicap drivers (obsolete, removed)
    CAP_DSHOW = 700,            ## !< DirectShow (via videoInput)
    CAP_PVAPI = 800,            ## !< PvAPI, Prosilica GigE SDK
    CAP_OPENNI = 900,           ## !< OpenNI (for Kinect)
    CAP_OPENNI_ASUS = 910,      ## !< OpenNI (for Asus Xtion)
    CAP_ANDROID = 1000,         ## !< Android - not used
    CAP_XIAPI = 1100,           ## !< XIMEA Camera API
    CAP_AVFOUNDATION = 1200,    ## !< AVFoundation framework for iOS (OS X Lion will have the same API)
    CAP_GIGANETIX = 1300,       ## !< Smartek Giganetix GigEVisionSDK
    CAP_MSMF = 1400,            ## !< Microsoft Media Foundation (via videoInput). See platform specific notes above.
    CAP_WINRT = 1410,           ## !< Microsoft Windows Runtime using Media Foundation
    CAP_INTELPERC = 1500,       ## !< RealSense (former Intel Perceptual Computing SDK)
    CAP_OPENNI2 = 1600,         ## !< OpenNI2 (for Kinect)
    CAP_OPENNI2_ASUS = 1610,    ## !< OpenNI2 (for Asus Xtion and Occipital Structure sensors)
    CAP_OPENNI2_ASTRA = 1620,   ## !< OpenNI2 (for Orbbec Astra)
    CAP_GPHOTO2 = 1700,         ## !< gPhoto2 connection
    CAP_GSTREAMER = 1800,       ## !< GStreamer
    CAP_FFMPEG = 1900,          ## !< Open and record video file or stream using the FFMPEG library
    CAP_IMAGES = 2000,          ## !< OpenCV Image Sequence (e.g. img_%02d.jpg)
    CAP_ARAVIS = 2100,          ## !< Aravis SDK
    CAP_OPENCV_MJPEG = 2200,    ## !< Built-in OpenCV MotionJPEG codec
    CAP_INTEL_MFX = 2300,       ## !< Intel MediaSDK
    CAP_XINE = 2400,            ## !< XINE engine (Linux)
    CAP_UEYE = 2500,            ## !< uEye Camera API
    CAP_OBSENSOR = 2600         ## !< For Orbbec 3D-Sensor device/module (Astra+, Femto)

  WindowFlags* = enum
    WINDOW_NORMAL     = 0x0000_0000, #!< the user can resize the window (no constraint) / also use to switch a fullscreen window to a normal size.
    WINDOW_AUTOSIZE   = 0x0000_0001, #!< the user cannot resize the window, the size is constrainted by the image displayed.
    WINDOW_OPENGL     = 0x0000_1000  #!< window with opengl support.

const
  CAP_V4L = CAP_VFW
  CAP_V4L2* = CAP_V4L
  CAP_FIREWARE* = CAP_FIREWIRE  ## !< Same value as CAP_FIREWIRE
  CAP_IEEE1394* = CAP_FIREWIRE  ## !< Same value as CAP_FIREWIRE
  CAP_DC1394* = CAP_FIREWIRE    ## !< Same value as CAP_FIREWIRE
  CAP_CMU1394* = CAP_FIREWIRE   ## !< Same value as CAP_FIREWIRE
  CAP_REALSENSE* = CAP_INTELPERC ## !< Synonym for CAP_INTELPERC

# imgcodecs
proc imread*(file: cstring, mode: ImreadModes = IMREAD_COLOR): Mat
  {.importcpp: "cv::imread(@)", header: imgcodecs.}

proc imwrite*(file: cstring, mat : Mat): bool
  {.importcpp: "cv::imwrite(@)", header: imgcodecs, discardable.}

# highgui
proc namedWindow*(winname: cstring, flags : WindowFlags = WINDOW_AUTOSIZE)
  {.importcpp: "cv::namedWindow(@)", header: highgui, discardable.}

proc imshow*(winname: cstring, mat : Mat)
  {.importcpp: "cv::imshow(@)", header: highgui, discardable.}

proc waitKey*(delay: cint = 0): cint
  {.importcpp: "cv::waitKey(@)", header: highgui, discardable.}

# videoio
proc newVideoCapture*(index: cint = 0, apiPreference: VideoCaptureAPIs = CAP_ANY): VideoCapture
  {.importcpp: "cv::VideoCapture(@)", header: videoio, constructor.}

proc getBackendName*(this: VideoCapture): String
  {.importcpp: "#.getBackendName(@)", header: videoio, discardable.}
  ## Returns used backend API name.

proc open*(this: VideoCapture, index: cint = 0, apiPreference: VideoCaptureAPIs = CAP_ANY): bool
  {.importcpp: "#.open(@)", header: videoio, discardable.}

proc isOpened*(this: VideoCapture): bool
  {.importcpp: "#.isOpened(@)", header: videoio, discardable.}

proc read*(this: VideoCapture; frame: Mat): bool
  {.importcpp: "#.read(@)", header: videoio, discardable.}
  ## Grabs, decodes and returns the next video frame.

proc release*(this: VideoCapture)
  {.importcpp: "#.release()", header: videoio, discardable.}
  ## Closes video file or capturing device.

# string
proc c_str*(this: String): CppString
  {.importcpp: "#.c_str()", header: string, discardable.}
  ## Get C string equivalent.

proc length*(this: String): uint
  {.importcpp: "#.length()", header: string, discardable.}
  ## Get length of String

############################################################
# Holdover from "nimble init"
proc add*(x, y: int): int =
  ## Adds two files together.
  return x + y

#when isMainModule:
#  main()
