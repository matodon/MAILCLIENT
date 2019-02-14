
//
// Stolen from the Io Socket addon
// used by the web server objects
//
Sequence hasSlot("splitLines") ifFalse(
	Sequence splitLines := method(
		lineStart := 0
		resultList := List clone

		nextCrIndex := nil
		nextLfIndex := nil
