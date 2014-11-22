This script lets you print out formants for the start-, mid-, and end-points
of arbitrary labeled segments in a TextGrid. You must first generate a
Formant file for your Sound:

  1. Click your Sound in Praat Objects menu
  2. Click 'Analyse spectrum -' button on the right
  3. Click 'To Formant (burg)' (or use whatever you want)
  4. Specify your Formant parameters

After generating your Formant, select it and your Sound and your TextGrid,
then run this script.

The output prints to the info window, where you can copy it to a text file
or excel or whatever.

If you don't want to generate a Formant ahead of time, you can specify your
configuration for the Formant calculation in the script. This will run on
every run of this script, and it does take some time, so if you're going to
run it many times you should just generate it the once, ahead of time. You'll
also have to change the sanity check at the beginning (for number of items
selected) and the line at the end to reselect all objects.
