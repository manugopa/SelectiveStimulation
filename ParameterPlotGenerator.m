clear all;
hold off;
Vvec = linspace(-300,300,300); % voltage in mV

MExciteAlphavec = 0.182.*(Vvec+35)./(1-exp(-(Vvec+35)./9));
MExciteBetavec = -0.124.*(Vvec+35)./(1-exp((Vvec+35)./9));
HExciteAlphavec = 0.024.*(Vvec+50)./(1-exp(-(Vvec+50)./5));
HExciteBetavec = -0.0091.*(Vvec+75)./(1-exp((Vvec+75)./5));
NExciteAlphavec = 0.02.*(Vvec-20)./(1-exp(-(Vvec-20)./9));
NExciteBetavec = -0.002.*(Vvec-20)./(1-exp((Vvec-20)./9));

MExciteInfinity = MExciteAlphavec./(MExciteAlphavec+MExciteBetavec);
NExciteInfinity = NExciteAlphavec./(NExciteAlphavec+NExciteBetavec);
HExciteInfinity = 1./(1+exp((Vvec+65)*6.2));
MHExcitevec = (MExciteInfinity.^3).*HExciteInfinity;

MInhibitAlphavec = -0.1.*(Vvec + 35)./(exp(-0.1.*(Vvec+35))-1);
MInhibitBetavec = 4.*exp(-(Vvec+60)./18);
HInhibitAlphavec = 0.07*exp(-(Vvec+58)./20); 
HInhibitBetavec = 1./(exp(-0.1.*(Vvec+28))+1);
NInhibitAlphavec = -0.01.*(Vvec+34)./(exp(-0.1.*(Vvec+34))-1);
NInhibitBetavec = 0.125.*exp(-(Vvec+44)./80);

MInhibitInfinity = MInhibitAlphavec./(MInhibitAlphavec+MInhibitBetavec);
NInhibitInfinity = NInhibitAlphavec./(NInhibitAlphavec+NInhibitBetavec);
HInhibitInfinity = HInhibitAlphavec./(HInhibitAlphavec+HInhibitBetavec);
MHInhibitvec = (MInhibitInfinity.^3).*HInhibitInfinity;

mnh = figure;
plot(Vvec,MExciteInfinity,'k');
hold;
plot(Vvec,HExciteInfinity,'r');
plot(Vvec,NExciteInfinity,'b');

plot(Vvec,MInhibitInfinity,'k--');
plot(Vvec,HInhibitInfinity,'r--');
plot(Vvec,NInhibitInfinity,'b--');

l = legend('Excitatory m','Excitatory h','Excitatory n','Inhibitory m','Inhibitory h','Inhibitory n','Location','southeast');
ylabel('Parameter Value'), xlabel('Membrane Potential (mV)');
xlim([-125 125]);
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');

