function [soundOut] = create_chord( instrument, note_struct, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Edited by Daniel Zuerbig, Feb 2019
%
% I'm using the create chord function from last assignment, but editing it
% so that it works with the new constants structure, and so that it
% references the new sound synthesis models. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = constants.fs;
len = constants.durationScale;
% I am keeping the chord length the same as the note length because some of
% the synsthesis models I'm using sound better when played shorter, and I
% don't want things to get weird. 
soundOut = zeros(1,len * fs);

temperament = instrument.temperament;
chordType = instrument.mode;

root_freq = get_root_frequency( note_struct.note );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


switch chordType
    case {'Major','major','M','Maj','maj'}
        notes = [ 0 4 7 ]; % 1 3 5 notes, means 1 4 7 steps of major scale
    case {'Minor','minor','m','Min','min'}
        notes = [ 0 3 7 ];
    case {'Power','power','pow'}
        notes = [ 0 7 ]; % the root and the fifth
    case {'Sus2','sus2','s2','S2'}
        notes = [ 0 2 7 ]; % 1st, 2nd, 5th or major
    case {'Sus4','sus4','s4','S4'}
        notes = [ 0 5 7 ]; % 1st, 4th and 5th
    case {'Dom7','dom7','Dominant7', '7'}
        notes = [ 0 4 7 10 ];
    case {'Min7','min7','Minor7', 'm7'}
        notes = [ 0 3 7 10 ];
    otherwise
        error('Inproper chord specified');
end

freqs = get_frequencies( notes, temperament, root_freq );
% finding frequencies to add together for each chord

for i = 1:length(freqs)
    l = create_sound( instrument, freqs(i), constants );
    soundOut = soundOut + l; % addidng synthesized sound to final output
end

end
