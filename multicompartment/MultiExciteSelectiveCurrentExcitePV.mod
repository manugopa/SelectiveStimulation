NEURON{
POINT_PROCESS Excite_Selective_Current_ExcitePV
RANGE i, del, dur, period, t_period
ELECTRODE_CURRENT i}

UNITS { (mA) =  (milliamp) }

 PARAMETER {
          del= 10 (ms)
          dur= 150 (ms) <0,1e9>
          period = 10 (ms)
}

 ASSIGNED {
          i (mA/cm2)
          t_period (ms)
}

 INITIAL { i = 0 }

 BREAKPOINT {
            UNITSOFF
            t_period = fmod((t-del),period)
            UNITSON
            at_time(del)
            at_time(del+dur)
           if (t < del + dur && t > del) {
              UNITSOFF
              if (t_period<1) { i=(-2.75)*(t_period/1)}
              else if (t_period<(5-1))  {i=-2.75}
              else if (t_period<5) {i=(-2.75) - (-2.75)*((t_period-(5-1))/(1))}
              else if (t_period<(5+1)) {i=(1.1)*(((t_period)-(5))/1)}
              else if (t_period<8) {i=1.1}
              else if (t_period<(8+1)) {i=(1.1)-(1.1)*((t_period - 8)/1)}
              else  {i=0}
              UNITSON
           } else {
              i=0
                  }
            }
