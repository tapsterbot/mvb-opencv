import mvb

proc main() =
  var frame: Mat

  # Create a GUI window
  namedWindow "MVB - OpenCV Demo"

  # Open the camera by callling the constructor
  let cap = newVideoCapture()

  # Check if it's opened
  if cap.isOpened == true:

    # Start getting and showing frames
    while true:
      # Grab frame from camera
      cap.read(frame)

      # Display the frame
      imshow "MVB - OpenCV Demo", frame

      # Wait for the user to press any key
      if waitKey(5) > 0:
        break

  # Close the camera
  cap.release
  echo "👑"


when isMainModule:
  main()