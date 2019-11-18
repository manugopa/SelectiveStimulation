NEURON{
POINT_PROCESS PV_Selective_Current_ExcitePV
RANGE i, del, dur, period, t_period
ELECTRODE_CURRENT i}

UNITS{
(mA)=(milliamp)
}

PARAMETER{
del= 10 (ms)
dur= 150 (ms) <0,1e9>
period = 10 (ms)
}

ASSIGNED{
v(mV)
t_period (ms)
i(mA/cm2)}

BREAKPOINT{

 UNITSOFF
            t_period = fmod((t-del),period)
            UNITSON
            at_time(del)
            at_time(del+dur)
           if (t < del + dur && t > del) {
              UNITSOFF
              if (t_period<6){
                  i=-0.005*(60)
              }else{i=.01*(60)}
              UNITSON
           } else {
              i=0
                  }

}
