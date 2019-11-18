%100 Hz non-selective

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 10;
period_count = 15;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

pulse_width = 0.006;
tIs = 0;
tIe = tIs+pulse_width;
tIe2 = tIe+pulse_width;
signal = -0.7.*(tvec-tIs>0).*(tvec-tIe<0)+1.4.*(tvec-tIe>0).*(tvec-tIe2<0);
signal = repmat(signal,1,period_count);
signal = (50/3)*signal;

[T_Excite,S_Excite]=Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
[T_PV,S_PV]=PV_Model(-70,10,0,signal,length(signal)/Fs,Fs);
response = figure;
plot(T_Excite,S_Excite(:,4),'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
hold on;
plot(T_PV,S_PV(:,4),'b--');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-200 100]);
xlim([min(T_PV) max(T_PV)]);
xticks([0 40 80 120 160]);
yticks([-200 -100 0 100]);
l = legend('Excitatory','PV');
set(l,'FontSize',24);
set(l,'FontName','Times');  

I=[zeros(1,Fs*10),signal,zeros(1,Fs*0)];
t=(1:length(I))/Fs;
current = figure;
plot(t,I), xlabel('Time (ms)'), ylabel('Applied Current(\muA/cm^2)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-25 40]);
xlim([min(t) max(t)]);
xticks([0 40 80 120 160]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%PV 100 Hz selective

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 10;
period_count = 15;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

pulse_width1 = 0.00475;
pulse_width2 = 0.00525;
tIs = 0;
tIe = tIs+pulse_width1;
tIe2 = tIe+pulse_width2;
signal = -0.3*(tvec-tIs>0).*(tvec-tIe<0)+0.6*(tvec-tIe>0).*(tvec-tIe2<0);
signal = repmat(signal,1,period_count);
signal = (50/3)*signal;

[T_Excite,S_Excite]=Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
[T_PV,S_PV]=PV_Model(-70,10,0,signal,length(signal)/Fs,Fs);
response = figure;
plot(T_PV,S_PV(:,4),'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
hold on;
plot(T_Excite,S_Excite(:,4),'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-200 100]);
xlim([min(T_PV) max(T_PV)]);
xticks([0 40 80 120 160]);
yticks([-200 -100 0 100]);
l = legend('PV','Excitatory');
set(l,'FontSize',24);
set(l,'FontName','Times');  

I=[zeros(1,Fs*10),signal,zeros(1,Fs*0)];
t=(1:length(I))/Fs;
current = figure;
plot(t,I), xlabel('Time (ms)'), ylabel('Applied Current(\muA/cm^2)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-25 40]);
xlim([min(t) max(t)]);
xticks([0 40 80 120 160]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Excitatory 100 Hz selective

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 1;
period_count = 15;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

tIstartRamp = 0.004;
tImidRamp = 0.005;
tIendRamp = 0.006;
tIendHigh = 0.009;
low_amplitude = -21.9;
high_amplitude = 20;
signal = low_amplitude.*(tvec-tImidRamp<0).*(tvec-tIstartRamp>0).*(tImidRamp-tvec)/(tImidRamp-tIstartRamp)+low_amplitude.*(tvec-tIstartRamp<=0);
signal = signal+high_amplitude*(tvec-tImidRamp>=0).*(tvec-tIendRamp<0).*(tvec-tImidRamp)./(tIendRamp-tImidRamp)+high_amplitude.*(tvec-tIendRamp>=0).*(tvec-tIendHigh<0);
signal = repmat(signal,1,period_count);

[T_Excite,S_Excite]=Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
[T_PV,S_PV]=PV_Model(-70,10,0,signal,length(signal)/Fs,Fs);
response = figure;
plot(T_Excite,S_Excite(:,4),'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
hold on;
plot(T_PV,S_PV(:,4),'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-200 100]);
xlim([min(T_PV) max(T_PV)]);
xticks([0 40 80 120 160]);
yticks([-200 -100 0 100]);
l = legend('Excitatory','PV');
set(l,'FontSize',24);
set(l,'FontName','Times');

I=[zeros(1,Fs*10),signal,zeros(1,Fs*0)];
t=(1:length(I))/Fs;
current = figure;
plot(t,I), xlabel('Time (ms)'), ylabel('Applied Current(\muA/cm^2)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-25 40]);
xlim([min(t) max(t)]);
xticks([0 40 80 120 160]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
