
//
// Yown Builder
// html construction kit
//
Builder := Object clone
Builder tag := method(name, nodes,
  inner := ""
  attrs := name split(".")