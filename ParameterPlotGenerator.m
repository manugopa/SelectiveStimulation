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

MPVAlphavec = 0.32.*(Vvec+37)./(1-exp(-(Vvec+37)./4));
MPVBetavec = 0.28.*(Vvec+10)./(exp((Vvec+10)./5)-1);
HPVAlphavec = 0.128.*exp(-(Vvec+33)./18);
HPVBetavec = 4./(1+exp(-(Vvec+10)./5));
NPVAlphavec = 0.032.*(Vvec+35)./(1-exp(-(Vvec+35)./5));
NPVBetavec = 0.5.*exp(-(Vvec+40)./40);

MPVInfinity = MPVAlphavec./(MPVAlphavec+MPVBetavec);
NPVInfinity = NPVAlphavec./(NPVAlphavec+NPVBetavec);
HPVInfinity = HPVAlphavec./(HPVAlphavec+HPVBetavec);

mnh = figure;
plot(Vvec,MExciteInfinity,'k');
hold;
plot(Vvec,HExciteInfinity,'r');
plot(Vvec,NExciteInfinity,'b');

plot(Vvec,MInhibitInfinity,'k--');
plot(Vvec,HInhibitInfinity,'r--');
plot(Vvec,NInhibitInfinity,'b--');

plot(Vvec, MPVInfinity, 'k:');
plot(Vvec, HPVInfinity, 'r:');
plot(Vvec, NPVInfinity, 'b:');
l = legend('Excitatory m','Excitatory h','Excitatory n','Inhibitory m','Inhibitory h','Inhibitory n','PV m','PV h','PV n','Location','southeast');
ylabel('Parameter Value'), xlabel('Membrane Potential (mV)');
xlim([-125 125]);
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');

time_constant = figure;
plot(Vvec,1./(MExciteAlphavec+MExciteBetavec),'k');
hold;
plot(Vvec,1./(HExciteAlphavec+HExciteBetavec),'r');
plot(Vvec,1./(NExciteAlphavec+NExciteBetavec),'b');

plot(Vvec,0./(MInhibitAlphavec+MInhibitBetavec),'k--'); %no delay for m in model
plot(Vvec,0.2./(HInhibitAlphavec+HInhibitBetavec),'r--'); %5 is for phi
plot(Vvec,0.2./(NInhibitAlphavec+NInhibitBetavec),'b--');

plot(Vvec, 1./(MPVAlphavec+MPVBetavec), 'k:');
plot(Vvec, 1./(HPVAlphavec+HPVBetavec), 'r:');
plot(Vvec, 1./(NPVAlphavec+NPVBetavec), 'b:');
l = legend('Excitatory m','Excitatory h','Excitatory n','Inhibitory m','Inhibitory h','Inhibitory n', 'PV m', 'PV h', 'PV n','Location','northwest');
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
mPV = (1./(MPVAlphavec+MPVBetavec));
hPV = (1./(HPVAlphavec+HPVBetavec));
nPV = (1./(NPVAlphavec+NPVBetavec));
plot(Vvec(indexOfInterest),mExcite(indexOfInterest),'k'); hold on;
plot(Vvec(indexOfInterest),mInhibit(indexOfInterest),'k--'); hold on;
plot(Vvec(indexOfInterest),hInhibit(indexOfInterest),'r--'); hold on;
plot(Vvec(indexOfInterest),nInhibit(indexOfInterest),'b--'); hold on;
plot(Vvec(indexOfInterest),mPV(indexOfInterest),'k:'); hold on;
plot(Vvec(indexOfInterest),nPV(indexOfInterest),'b:');

axis tight
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
