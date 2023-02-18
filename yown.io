
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
  handlers := Map clone
  list("get", "post", "put", "delete") foreach(action,
    handlers atPut(action, List clone)
    setSlot(action, 
      method(url, addHandler(call message name, url, call message argAt(1)))
    )
  )

  addHandler := method(action, url, block,
    handlers at(action) append(list("^#{url}$" interpolate asRegex, block))