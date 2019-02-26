Daniel Zuerbig
Music and Engineering MATLAB Project 2

The hw2.m function plays through each note with each type of synthesis. Then it proceeds to play 4 chords for each synthesis type. For brevity sake, I decided to keep the duration of each note .2 seconds, because this sounded better for some of the synthesis types. Because of this, I decided to keep the chord length at .2 seconds. 

In order to create chords, I kept the get_frequencies, and get_root_frequencies, and create_chord functions from assignment one. I had to slightly alter the input arguments of create_sound to accept a root frequency instead of a note structure. This was in order for the function to be compatable with the create_chord function. 

The chowning bell function shows some of the experimentation I did while preparing this assignment. 

Discussion:

A) The equal tempered chords seem to attack more. They seem to be a little louder and forward.
B) I think the equal sounds better for this reason, it is slightly more interesting. 
C) I don't hear as much difference between the minor chords. Maybe the equal tempered one is slighly more laid back. 
D) I can't really say one sounds better. The difference between them isn't profound enough.

However for both, the minor chord seems a little lower pitched. 
