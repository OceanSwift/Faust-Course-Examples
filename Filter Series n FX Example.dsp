import("stdfaust.lib");
waveGenerator = hgroup("[0]Wave Generator",no.noise,os.triangle(freq),os.square(freq),os.sawtooth(freq) : ba.selectn(4,wave))
with{
  wave = nentry("[0]Waveform",3,0,3,1);
  freq = hslider("[1]freq",440,50,2000,0.01);
};

peakFilters = hgroup("[1]Peak EQ Filters",seq(i,2,myFilters(i)))
with{
  myFilters(i) = fi.peak_eq(boost,peakFreq,bw)
  with{
  	boost = hslider("[0]Boost%i[style:knob]",0,-20,20,0.1);
  	peak = hslider("[1]Peak%i[style:knob]",50,50,10000,0.1);
  	bw = hslider("[2]Q%i[style:knob]",100,10,1000,1);
	peakRate = hslider("[3]LFO Freq%i",10,0.1,20,0.01);
    peakMod = hslider("[4]LFO Mod%i",0,0,10000,1);
	peakFreq = os.osc(peakRate)*peakMod + peak: max(30);
  };
};

subtractive = waveGenerator : peakFilters : hgroup("[2]Main Filter",fi.resonlp(resFreq,q,1))
with{
  ctFreq = hslider("[0]Cutoff Frequency[style:knob]",2000,50,10000,0.1) : si.smoo;
  q = hslider("[1]Q[style:knob]",5,1,30,0.1);
  lfoFreq = hslider("[2]Rate[style:knob]",10,0.1,20,0.01);
  lfoDepth = hslider("[3]Depth[style:knob]",0,0,10000,1);
  resFreq = os.osc(lfoFreq)*lfoDepth + ctFreq : max(30);
};
envelope = hgroup("[2]Envelope",en.adsr(attack,decay,sustain,release,gate)*tremolo*0.3)
with{
  attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
  decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
  sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
  release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
  gain = hslider("[4]gain[style:knob]",1,0,1,0.01);
  gate = button("[5]gate");
  tremlfoFreq = hslider("[6]Tremolo Rate[style:knob]",10,0.1,20,0.01);
  tremlfoDepth = hslider("[7]Tremolo Depth[style:knob]",0,0,1,0.01);
  tremolo = (os.osc(tremlfoFreq)*tremlfoDepth) + gain;
};

process = vgroup("Subtractive Synthesizer",subtractive*envelope);
effect = dm.phaser2_demo : dm.freeverb_demo;