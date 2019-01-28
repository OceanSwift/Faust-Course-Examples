import("stdfaust.lib");
string(f) = hgroup("String[0]",+~(de.fdelay4(maxDelLength,delLength-1) : dispersionFilter : *(damping)))
with{
  freq = f;
  damping = hslider("[1]Damp[style:knob]",0.99,0,1,0.01);
  maxDelLength = 1024;
  dispersionFilter = _ <: _,_' :> /(2);
  delLength = ma.SR/freq;
};
pluck = hgroup("[1]Pluck",gate : ba.impulsify*gain)
with{
  gain = hslider("[0]Gain[style:knob]",1,0,1,0.01);
};

freqSlider = hslider("Freq",110,50,1000,1);
// nStrings = hslider("Strings",6,1,12,1);
nStrings = 6;

strum = hgroup("[3]",hslider("[0]Strum",0,0,nStrings-1,1) <: par(i,nStrings,(_==i : ba.impulsify : string((i+1)*freqSlider*interval))) :> _)
  with{
  interval = hslider("[0]Interval[style:knob]",0.5,0,1,0.01);
};
myEcho = hgroup("[4]Delay",ef.echo(2,delayTime,delayFb))
with{
  delayTime = hslider("[0]Time[style:knob]",0.3,0,2,0.01);
  delayFb = hslider("[1]Feedback[style:knob]",0.5,0,1,0.01);
};
myReverb = hgroup("[5]Reverb", dm.zita_light);
process = vgroup("Karplus Strong",strum : myEcho <: myReverb);
