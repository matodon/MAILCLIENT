
//
// Yown Builder
// html construction kit
//
Builder := Object clone
Builder tag := method(name, nodes,
  inner := ""
  attrs := name split(".")
  if (attrs size > 1,
    name := attrs at(0)
    attrs := " class='" .. attrs slice(1) join(" ") .. "'",
    attrs := ""
  )
  while(nodes,
    if(nodes name != ";",