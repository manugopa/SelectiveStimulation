NEURON{
SUFFIX ExM_HH    
RANGE gk, gna, gnabar, gkbar, gl, el,h_infty
GLOBAL  v0, minf, hinf, ninf, mtau, htau, ntau
USEION na READ ena WRITE ina
USEION k  READ ek WRITE ik
NONSPECIFIC_CURRENT il
THREADSAFE : assigned GLOBALs will be per thread
}

UNITS{
(uF)= (millicoulombs/kilovolt)
(S)=(siemens)
(mV)= (millivolt)
(mA)=(milliamp)
}

PARAMETER{
v0 = -70(mV)
gnabar = 0.003 (S/cm2)  <0,1e9>
gkbar = 0.01 (S/cm2)   <0,1e9>
gl = 0.0001 (S/cm2)     <0,1e9>
el = -60 (mV)
}

ASSIGNED{
        ina (mA/cm2)
        ik (mA/cm2)
        il (mA/cm2)
        v(mV)
        gk(S/cm2)
        gna(S/cm2)
	minf hinf ninf
        mtau (ms) htau (ms) ntau (ms)
	ena (mV)
        ek (mV)
	h_infty(1)
}

STATE{m (1) n (1) h (1) }

INITIAL{
        rates(v)
	m = minf
        h = hinf
        n = ninf
}

BREAKPOINT{

        SOLVE states METHOD cnexp
        UNITSOFF
        gna = gnabar*m*m*m*h
        gk = gkbar*n                            
        ina = gna*(v - ena)
        ik = gk*(v - ek)
        il = gl*(v - el)
        UNITSON
}

DERIVATIVE states {
        rates(v)
        UNITSOFF
       m' =  (minf-m)/mtau
       h' =  (1/htau)*(h_infty-h)
       n' =  (ninf-n)/ntau
        UNITSON
}

PROCEDURE rates(v(mV)) {
          LOCAL  alpha, beta, sum
	  UNITSOFF
	h_infty = 1.0/(1.0+exp((v+65)*6.2))
        alpha =.182 * vtrap(-(v+35),9)
        beta =  0.124 * vtrap((v+35),9)
        sum = alpha + beta
        mtau = 1/(sum)
        minf = alpha/sum
        m = minf
	:"h" sodium inactivation system
        alpha = 0.024 * vtrap(-(v+50),5)
        beta = 0.0091*vtrap((v+75),5)
        sum = alpha + beta
        htau = 1/(sum)
        hinf = alpha/sum
        :"n" potassium activation system
        alpha = 0.02*vtrap(-(v-20),9)
        beta = 0.002*vtrap((v-20),9)
        sum = alpha + beta
        ntau = 1/(sum)
        ninf = alpha/sum
}

FUNCTION vtrap(x,y) {  :Traps for 0 in denominator of rate eqns.
        if (fabs(x/y) < 1e-6) {
                vtrap = y*(1 - x/y/2)
        }else{
                vtrap = x/(exp(x/y) - 1)
        }
UNITSON
}
