
//
// The most trivial Yown app
//
doRelativeFile("../yown.io")

YownSimple := Yown clone do(
  get("/test",
    html(