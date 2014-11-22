if numberOfSelected ("Sound") <> 1 or numberOfSelected ("TextGrid") <> 1
    exitScript: "Please select a Sound and a TextGrid first."
endif
clearinfo
sound = selected ("Sound")
textgrid = selected ("TextGrid")
selectObject: sound
To Pitch: 0.0, 75, 600
pitch = selected ("Pitch")
selectObject: textgrid
tier = 1
n = Get number of points: tier
for i to n
    tekst$ = Get label of point: tier, i
    if tekst$ <> ""
	tpoint = Get time of point... tier i
	selectObject: sound
	selectObject: pitch
	f0 = Get value at time: tpoint, "Hertz", "Linear"
      	appendInfoLine: tekst$, tab$, round (f0)
        selectObject: textgrid
    endif
endfor
selectObject: sound, textgrid