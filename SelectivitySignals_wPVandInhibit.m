% 100 Hz non-selective

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 10;
period_count = 15;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

pulse_width = 0.006;
tIs = 0;
tIe = tIs+pulse_width;
tIe2 = tIe+pulse_width;
signal = -0.3.*(tvec-tIs>0).*(tvec-tIe<0)+0.6.*(tvec-tIe>0).*(tvec-tIe2<0);
signal = repmat(signal,1,period_count);
signal = (50/1.9)*signal;

[T_Inhibit,S_Inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
[T_PV,S_PV]=PV_Model(-70,10,0,signal,length(signal)/Fs,Fs);
response = figure;
plot(T_Inhibit,S_Inhibit(:,3),'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
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
l = legend('Inhibitory','PV');
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 10;
period_count = 15;
period_length = 0.01; %100 Hz

tvec=1/(Fs*1000):1/(Fs*1000):period_length; % in seconds, converted to ms when plotting.
pulse_width1 = 0.005;
pulse_width2 = 0.005;
tIs = 0;
tIe = tIs+pulse_width1;
tIe2 = tIe+pulse_width2;
signal = 0.5.*(tvec-tIs>0).*(tvec-tIe<=0)+0.5.*(tvec-tIe>0).*(tvec-tIe2<=0);
signal = repmat(signal,1,period_count);
signal = (50/0.95)*signal;

[T_Inhibit,S_Inhibit]=Inhibitory_Model(-70,10,0,signal,period_count*period_length*1000,Fs);
[T_PV,S_PV]=PV_Model(-70,10,0,signal,period_count*period_length*1000,Fs);
response = figure;
plot(T_PV,S_PV(:,4),'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
hold on;
plot(T_Inhibit,S_Inhibit(:,3),'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-200 100]);
xlim([min(T_PV) max(T_PV)]);
xticks([0 40 80 120 160]);
yticks([-200 -100 0 100]);
l = legend('PV','Inhibitory');
set(l,'FontSize',24);
set(l,'FontName','Times');  

I=[zeros(1,10*Fs),signal,zeros(1,0*Fs)];
t=(1:length(I))/Fs;
current = figure;
plot(t,I), xlabel('Time (ms)'), ylabel('Applied Current(\muA/cm^2)');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([-25 40]);
xlim([min(t) max(t)]);
xticks([0 40 80 120 160]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%Inhibitory 100 Hz selective

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = 10;
period_count = 15;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

pulse_width = 0.006;
tIs = 0;
tIe = tIs+pulse_width;
tIe2 = tIe+pulse_width;
signal = -0.15.*(tvec-tIs>0).*(tvec-tIe<0)+0.5.*(tvec-tIe>0).*(tvec-tIe2<0);
signal = repmat(signal,1,period_count);
signal = (50/5.5)*signal;

[T_Inhibit,S_Inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
[T_PV,S_PV]=PV_Model(-70,10,0,signal,length(signal)/Fs,Fs);
response = figure;
plot(T_Inhibit,S_Inhibit(:,3),'r'), xlabel('Time (ms)'), ylabel('Membrane Potential (mV)');
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
l = legend('Inhibitory','PV');
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
