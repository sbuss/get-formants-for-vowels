# This script lets you 

# !!!!
# UPDATE THESE VALUES
# !!!!
# Please update the two variables below to refer to the correct tiers. It is
# assumed that you have a tier containing only vowel segments, and a second
# tier which contains the entire word as a segment (the label tier).
vowel_tier = 1
label_tier = 2


if numberOfSelected ("Sound") <> 1 or numberOfSelected ("TextGrid") <> 1 or numberOfSelected ("Formant") <> 1
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

selectObject: textgrid

numberOfIntervals = Get number of intervals... 'vowel_tier'
appendInfoLine: "Number of vowels found: 'numberOfIntervals'"

appendInfoLine: "Time	Start,Mid,End	Name	Word	Vowel	f1	f2	f3"

for interval to numberOfIntervals
	vowel$ = Get label of interval... vowel_tier interval
	if vowel$ <> ""
		# if the interval has an unempty vowel label, get its start and end:
		start = Get starting point... vowel_tier interval
		end = Get end point... vowel_tier interval
		midpoint = (start + end) / 2
		# get the formant values at that interval
		@PrintFormants: 'start', "start"
		@PrintFormants: 'midpoint', "midpoint"
		@PrintFormants: 'end', "end"
		select TextGrid 'sound$'
	endif
endfor

procedure PrintFormants: .pointInTime, .timeLabel$
    select TextGrid 'sound$'
    vowel_interval = Get interval at time... vowel_tier .pointInTime
    vowel_label$ = Get label of interval... vowel_tier vowel_interval
    label_interval = Get interval at time... label_tier .pointInTime
    label_label$ = Get label of interval... label_tier label_interval
    select Formant 'sound$'
    f1 = Get value at time... 1 midpoint Hertz Linear
    f2 = Get value at time... 2 midpoint Hertz Linear
    f3 = Get value at time... 3 midpoint Hertz Linear
    # Save result to text file:
    resultline$ = "'.pointInTime'	'.timeLabel$'	'sound$'	'label_label$'	'vowel_label$'	'f1'	'f2'	'f3'"
    appendInfoLine: "'resultline$'"
endproc

selectObject: textgrid, formant, snd
