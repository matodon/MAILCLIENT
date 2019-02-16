
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

		while(lineStart < size,
			nextCrIndex = findSeq("\r", lineStart)
			nextLfIndex = findSeq("\n", lineStart)

			if(nextCrIndex and nextLfIndex,
				if(nextCrIndex < nextLfIndex,
					nextLfIndex = nil,