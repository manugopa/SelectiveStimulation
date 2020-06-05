%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Craft Non-Selective Signal
Fs = 10;
period_count = 100;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

pulse_width = 0.006;
tIs = 0;
tIe = tIs+pulse_width;
tIe2 = tIe+pulse_width;
signal = -0.6.*(tvec-tIs>0).*(tvec-tIe<0)+1.8.*(tvec-tIe>0).*(tvec-tIe2<0);
signal = repmat(signal,1,period_count);
original_signal = (50/3)*signal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup the noise deviations
SNR = [1 2 5 10 20];
iterations = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the noisy non-selective signals
for j=1:size(SNR,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        signal = awgn(original_signal,SNR(j),'measured');
        [T_Excite,S_Excite]=Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
        [T_Inhibit,S_Inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
        simulation_time = toc(timerval);

        timerval = tic();
        excite_counter = 0;
        excite_state = 0;
        V_excite = S_Excite(:,4);
        for t=1:length(V_excite)
            if ((excite_state == 0) && (V_excite(t) > -5))
                excite_state = 1;
            end
            if ((excite_state == 1) && (V_excite(t) < -5))
                excite_state = 0;
                excite_counter=excite_counter+1;
            end
        end
        excitatory_fires(i) = excite_counter*(100.0/period_count);

        inhibit_counter = 0;
        inhibit_state = 0;
        V_inhibit = S_Inhibit(:,3);
        for t=1:length(V_inhibit)
            if ((inhibit_state == 0) && (V_inhibit(t) > 15))
                inhibit_state = 1;
            end
            if ((inhibit_state == 1) && (V_inhibit(t) < 15))
                inhibit_state = 0;
                inhibit_counter=inhibit_counter+1;
            end
        end
        inhibitory_fires(i) = inhibit_counter*(100.0/period_count);
        counting_fires_time = toc(timerval);
    end
    total_time = toc(total_timerval);

    disp('SNR('+string(SNR(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Craft Inhibit-Selective Signal
Fs = 10;
period_count = 100;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

pulse_width = 0.006;
tIs = 0;
tIe = tIs+pulse_width;
tIe2 = tIe+pulse_width;
signal = -5.*(tvec-tIs>0).*(tvec-tIe<0)+10.*(tvec-tIe>0).*(tvec-tIe2<0);
original_signal = repmat(signal,1,period_count);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the noisy inhibitory-selective signals
for j=1:size(SNR,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        signal = awgn(original_signal,SNR(j),'measured');
        [T_Excite,S_Excite]=Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
        [T_Inhibit,S_Inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
        simulation_time = toc(timerval);

        timerval = tic();
        excite_counter = 0;
        excite_state = 0;
        V_excite = S_Excite(:,4);
        for t=1:length(V_excite)
            if ((excite_state == 0) && (V_excite(t) > -5))
                excite_state = 1;
            end
            if ((excite_state == 1) && (V_excite(t) < -5))
                excite_state = 0;
                excite_counter=excite_counter+1;
            end
        end
        excitatory_fires(i) = excite_counter*(100.0/period_count);

        inhibit_counter = 0;
        inhibit_state = 0;
        V_inhibit = S_Inhibit(:,3);
        for t=1:length(V_inhibit)
            if ((inhibit_state == 0) && (V_inhibit(t) > 15))
                inhibit_state = 1;
            end
            if ((inhibit_state == 1) && (V_inhibit(t) < 15))
                inhibit_state = 0;
                inhibit_counter=inhibit_counter+1;
            end
        end
        inhibitory_fires(i) = inhibit_counter*(100.0/period_count);
        counting_fires_time = toc(timerval);
    end
    total_time = toc(total_timerval);

    disp('SNR('+string(SNR(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Craft Excite-Selective Signal
Fs = 10;
period_count = 100;
period_length = 0.01; %100 Hz
tvec=1/(1000*Fs):1/(1000*Fs):period_length; % in seconds, converted to ms when plotting.

tIstartRamp = 0.0049;
tImidRamp = 0.005;
tIendRamp = 0.006;
tIendHigh = 0.009;
low_amplitude = -21.9;
high_amplitude = 20;
signal = low_amplitude.*(tvec-tImidRamp<0).*(tvec-tIstartRamp>0).*(tImidRamp-tvec)/(tImidRamp-tIstartRamp)+low_amplitude.*(tvec-tIstartRamp<=0);
signal = signal+high_amplitude*(tvec-tImidRamp>=0).*(tvec-tIendRamp<0).*(tvec-tImidRamp)./(tIendRamp-tImidRamp)+high_amplitude.*(tvec-tIendRamp>=0).*(tvec-tIendHigh<0);
original_signal = repmat(signal,1,period_count);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the noisy excitatory-selective signals
for j=1:size(SNR,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        signal = awgn(original_signal,SNR(j),'measured');
        [T_Excite,S_Excite]=Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
        [T_Inhibit,S_Inhibit]=Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs);
        simulation_time = toc(timerval);

        timerval = tic();
        excite_counter = 0;
        excite_state = 0;
        V_excite = S_Excite(:,4);
        for t=1:length(V_excite)
            if ((excite_state == 0) && (V_excite(t) > -5))
                excite_state = 1;
            end
            if ((excite_state == 1) && (V_excite(t) < -5))
                excite_state = 0;
                excite_counter=excite_counter+1;
            end
        end
        excitatory_fires(i) = excite_counter*(100.0/period_count);

        inhibit_counter = 0;
        inhibit_state = 0;
        V_inhibit = S_Inhibit(:,3);
        for t=1:length(V_inhibit)
            if ((inhibit_state == 0) && (V_inhibit(t) > 15))
                inhibit_state = 1;
            end
            if ((inhibit_state == 1) && (V_inhibit(t) < 15))
                inhibit_state = 0;
                inhibit_counter=inhibit_counter+1;
            end
        end
        inhibitory_fires(i) = inhibit_counter*(100.0/period_count);
        counting_fires_time = toc(timerval);
    end
    total_time = toc(total_timerval);

    disp('SNR('+string(SNR(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end