saveas(mnh,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/MNHPlots.fig');
print(mnh,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/MNHPlots.jpg','-djpeg','-r300');

time_constant = figure;
plot(Vvec,1./(MExciteAlphavec+MExciteBetavec),'k');
hold;
plot(Vvec,1./(HExciteAlphavec+HExciteBetavec),'r');
plot(Vvec,1./(NExciteAlphavec+NExciteBetavec),'b');

plot(Vvec,0./(MInhibitAlphavec+MInhibitBetavec),'k--'); %no delay for m in model
plot(Vvec,0.2./(HInhibitAlphavec+HInhibitBetavec),'r--'); %5 is for phi
plot(Vvec,0.2./(NInhibitAlphavec+NInhibitBetavec),'b--');

l = legend('Excitatory m','Excitatory h','Excitatory n','Inhibitory m','Inhibitory h','Inhibitory n','Location','northwest');
ylabel('Time Constant (ms)'), xlabel('Membrane Potential (mV)');
xlim([-300 125]);
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');

% create zoomed figure
axes('position',[.62 .67 .27 .24])
box on 
indexOfInterest = (Vvec < 50) & (Vvec > -150);
mExcite = (1./(MExciteAlphavec+MExciteBetavec));
mInhibit = (0./(MInhibitAlphavec+MInhibitBetavec));
hInhibit = (0.2./(HInhibitAlphavec+HInhibitBetavec));
nInhibit = (0.2./(NInhibitAlphavec+NInhibitBetavec));
plot(Vvec(indexOfInterest),mExcite(indexOfInterest),'k'); hold on;
plot(Vvec(indexOfInterest),mInhibit(indexOfInterest),'k--'); hold on;
plot(Vvec(indexOfInterest),hInhibit(indexOfInterest),'r--'); hold on;
plot(Vvec(indexOfInterest),nInhibit(indexOfInterest),'b--');
axis tight
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');


saveas(time_constant,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/MNHTimeConstants.fig');
print(time_constant,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/MNHTimeConstants.jpg','-djpeg','-r300');


%%H Impulse response

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 100;
period_length = 0.02; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

signal = 0.*tvec-5.*(tvec>50*period_length/100).*(tvec<=52.5*period_length/100); %0.5 ms

[T_Excite,S_Excite]=Excitatory_Model(-62.1800,500,0,signal,length(signal)/Fs,Fs);
[T_Inhibit,S_Inhibit]=Inhibitory_Model(-64.0176,500,0,signal,length(signal)/Fs,Fs);
H_Excite_sig = S_Excite(T_Excite>500,3);
T_Excite = T_Excite(T_Excite>500);
H_Inhibit_sig = S_Inhibit(T_Inhibit>500,2);
T_Inhibit = T_Inhibit(T_Inhibit>500);
response = figure;
H_Inhibit_sig = H_Inhibit_sig-min(H_Inhibit_sig(:));
H_Inhibit_sig = H_Inhibit_sig/max(H_Inhibit_sig(:));
plot(T_Inhibit-1000*period_length/2-500,H_Inhibit_sig,'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
hold on;
H_Excite_sig = H_Excite_sig-min(H_Excite_sig(:));
H_Excite_sig = H_Excite_sig/max(H_Excite_sig(:));
plot(T_Excite-1000*period_length/2-500,H_Excite_sig,'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([0 1]);
l = legend('Inhibitory h','Excitatory h','Location','Northwest');
set(l,'FontSize',24);
set(l,'FontName','Times');

saveas(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/HConstantImpulseResponse.fig');
print(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/HConstantImpulseResponse.jpg','-djpeg','-r300');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%M Impulse response

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 100;
period_length = 0.004; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

signal = 0.*tvec+5.*(tvec>50*period_length/100).*(tvec<=62.5*period_length/100);

[T_Excite,S_Excite]=Excitatory_Model(-62.1800,500,0,signal,length(signal)/Fs,Fs);
[T_Inhibit,S_Inhibit]=Inhibitory_Model(-64.0176,500,0,signal,length(signal)/Fs,Fs);
M_Excite_sig = S_Excite(T_Excite>500,1);
T_Excite = T_Excite(T_Excite>500);
S_Inhibit_sig = S_Inhibit(T_Inhibit>500,3);
a  = -0.1*(S_Inhibit_sig+35)./(exp(-0.1*(S_Inhibit_sig+35))-1);
b = 4*exp(-(S_Inhibit_sig+60)/18);
M_Inhibit_sig = a./(a+b);
T_Inhibit = T_Inhibit(T_Inhibit>500);
response = figure;
M_Inhibit_sig = M_Inhibit_sig-min(M_Inhibit_sig(:));
M_Inhibit_sig = M_Inhibit_sig/max(M_Inhibit_sig(:));
plot(T_Inhibit-1000*period_length/2-500,M_Inhibit_sig,'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
hold on;
M_Excite_sig = M_Excite_sig-min(M_Excite_sig(:));
M_Excite_sig = M_Excite_sig/max(M_Excite_sig(:));
plot(T_Excite-1000*period_length/2-500,M_Excite_sig,'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([0 1]);
l = legend('Inhibitory m','Excitatory m','Location','Northwest');
set(l,'FontSize',24);
set(l,'FontName','Times');  

saveas(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/MConstantImpulseResponse.fig');
print(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/MConstantImpulseResponse.jpg','-djpeg','-r300');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





