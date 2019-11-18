:PV_Model based on PV axon from Chiovini paper
:v0 is the initial voltage
:del is the delay
:I don't think we need to express the simulation time after the pulse is over
:amp is the amplitude of the pulse
:dur is the width of the pulse
:voltage is in mV,  time in millisec

NEURON{
SUFFIX PVM_Only    :PVM_Only stands for the PV_Model properties without any signal beeing  injected
RANGE gk, gna
GLOBAL  gnabar, gkbar, gl, ena, ek, el, v0
USEION na WRITE ina
USEION k  WRITE ik
NONSPECIFIC_CURRENT il
}

UNITS{
(uF)= (millicoulombs/kilovolt)
(S)=(siemens)
(mV)= (millivolt)
(mA)=(milliamp)
}

PARAMETER{
v0 = -70(mV)
gnabar = 0.2 (S/cm2)  <0,1e9>
gkbar = 0.2 (S/cm2)   <0,1e9>
gl = 0.0001 (S/cm2)     <0,1e9>
ena = 55 (mV)
ek = -90 (mV)
el = -65 (mV)
}

ASSIGNED{
        ina (mA/cm2)
        ik (mA/cm2)
        il (mA/cm2)
        v(mV)
        gk(S/cm2)
        gna(S/cm2)
}

STATE{m (1) n (1) h (1) }

INITIAL{
        v=v0
        m = alpham(v0)/(alpham(v0) + betam(v0))
        n = alphan(v0)/(alphan(v0) + betan(v0))
        h = alphah(v0)/(alphah(v0) + betah(v0))
}

BREAKPOINT{

        SOLVE states METHOD cnexp
        UNITSOFF
        gna = gnabar*m*m*m*h
        gk = gkbar*n*n*n*n                           
        ina = gna*(v - ena)
        ik = gk*(v - ek)
        il = gl*(v - el)
        UNITSON
}

DERIVATIVE states {
           UNITSOFF
           m'= alpham(v)*(1-m)-betam(v)*m
           n'= alphan(v)*(1-n)-betan(v)*n
           h'= alphah(v)*(1-h)-betah(v)*h
           UNITSON
}

FUNCTION alpham(Vm (mV)) (1/ms) {
  UNITSOFF
  alpham  =  0.32*(Vm+37)/(1-exp(-(Vm+37)/4))
  UNITSON
}

FUNCTION betam(Vm (mV)) (1/ms) {
  UNITSOFF
  betam  = 0.28*(Vm+10)/(exp((Vm+10)/5)-1)
  UNITSON
}

FUNCTION alphah(Vm (mV)) (1/ms) {
  UNITSOFF
  alphah  = 0.128*exp(-(Vm+33)/18)
  UNITSON
}

FUNCTION betah(Vm (mV)) (1/ms) {
  UNITSOFF
  betah  = 4/(1+exp(-(Vm+10)/5))
  UNITSON
}

FUNCTION  betan(Vm (mV)) (1/ms) {
  UNITSOFF
  betan = 0.5*exp(-(Vm+40)/40)
  UNITSON
}


FUNCTION alphan(Vm (mV)) (1/ms) {
  UNITSOFF
  alphan  = 0.032*(Vm+35)/(1-exp(-(Vm+35)/5))
  UNITSON
}
