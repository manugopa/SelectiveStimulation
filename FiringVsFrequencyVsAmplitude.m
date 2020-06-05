Fs = 1;
tvec=1/(1000*Fs):1/(1000*Fs):0.1;

%Excitatory threshold is -5
%Inhibitory threshold is 15
frequency_axis = zeros(1,51);
excite_frequency_output = zeros(1,51);
inhibit_frequency_output = zeros(1,51);
for index=1:length(excite_frequency_output)
    frequency_axis(index) = 5*(index-1);
    signal = 5*cos(frequency_axis(index)*2*pi*tvec);
    [T,S_excite]=Excitatory_Model(-70,10,0,signal,length(signal),Fs);
    excite_counter = 0;
    excite_state = 0;
    V_excite = S_excite(:,4);
    for t=1:length(V_excite)
        if ((excite_state == 0) && (V_excite(t) > -5))
            excite_state = 1;
        end
        if ((excite_state == 1) && (V_excite(t) < -5))
            excite_state = 0;
            excite_counter=excite_counter+1;
        end
    end
    excite_frequency_output(index) = 10*excite_counter;
    [T,S_inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal),Fs);
    inhibit_counter = 0;
    inhibit_state = 0;
    V_inhibit = S_inhibit(:,3);
    for t=1:length(V_inhibit)
        if ((inhibit_state == 0) && (V_inhibit(t) > 15))
            inhibit_state = 1;
        end
        if ((inhibit_state == 1) && (V_inhibit(t) < 15))
            inhibit_state = 0;
            inhibit_counter=inhibit_counter+1;
        end
    end
    inhibit_frequency_output(index) = 10*inhibit_counter;
end
response = figure;
plot(frequency_axis,excite_frequency_output,'r');xlabel('Frequency (Hz)');ylabel('Firing Rate (Hz)');%title('Firing Frequency vs. Stimulation Frequency (Signal Amplitude 5)');
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([0 400]);
hold on;
plot(frequency_axis,inhibit_frequency_output,'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
xlim([min(frequency_axis) max(frequency_axis)]);
l = legend('Excitatory','Inhibitory');
set(l,'FontSize',24);
set(l,'FontName','Times');
saveas(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/FvF5.fig');
print(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/FvF5.jpg','-djpeg','-r300');

%Excitatory threshold is -5
%Inhibitory threshold is 15
frequency_axis = zeros(1,51);
excite_frequency_output = zeros(1,51);
inhibit_frequency_output = zeros(1,51);
for index=1:length(excite_frequency_output)
    frequency_axis(index) = 5*(index-1);
    signal = 10*cos(frequency_axis(index)*2*pi*tvec);
    [T,S_excite]=Excitatory_Model(-70,10,0,signal,length(signal),Fs);
    excite_counter = 0;
    excite_state = 0;
    V_excite = S_excite(:,4);
    for t=1:length(V_excite)
        if ((excite_state == 0) && (V_excite(t) > -5))
            excite_state = 1;
        end
        if ((excite_state == 1) && (V_excite(t) < -5))
            excite_state = 0;
            excite_counter=excite_counter+1;
        end
    end
    excite_frequency_output(index) = 10*excite_counter;
    [T,S_inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal),Fs);
    inhibit_counter = 0;
    inhibit_state = 0;
    V_inhibit = S_inhibit(:,3);
    for t=1:length(V_inhibit)
        if ((inhibit_state == 0) && (V_inhibit(t) > 15))
            inhibit_state = 1;
        end
        if ((inhibit_state == 1) && (V_inhibit(t) < 15))
            inhibit_state = 0;
            inhibit_counter=inhibit_counter+1;
        end
    end
    inhibit_frequency_output(index) = 10*inhibit_counter;
end
response = figure;
plot(frequency_axis,excite_frequency_output,'r');xlabel('Frequency (Hz)');ylabel('Firing Rate (Hz)');%title('Firing Frequency vs. Stimulation Frequency (Signal Amplitude 10)');
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([0 400]);
hold on;
plot(frequency_axis,inhibit_frequency_output,'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
xlim([min(frequency_axis) max(frequency_axis)]);
l = legend('Excitatory','Inhibitory');
set(l,'FontSize',24);
set(l,'FontName','Times');
saveas(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/FvF10.fig');
print(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/FvF10.jpg','-djpeg','-r300');

%Excitatory threshold is -5
%Inhibitory threshold is 15
frequency_axis = zeros(1,51);
excite_frequency_output = zeros(1,51);
inhibit_frequency_output = zeros(1,51);
for index=1:length(excite_frequency_output)
    frequency_axis(index) = 5*(index-1);
    signal = 30*cos(frequency_axis(index)*2*pi*tvec);
    [T,S_excite]=Excitatory_Model(-70,10,0,signal,length(signal),Fs);
    excite_counter = 0;
    excite_state = 0;
    V_excite = S_excite(:,4);
    for t=1:length(V_excite)
        if ((excite_state == 0) && (V_excite(t) > -5))
            excite_state = 1;
        end
        if ((excite_state == 1) && (V_excite(t) < -5))
            excite_state = 0;
            excite_counter=excite_counter+1;
        end
    end
    excite_frequency_output(index) = 10*excite_counter
    [T,S_inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal),Fs);
    inhibit_counter = 0;
    inhibit_state = 0;
    V_inhibit = S_inhibit(:,3);
    for t=1:length(V_inhibit)
        if ((inhibit_state == 0) && (V_inhibit(t) > 15))
            inhibit_state = 1;
        end
        if ((inhibit_state == 1) && (V_inhibit(t) < 15))
            inhibit_state = 0;
            inhibit_counter=inhibit_counter+1;
        end
    end
    inhibit_frequency_output(index) = 10*inhibit_counter
end
response = figure;
plot(frequency_axis,excite_frequency_output,'r');xlabel('Frequency (Hz)');ylabel('Firing Rate (Hz)');%title('Firing Frequency vs. Stimulation Frequency (Signal Amplitude 30)');
set(gca,'fontsize',24);
set(gca,'fontname','Times');
ylim([0 400]);
hold on;
plot(frequency_axis,inhibit_frequency_output,'b');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
xlim([min(frequency_axis) max(frequency_axis)]);
l = legend('Excitatory','Inhibitory');
set(l,'FontSize',24);
set(l,'FontName','Times');
saveas(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/FvF30.fig');
print(response,'/Users/manugopa/Dropbox/NeuralResearch/FigsAfterReview/FvF30.jpg','-djpeg','-r300');

