# This script lets you print out formants for the start-, mid-, and end-points
# of arbitrary labeled segments in a TextGrid. You must first generate a
# Formant file for your Sound:
#   1. Click your Sound in Praat Objects menu
#   2. Click 'Analyse spectrum -' button on the right
#   3. Click 'To Formant (burg)' (or use whatever you want)
#   4. Specify your Formant parameters
# After generating your Formant, select it and your Sound and your TextGrid,
# then run this script.
#
# !!!!
# NOTICE - BEFORE RUN
# UPDATE THE VALUES BELOW
# !!!!
# Please update the two variables below to refer to the correct tiers. It is
# assumed that you have a tier containing only vowel segments, and a second
# tier which contains the entire word as a segment (the label tier).
vowel_tier = 1
label_tier = 2

#
# Ok, go run the script
#


if numberOfSelected ("Sound") <> 1 or numberOfSelected ("TextGrid") <> 1 or numberOfSelected ("Formant") <> 1
    exitScript: "Please select a Sound and a TextGrid first."
endif
clearinfo

formant = selected ("Formant")
textgrid = selected ("TextGrid")
snd = selected ("Sound")
sound$ = selected$ ("Sound")

# If you don't want to generate a Formant ahead of time, you can specify your
# configuration for the Formant calculation here. This runs on every run of
# this script, and it does take some time, so if you're going to run it many
# times you should just generate it the once.
#
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

appendInfoLine: "Time	Start,Mid,End,Avg	Name	Word	Vowel	f1	f2	f3"

# Look through all intervals, picking out the ones with a non-blank label
for interval to numberOfIntervals
    vowel$ = Get label of interval... vowel_tier interval
    if vowel$ <> ""
	# if the interval has an unempty vowel label, get its start and end:
	start = Get starting point... vowel_tier interval
	start = start + 0.005
	end = Get end point... vowel_tier interval
	midpoint = (start + end) / 2

	# And get the word (label)
	word_interval = Get interval at time... label_tier start
	word_label$ = Get label of interval... label_tier word_interval

	# get the formant values at those points
    	select Formant 'sound$'
	@getFormants: 'start'
	@PrintLn: string$('start'), "start", vowel$, word_label$, getFormants.f1, getFormants.f2, getFormants.f3
	@getFormants: 'midpoint'
	@PrintLn: string$('midpoint'), "midpoint", vowel$, word_label$, getFormants.f1, getFormants.f2, getFormants.f3
	@getFormants: 'end'
	@PrintLn: string$('end'), "end", vowel$, word_label$, getFormants.f1, getFormants.f2, getFormants.f3

	# And special case the average formants
	mean1 = Get mean: 1, start, end, "Hertz"
	mean2 = Get mean: 2, start, end, "Hertz"
	mean3 = Get mean: 3, start, end, "Hertz"
	@PrintLn: "'start':'end'", "avg", vowel$, word_label$, mean1, mean2, mean3
	selectObject: textgrid
    endif
endfor

procedure getFormants: .pointInTime
    # Get the formants
    .f1 = Get value at time... 1 .pointInTime Hertz Linear
    .f2 = Get value at time... 2 .pointInTime Hertz Linear
    .f3 = Get value at time... 3 .pointInTime Hertz Linear
endproc

# Get the formants at a given point in time
# Args:
#  .pointInTime: A double number of seconds in the file
#  .timeLabel$: The label you want to give this point in time, eg "start"
procedure PrintLn: .pointInTime$, .timeLabel$, .vowelLabel$, .wordLabel$, .f1, .f2, .f3
    # Save result to text file:
    resultline$ = "'.pointInTime$'	'.timeLabel$'	'sound$'	'.wordLabel$'	'.vowelLabel$'	'.f1'	'.f2'	'.f3'"
    appendInfoLine: "'resultline$'"
endproc

selectObject: textgrid, formant, snd
