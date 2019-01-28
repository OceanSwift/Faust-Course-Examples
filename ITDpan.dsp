  import("stdfaust.lib");

    // ITD: the Interaural Time Difference in samples, assuming that:
    // - the distance between the two ears is: 0.2 m
    // - the speed of the sound is: 340 m/s
    // - the sampling rate is: ma.SR
    ITD = (0.2/340)*ma.SR;

    // itdpan(p): ITD based panoramic
    // The parameter p indicates the position of the source:
    //      0.0 (full left): 0 on the left channel, full ITD delay on the right channel
    //      0.5 (center): half ITD delay on both channels
    //      1.0 (full right): full ITD delay on the left channel and 0 delay on the right channel
    itdpan(p) = _ <: @(p*ITD), @(ITD*(1-p));
    process =  ba.pulsen(1,10000) * checkbox("play") : pm.djembe(60,0.3,0.5,1) : itdpan(hslider("pan", 0.5, 0, 1, 0.01));