import("stdfaust.lib");

declare interface "SmartKeyboard{
	'Number of Keyboards':'2',
	'Max Keyboard Polyphony':'12',
	'Keyboard 0 - Number of Keys':'4',
  	'Keyboard 1 - Number of Keys':'4',
	'Keyboard 0 - Lowest Key':'60',
	'Keyboard 1 - Lowest Key':'67',
	'Keyboard 0 - Scale':'2',
	'Keyboard 1 - Scale':'2',
	'Rounding Mode':'0'
}";

freq = hslider("freq",440,50,1000,0.01);
gain = hslider("gain",0.5,0,1,0.01);
gate = button("gate") : en.adsr(0.01,0.01,0.9,0.1);
breathControl = an.amp_follower_ar(0.1,0.1);
timbre(f) = os.sawtooth(f);
process = (gain*gate*timbre(freq)*0.5),breathControl : * <: _,_;
effect = dm.zita_light;