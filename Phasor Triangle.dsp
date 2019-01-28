 import("stdfaust.lib");
  phase(f) = f/ma.SR : (+,1:fmod) ~ _;
  triangle(f) = (((phase(f)-0.5) : abs)*4)-1;
  test(f) = os.triangle(f);
  process = triangle(hslider("freq", 440, 40, 8000, 1));