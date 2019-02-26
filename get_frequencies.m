function [freqs] = get_frequencies(steps, temperament, root)

% Created by Daniel Zuerbig

% Given a root frequency, 'just' or 'equal', and an array containing the
% numbers of the desired notes in a scale, this function will output a
% vector containing the frequencies associated with said vector. It will be
% the same length, and the frequencies will be in the same order. 

% This function can be used for both scales and chords, because both
% require knowing certain frequencies in the total 12 spaced frequencies
% between the root and it's one octave up twin.

switch temperament
    case {'just','Just'}
        all_freq_ratios = [1 16/15 9/8 6/5 5/4 4/3 64/45 3/2 8/5 5/3 9/5 15/8 2]; % ratios provided from powerpoint
        freq_ratios = all_freq_ratios(steps + 1); % plus one because indexing things
        freqs = freq_ratios .* root;
    case {'equal','Equal'}
        freq_interval = (2.^steps).^(1/12);
        freqs = freq_interval .* root;
        % equal temperment is easy, simply multiply spacing by correct
        % power of 2^(1/12)
    otherwise
        error('Improper temperament specified')
end



end

