if numberOfSelected ("Sound") <> 1 or numberOfSelected ("TextGrid") <> 1
    exitScript: "Please select a Sound and a TextGrid first."
endif
clearinfo
sound$ = selected$ ("Sound", 1)
writeInfoLine: "'sound$'"

textgrid = selected ("TextGrid")
selectObject: textgrid
label_tier = 2

numberOfIntervals = Get number of intervals... 'label_tier'
appendInfoLine: "NumInt: 'numberOfIntervals'"

for interval to numberOfIntervals
	label$ = Get label of interval... label_tier interval
	if label$ <> ""
		# if the interval has an unempty label, get its start and end:
		start = Get starting point... tier interval
		end = Get end point... tier interval
		midpoint = (start + end) / 2
		# get the formant values at that interval
		call PrintFormants 'midpoint'
		select TextGrid 'soundname$'
	endif
endfor

procedure PrintFormants .pointInTime
    select Formant 'soundname$'
    f1 = Get value at time... 1 midpoint Hertz Linear
    f2 = Get value at time... 2 midpoint Hertz Linear
    f3 = Get value at time... 3 midpoint Hertz Linear
    # Save result to text file:
    resultline$ = "'soundname$'	'label$'	'f1'	'f2'	'f3''newline$'"
    appendInfoLine: 'resultline$'
endproc
