%
% PV_Model based on PV axon from Chiovini paper
% ====================
%    PV_Model(vstart,tstart,textra,iapp,twidth)
%    vstart is the initial voltage.
%    tstart is the start time of the pulse.
%    textra is the simulation time after the pulse is over. 
%    iapp is the amplitude of the pulse. 
%    twidth is the width of the pulse.
%
% voltages in mV, current in uA/cm^2, conductance in mS/cm^2, time is msec
% fs in kHz

function [T,S] = PV_Model(vstart,tstart,textra,iapp,twidth,fs)

global C gNabar gKbar gLbar ENa EK EL 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables:
% membrance capacitance  uF/cm^2
C = 0.93;
% Max Na conductance  mS/cm^2
gNabar = 200;
% Max K conductance  mS/cm^2
gKbar = 200;
% Max leakage conductance  mS/cm^2
gLbar = 0.1;
% Na Reversal Potential  mV
ENa = 55;
% K Reversal Potential  mV
EK = -90;
% Leakage Reversal Potential  mV
EL = -65;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Values for m, n, and h are set to rest state

v = vstart;

m = alpham(v)/(alpham(v) + betam(v));
n = alphan(v)/(alphan(v) + betan(v));
h = alphah(v)/(alphah(v) + betah(v));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve the equations using ode45
% Initial Conditions 
s0 = [m n h v];
tmax = tstart+twidth+textra;
% Time span
tspan = [0,tmax];
options = odeset('InitialStep',10^(-3),'MaxStep',10^(-1));
[T,S] = ode45(@fxn,tspan,s0,options);

        function a = alpham(v)
            a  = 0.32*(v+37)/(1-exp(-(v+37)/4));
        end
        function b = betam(v)
            b = 0.28*(v+10)/(exp((v+10)/5)-1);
        end
        function a = alphah(v)
            a = 0.128*exp(-(v+33)/18);
        end
        function b = betah(v)
            b = 4/(1+exp(-(v+10)/5));
        end
        function a = alphan(v)
            a = 0.032*(v+35)/(1-exp(-(v+35)/5));
        end
        function b = betan(v)
            b = 0.5*exp(-(v+40)/40);
        end    
        
        function ds = fxn(t,s)
            ds = zeros(4,1); % m = s(1); h = s(3); n = s(2); v = s(4)
            
            ds(1) = alpham(s(4))*(1-s(1))-betam(s(4))*s(1);
            ds(2) = alphan(s(4))*(1-s(2))-betan(s(4))*s(2);
            ds(3) = alphah(s(4))*(1-s(3))-betah(s(4))*s(3);
            gNa = gNabar*(s(1)^3)*s(3); 
            gK = gKbar*(s(2)^4);
                  
            if ((tstart<t)&&(t<tstart+twidth))
               ix = iapp(ceil(fs*(t-tstart)));
            else
               ix = 0;
            end   

            ds(4) = -(1/C)*(gNa*(s(4)-ENa) + gK*(s(4)-EK) + gLbar*(s(4)-EL)) + ix/C;
        end
end