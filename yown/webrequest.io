//
// Stolen from the Io Socket addon
// the web request object
//
// Use:
//   req command   -> the action
//   req queryPath -> the full path
//   req queryArgs -> Map of query vars
//
WebRequest := Object clone do(
  lineMode := 1

  mandatorySpacePattern := "[ \t]+"
  optionalSpacePattern := "[ \t]*"
  tokenPattern := "([^\\x00-\\x1F\\x7F()<>@.;:\\\\\"/[\\]?={} \t]+)"
  quotedPattern := "\"((?:\\\\\"|[^\"])+\)\""

  headerPattern := "^" .. tokenPattern .. optionalSpacePattern .. ":" .. optionalSpacePattern .. "(.*)$"
  commandPattern := "^" .. tokenPattern .. mandatorySpacePattern .. "(.*)$"
  pairPattern := "^" .. optionalSpacePattern .. tokenPattern .. optionalSpacePattern .. "=" .. optionalSpacePattern .. "(?:" .. tokenPattern .. "|" .. quotedPattern .. ")(?:;(.*))?$"
  queryPattern := "^([^?]*).(.*)$"

  headerRegex := Regex clone with(headerPattern)
  commandRegex := Regex clone with(commandPattern)
  pairRegex := Regex clone with(pairPattern)
  queryRegex := Regex clone with(queryPattern)

  init := method(
    self sentCookies := Map clone
  )

  lineBuffer := method(
    self lineBuffer := Sequence clone
  )

  rawHeaders := method(
    self rawHeaders := List clone
  )

  headers := method(
    self headers := Map clone
    self rawHeaders foreach(v,
      self headers atPut(v at(0) asString, v at(1) asString)
    )
    return self headers
  )

  sentBuffer := method(
    self sentBuffer := Sequence clone
  )

  queryArgs := method(
    self parseQuery; return queryArgs
  )

  queryPath := method(
    self parseQuery; return queryPath
  )

  queryCookies := method(
    self parseQueryCookies; return queryCookies
  )

  handleSocket := method(aSocket,
    self mySocket := aSocket

    while(self mySocket isOpen,
      if(self mySocket streamReadNextChunk,
        input :=  self mySocket readBuffer
        // writeln(input)
        self handleInput(input)
      )
    )
  )

  handleInput := method(readBuffer,
    if(lineMode,
      lineBuffer appendSeq(readBuffer)
      readBuffer empty

      readLines := lineBuffer asString splitLines

      rest := readLines pop

      readLines foreach(line, self currentParser(line))

      if(lineMode,
        self lineBuffer := rest asBuffer,
        self currentParser(rest asString)
      )
    ,
      self lineBuffer appendSeq(readBuffer)
      self currentParser(readBuffer asString)
    )
  )

  handleRequest := method(request,
    self sendResponse (200, "OK")
    self sendHeader ("Content-type", "text/HTML")
    self endHeaders ()
    self close
  )


  currentParser := method(line,
    self 