
//
// Yown WebServer
// starts on port 8010
//
// The Socket stuff has been pretty unstable in Io, so be
// sure you're running the latest pull.  Or step back a few
// days maybe?
//
MyHandler := WebRequest clone do(
  handleRequest := method(request,
    self sendResponse (200, "OK")
    self sendHeader ("Content-type", "text/HTML")