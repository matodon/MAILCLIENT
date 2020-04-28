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

  que