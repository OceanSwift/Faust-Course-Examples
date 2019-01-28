import("stdfaust.lib");

gain = hslider("[4]gain[style:knob]",1,0,1,0.01);
gate = button("[5]gate");
freq = hslider("freq",440,50,2000,0.01);

dxOscA = os.osc(freq)*envelope
	with{
 	envelope = hgroup("[0]Envelope",en.adsr(attack,decay,sustain,release,gate))
	with{
  		attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
  		decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
  		sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
  		release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
	};
};

dxOscB = os.osc(freq+dxOscA*mod2)*envelope2
	with{
  	mod2 = hslider("[2]Mod2[style:knob]",50,1,2000,1);
 	envelope2 = hgroup("[1]Envelope2",en.adsr(attack,decay,sustain,release,gate))
	with{
  		attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
  		decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
  		sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
  		release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
	};
};

dxOscC = os.osc(freq+dxOscB*mod3)*envelope3
	with{
  	mod3 = hslider("[5]Mod3[style:knob]",50,1,2000,1);
 	envelope3 = hgroup("[4]Envelope3",en.adsr(attack,decay,sustain,release,gate)*0.3*gain)
	with{
  		attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
  		decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
  		sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
  		release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
	};
};

myEq = hgroup("[6]Peak Eq",fi.peak_eq(boost,peak,bw))
  with{
  		boost = hslider("[0]Boost[style:knob]",0,-20,20,0.1);
  		peak = hslider("[1]Peak[style:knob]",50,50,1000,1);
  		bw = hslider("[2]Q[style:knob]",100,10,1000,1);
};
  
process = dxOscC : myEq <: dm.zita_light;