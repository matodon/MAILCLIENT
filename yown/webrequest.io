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
  pa