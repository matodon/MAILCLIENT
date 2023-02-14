
//
// Yown
// a little web doodad for Io
//

doRelativeFile("yown/splitlines.io")

Yown := Object clone do(

  list("builder", "splitlines", "webrequest", "webserver") foreach(lib,
    doRelativeFile("yown/" .. lib .. ".io"))

  //
  // The `get`, `put`, etc.
  // (Incoming action handlers)
  //