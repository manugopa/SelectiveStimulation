%
% Inhibitory_Model based on Buzaki paper
% ====================
%    Inhibitory_Model(vstart,tstart,textra,iapp,twidth)
%    vstart is the initial voltage.
%    tstart is the start time of the pulse.
%    textra is the simulation time after the pulse is over. 
%    iapp is the amplitude of the pulse. 
%    twidth is the width of the pulse.
%
% voltages in mV, current in uA/cm^2, conductance in mS/cm^2, time is msec
% fs in kHz

function [T,S] = Inhibitory_Model(vstart,tstart,textra,iapp,twidth,fs)

global C gNabar gKbar gLbar ENa EK EL 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables:
% membrance capacitance  uF/cm^2
C = 1.0; 
% Max Na conductance  mS/cm^2
gNabar =  35;
% Max K conductance  mS/cm^2
gKbar = 9;
% Max leakage conductance  mS/cm^2
gLbar = 0.1;
% Na Reversal Potential  mV
ENa = 55;
% K Reversal Potential  mV
EK = -90;
% Leakage Reversal Potential  mV
EL = -65;
phi = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Values for m, n, and h are set to rest state

v = vstart;

m = alpham(v)/(alpham(v) + betam(v));
n = alphan(v)/(alphan(v) + betan(v));
h = alphah(v)/(alphah(v) + betah(v));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve the equations using ode45
% Initial Conditions 
s0 = [n h v];
tmax = tstart+twidth+textra; 
% Time span
tspan = [0,tmax];
options = odeset('InitialStep',10^(-3),'MaxStep',10^(-1));
[T,S] = ode45(@fxn,tspan,s0,options);

        function a = alpham(v)
            a  = -0.1*(v+35)/(exp(-0.1*(v+35))-1);
        end
        function b = betam(v)
            b = 4*exp(-(v+60)/18);
        end
        function a = alphah(v)
            a = 0.07*exp(-(v+58)/20);
        end
        function b = betah(v)
            b = 1/(exp(-0.1*(v+28))+1);
        end
        function a = alphan(v)
            a = -0.01*(v+34)/(exp(-0.1*(v+34))-1);
        end
        function b = betan(v)
            b = 0.125*exp(-(v + 44)/80);
        end
        
        function ds = fxn(t,s)
            ds = zeros(3,1); % v = s(3); h = s(2); n = s(1);

            ds(1) = phi*(alphan(s(3))*(1-s(1))-betan(s(3))*s(1)); 
            ds(2) = phi*(alphah(s(3))*(1-s(2))-betah(s(3))*s(2));
            m_inf = alpham(s(3))/(alpham(s(3))+betam(s(3)));
            gNa = gNabar*(m_inf^3)*s(2); 
            gK = gKbar*(s(1)^4);

            if ((tstart<t)&&(t<tstart+twidth))
               ix = iapp(ceil(fs*(t-tstart)));
            else
               ix = 0;
            end   
                   
            ds(3) = -(1/C)*(gNa*(s(3)-ENa)+gK*(s(3)-EK)+gLbar*(s(3)-EL))+ix/C;
        end 
end