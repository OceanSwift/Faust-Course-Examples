import("stdfaust.lib");
looper(detune) = rwtable(tablesize,0.0,recIndex,_,readIndex)
with{
  record = button("Record") : int;
  readSpeed = hslider("Read Speed",1,0.001,10,0.01);
  tablesize = 48000;
  recIndex = +(1)~*(record) : %(tablesize);
  readIndex = readSpeed*(detune+1)/float(ma.SR) : (+ : ma.decimal) ~ _ : *(float(tablesize)) : int;
};
polyLooper = vgroup("[0]Looper",_ <: par(i,nVoices,looper(detune*i)) :> _,_)
with{
  nVoices = 10;
  detune = hslider("Detune",0.01,0,1,0.01);
};
myFlanger = hgroup("[1]Flanger",pf.flanger_mono(50,flangerOffset,flangerDepth,flangerFb,0))
with{
  flangerDepth = hslider("[0]Depth[style:knob]",1,0,2,0.1) : si.smoo;
  flangerOffset = hslider("[1]Offset[style:knob]",10,10,100,1);
  flangerFb = hslider("[2]Feedback[style:knob]",0,0,0.95,0.01);
};
myEcho = hgroup("[2]Delay",ef.echo(2,delayTime,delayFb))
with{
  delayTime = hslider("[0]Time[style:knob]",0.3,0,2,0.01);
  delayFb = hslider("[1]Feedback[style:knob]",0.5,0,1,0.01);
};

process = polyLooper:> myFlanger : myEcho;

