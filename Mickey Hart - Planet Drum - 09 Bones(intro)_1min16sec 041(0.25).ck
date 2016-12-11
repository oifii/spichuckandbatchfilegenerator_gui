//------------------------------------------------------
// on-the-fly synchronization
// adapted from Perry's ChucK Drummin' + Ge's sine poops
//
// authors: Perry Cook (prc@cs.princeton.edu)
//          Ge Wang (gewang@cs.princeton.edu)
//          Stephane Poirier (stephane.poirier@oifii.org)
// --------------------|
// add one by one into VM (in pretty much any order):
//
// terminal-1%> chuck --loop
// ---
// terminal-2%> chuck + otf_01.ck
// (anytime later)
// terminal-2%> chuck + otf_02.ck
// (etc...)
//-------------------------------------------------------
300::second => dur D;
<<<"Duration(s): ">>>;
<<<1::D/44100>>>;

// this synchronizes to period
0.25::second => dur T;
T - (now % T) => now;
chout <= IO.newline();
<<<"Period(s): ">>>;
<<<1::T/44100>>>;

// construct the patch
SndBuf buf => Gain g => dac;
// read in the file
//me.sourceDir() + "/data/kick.wav" => buf.read;
string filename;
"D:/oifii-org/httpdocs/ns-org/nsd/ar/cp/audio_spi/spichuckandbatchfilegenerator_gui/Mickey Hart - Planet Drum - 09 Bones(intro)_1min16sec 041.wav" => filename;
filename => buf.read;
chout <= IO.newline();
<<<filename>>>;
// set the gain
1.0 => g.gain;

// time loop
while ((1::D)>(1::T))
//while( true )
{
    // set the play position to beginning
    0 => buf.pos;
    // randomize gain a bit
    Math.random2f(.8,.9) => buf.gain;

	D - (1::T) => D;
    // advance time
    1::T => now;
}
