if numberOfSelected ("Sound") <> 1 or numberOfSelected ("TextGrid") <> 1
    exitScript: "Please select a Sound and a TextGrid first."
endif
clearinfo

formant = selected ("Formant")
textgrid = selected ("TextGrid")
snd = selected ("Sound")
sound$ = selected$ ("Sound")

# formant_time_step = 0.01
# formant_maximum_number = 5
# formant_maximum_hz = 5500
# formant_window_length = 0.075
# formant_preemphasis_from_hz = 50
#
# select Sound 'sound$'
# # To Formant (burg)... 0.0025 5 5500 0.025 50
# To Formant (burg)... formant_time_step formant_maximum_number formant_maximum_hz formant_window_length formant_preemphasis_from_hz

writeInfoLine: "'sound$'"

selectObject: textgrid
label_tier = 2

numberOfIntervals = Get number of intervals... 'label_tier'
appendInfoLine: "NumInt: 'numberOfIntervals'"

for interval to numberOfIntervals
	label$ = Get label of interval... label_tier interval
	if label$ <> ""
		# if the interval has an unempty label, get its start and end:
		start = Get starting point... label_tier interval
		end = Get end point... label_tier interval
		midpoint = (start + end) / 2
		# get the formant values at that interval
		call PrintFormants 'midpoint'
		select TextGrid 'sound$'
	endif
endfor

procedure PrintFormants .pointInTime
    select Formant 'sound$'
    f1 = Get value at time... 1 midpoint Hertz Linear
    f2 = Get value at time... 2 midpoint Hertz Linear
    f3 = Get value at time... 3 midpoint Hertz Linear
    # Save result to text file:
    resultline$ = "'sound$'	'label$'		f1: 'f1'	f2: 'f2'	f3: 'f3''newline$'"
    appendInfoLine: "'resultline$'"
endproc

selectObject: textgrid, formant, snd
