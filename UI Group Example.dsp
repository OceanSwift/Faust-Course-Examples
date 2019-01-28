import("stdfaust.lib");
eqGroup = vgroup("[0]EQ",bas,mid,tre)
  with{
	bas = vslider("[0]Bass[style:knob]", -6, -70, 12, 0.1);
	mid = vslider("[1]Mid[style:knob]", -6, -70, 12, 0.1);
	tre = vslider("[2]Treble[style:knob]", -6, -70, 12, 0.1);
	};
volGroup = hgroup("[1]",lvl,mtr)
  with{
	lvl = vslider("[0]Gain", -24, -70, 12, 0.1);
	mtr = vbargraph("[1]Level[scale:log]", -70, 12);
	};
process = hgroup("Voice",eqGroup,volGroup);