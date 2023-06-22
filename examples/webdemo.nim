# To run:
# $ nim cpp -r web3.nim
#
import asynchttpserver, asyncdispatch, asyncnet
from std/posix import SIGINT, SIGTERM, onSignal
import cppstl/std_vector
import mvb

const address = "127.0.0.1"
const port = 8080

# Camera set-up
let cap = newVideoCapture()
var frame: Mat

# Server set-up
const headers = {"Content-Type": "text/html; charset=utf-8"}

# Get a frame from OpenCV: where the real magic happens...
proc getFrame(): string =
  cap.read(frame)
  var buffer = initCppVector[uint8]()
  var frameStr: string
  imencode(".jpg", frame, buffer)
  if buffer.len > 0:
    frameStr = newString(buffer.len)
    copyMem(frameStr.cstring, buffer[0].unsafeAddr, buffer.len)
  else:
    frameStr = newString(0)
  result = frameStr

proc cb(req: Request) {.async.} =
  echo req.reqMethod, " ", req.url.path
  if req.url.path == "/":
    const response = "<h3>🖥️👁️📒 / mvb - web demo</h3>\n" &
                      "<img src=\"/video\" width=\"100%\">"
    await req.respond(Http200, response, headers.newHttpHeaders())

  elif req.url.path == "/video":
    await req.client.send("HTTP/1.1 200 OK\r\n" &
                          "Content-Type: multipart/x-mixed-replace; boundary=frame\r\n\r\n")
    while true:
      await req.client.send("--frame\r\nContent-Type: image/jpeg\r\n\r\n" & getFrame() & "\r\n")
  else:
    await req.respond(Http404, "<h1 style='font-size: 200;'>🤷</h1>", headers.newHttpHeaders())

onSignal(SIGINT, SIGTERM):
  echo "⏹️  Stopping..."
  quit()

echo "▶️  Starting server at http://" & address & ":" & $port & "/"
asyncCheck newAsyncHttpServer().serve(Port(port), cb, address)
runForever()
