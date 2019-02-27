% Daniel Zuerbig
% Music and Engineering Assigment 2

function [sound_out] = create_sound(instrument,notes,constants)

if iscell(notes)
    len = constants.durationChord;
    chord = 1;
elseif isstruct(notes)
    len = constants.durationScale;
    chord = 0;
end

switch instrument.temperament
    case {'Equal'}
        if chord
            for i = 1:length(notes)
                freqs(i) = get_root_frequency(notes{i}.note);
            end
        else
            freqs = get_root_frequency(notes.note);
        end
    case {'Just'}
        if chord
            if strcmp(instrument.mode, 'Major') % manually coded just chords
                freqs(1) = get_root_frequency(notes{1}.note);
                freqs(2) = freqs(1) * (5/4);
                freqs(3) = freqs(1) * (3/2);
            elseif strcmp(instrument.mode, 'Minor')
                freqs(1) = get_root_frequency(notes{1}.note);
                freqs(2) = freqs(1) * (6/5);
                freqs(3) = freqs(1) * (3/2);
            end
        else
            freqs = get_root_frequency(notes.note);
        end
end




fs = constants.fs;
T = 1/fs; % period
t = 0:T:len - T; % time vector
sound_out = 0 * t; % allocating memory

n = length(t);

for i = 1:length(freqs)
    
    fund = freqs(i);
    switch instrument.sound
        case {'Additive'}
            % Taking these numbers from Jerse fig 4.28. The fundamental
            % frequency is determined by the get_root_frequency funtion. 
            % At longer durations, this sounds like a bell, but at the shorter
            % time of .2 seconds, it sounds more like a drum noise. 

            amps = [1 .67 1 1.8 2.67 1.67 1.46 1.33 1.33 1 1.33]';
            durs = [1 .9 .65 .55 .325 .35 .25 .2 .15 .1 .075];
            harm = [.56 .56 .92 .92 1.19 1.7 2 2.74 3 3.76 4.07]'; % harmonic frequency multiplier
            additive = [0 1 0 1.7 0 0 0 0 0 0 0]'; % adding non linear frequency shift

            dur_len = len * durs;

            freqs = (fund*harm) + additive; % creating frequency vector from base
            [x,f] = meshgrid(t, freqs);
            s = amps .* sin( 2 * pi * x .* f); % initial time vectos
            [x2, k] = meshgrid(t, dur_len);

            ring_factor = 2; % how long should the note stay active?

            envelope = exp( (-1*ring_factor) .* (1./k) .* x2);

            s = s .* envelope;

            sound_out = sound_out + sum(s);

        case {'Subtractive'}
            % Option A. A square wave where resonant frequency moves from high
            % to low. 

            fund_rad = ( 2 * pi * fund) / fs; % in digital radian frequency
            wave = sin( 2 * pi * fund * t);
            sq = 2*(wave > 0) -1; % square wave
            sound = 0 * t;
            
            r = 1.2;

            N = length(t);
            inc = 50;

            num = N/inc;

            theta = logspace(log10(3*pi/4),log10(fund_rad),num); % ranging over cutoff frequencies

            for i = 1:num
                index = (((i-1) * inc) + 1):( i * inc);
                a = [ r^2 -2*r*cos(theta(i)) 1 ]; % transfer function from linked website
                sound(index) = filter(1, a, sq(index)); % filter small segments at a time
            end
            sound_out = sound_out + sound;

        case {'FM'}
            % Inspired by fig 5.9 from the Jerse book. This is the Chowning
            % drum like instrument. I changed some of the parameters, and
            % simplified the envelope functions. I also used the modulating to
            % carrier ration of 7/5 because it sounded good. 

            fm = (fund * (7/5));

            imax = 5;
            ring_factor = 6;

            envelope1 = zeros(1,n);

            c = .2 * n;
            x1 = 1:c; x2 = c:n;
            envelope1(x1) = x1 * (.2 / c) + .8;
            envelope1(x2) = exp( (-5/(n-c)) * (x2 - c) );

            envelope2 = exp( (-1*ring_factor) * (1./len) .* t);

            f_mod = imax*sin( 2 * pi * fm * t);
            f_mod = envelope2 .* f_mod;
            
            sound = sin( (2 * pi * fund * t) + f_mod );

            sound = sound .* envelope1;
            
            sound_out = sound_out + sound;

        case {'Waveshaper'}
            % This is the waveshaping model from Jerse fig 5.31. I simplified
            % the envelope functions, but kept their basic shapes. This
            % particular model also includes ring modulation. The waveshaping
            % curve was a polynomial, so I simply evaluated my initial sin wave
            % in the polynomial, instead of using a LUT. 

            fm = fund/sqrt(2);

            envelope1 = zeros(1, n);
            envelope1(1:882) = linspace(0,1,882);
            envelope1(883:end) = exp( (-18) * (t(883:end)-.02) );

            envelope2 = zeros(1, n);
            envelope2(1:1764) = linspace(1,0,1764);

            x = sin( 2 * pi * fm * t );
            x = x .* envelope2;

            car = sin( 2 * pi * fund * t );
            car = car .* envelope1; % carrier tone for ring modulation

            y = 1 + .841*x - .707*x.^2 - .595*x.^3 + .5*x.^4 + .42*x.^5 - .354*x.^6 - .297*x.^7 + .25*x.^8 + .210*x.^9;
            % wave shaping here

            sound = y .* car;
            sound_out = sound_out + sound;

        otherwise
            error('Inproper instrument specified');
    end
end

end

