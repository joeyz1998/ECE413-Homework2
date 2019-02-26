function [] = play(soundIn,fs)

% Created by Daniel Zuerbig

% This function plays the specified sound. The only reason I put this in,
% is to clear up the main script, and it was also a handy way to implement
% the pause, because without it, MATLAB will just move on to playing the
% next thing on top of the previous. Since scales and chords have different
% times, this is able to handle any length vector.
    
    time = length(soundIn) / fs + 1; % the pause is one second longer than the sound file, to have a rest
    
    soundsc( soundIn, fs )
    pause(time)

end

