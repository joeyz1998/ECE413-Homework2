function [f] = get_root_frequency( root )

% Created by Daniel Zuerbig

% This function takes in a base frequency expressed as letter and number,
% ie 'A4' or 'G2' and finds the appropriate frequency as found from the
% handy dandy wiki article:
% http://en.wikipedia.org/wiki/Piano_key_frequencies 
% Some error detection is implemented below.
% I moved this functionality into it's own function because I found myself
% copy pasta-ing this into other functions
    

if length(root) == 2
    str = root(1);
elseif length(root) == 3
    str = root([1 2]);
end
    
switch str
    case {'A', 'a'}
        root_freq = 27.50000 * 2^( str2double(root(end)) );
    case {'B', 'b'}
        root_freq = 30.86771 * 2^( str2double(root(end)) );
    case {'C', 'c'}
        root_freq = 16.35160 * 2^( str2double(root(end)) );
    case {'D', 'd'}
        root_freq = 18.35405 * 2^( str2double(root(end)) );
    case {'E', 'e'}
        root_freq = 20.60172 * 2^( str2double(root(end)) ); 
    case {'Eb', 'EB', 'eb'}
        root_freq = 19.44544 * 2^( str2double(root(end)) );
    case {'F', 'f'}
        root_freq = 21.82676 * 2^( str2double(root(end)) ); 
    case {'G', 'g'}
        root_freq = 24.49971 * 2^( str2double(root(end)) );
    otherwise
        error('Improper root specified')
end

f = root_freq;
% root frequencies pulled from Wiki page. Script parses first letter of 
% 'root' argument, and then multiplies by appropriate power of 2 from 
% second letter to determine correct starting frequency. 

end