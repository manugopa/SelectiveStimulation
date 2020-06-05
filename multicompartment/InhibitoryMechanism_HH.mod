NEURON{
SUFFIX InM_HH    
RANGE gk, gna, el, gnabar, gkbar, gl, m 
GLOBAL    phi, v0,  minf, hinf, ninf, mtau, htau, ntau
USEION na READ ena WRITE ina
USEION k  READ ek  WRITE ik 
NONSPECIFIC_CURRENT il
THREADSAFE 
}

UNITS{
(uF)= (millicoulombs/kilovolt)
(S)=(siemens)
(mV)= (millivolt)
(mA)=(milliamp)
}

PARAMETER{
v0 = -70(mV)
gnabar = 0.035 (S/cm2)
gkbar = 0.009 (S/cm2)
gl = 0.0001 (S/cm2)
el = -65 (mV)
phi = 5 (1)
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
	m(1)
}

STATE{ n (1) h (1) }

INITIAL{
        rates(v)
        h = hinf
        n = ninf
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
        rates(v)
	UNITSOFF
        h' = phi* (hinf-h)/htau
        n' = phi* (ninf-n)/ntau
	UNITSON
}

PROCEDURE rates(v(mV)) {
	  LOCAL  alpha, beta, sum
UNITSOFF
	alpha =.1 * vtrap(-(v+35),10)
        beta =  4 * exp(-(v+60)/18)
        sum = alpha + beta
        mtau = 1/(sum)
        minf = alpha/sum
	m = minf
        :"h" sodium inactivation system
        alpha = .07 * exp(-(v+58)/20)
        beta = 1 / (exp(-(v+28)/10) + 1)
        sum = alpha + beta
        htau = 1/(sum)
        hinf = alpha/sum
        :"n" potassium activation system
        alpha = .01*vtrap(-(v+34),10)
        beta = .125*exp(-(v+44)/80)
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



