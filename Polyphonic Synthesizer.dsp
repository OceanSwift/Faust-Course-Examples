import("stdfaust.lib");
freq = hslider("freq",440,50,1000,0.01);
gain = hslider("gain",0.5,0,1,0.01);
gate = button("gate") : en.adsr(0.01,0.01,0.9,0.1);
timbre(f) = os.sawtooth(f)*0.5 + os.osc(f*2)*0.25 + os.osc(f*3)*0.125;
process = gain*gate*timbre(freq)*0.5 <: _,_;
effect = dm.zita_light;