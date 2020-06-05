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
signal = repmat(signal,1,period_count);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup the perturbation deviations
capacitance_std = [0 0.05 0.1 0.2];
conductance_std = [0.05 0.1 0.2];
potential_std = [1 5 10];
alpha_std = [0.05 0.1 0.2];
beta_std = [0.05 0.1 0.2];
iterations = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the capacitance deviations
for j=1:size(capacitance_std,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        [T_Excite,S_Excite]=Perturbed_Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs,capacitance_std(j),[0 0 0],[0 0 0],[0 0 0],[0 0 0]);
        [T_Inhibit,S_Inhibit]=Perturbed_Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs,capacitance_std(j),[0,0,0],[0,0,0],[0,0,0],[0,0,0]);
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

    disp('Capacitance StdDev('+string(capacitance_std(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the conductance deviations
for j=1:size(conductance_std,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        [T_Excite,S_Excite]=Perturbed_Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,conductance_std(j)*[1 1 1],[0 0 0],[0 0 0],[0 0 0]);
        [T_Inhibit,S_Inhibit]=Perturbed_Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,conductance_std(j)*[1 1 1],[0 0 0],[0,0,0],[0,0,0]);
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

    disp('Conductance StdDev('+string(conductance_std(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the potential deviations
for j=1:size(potential_std,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        [T_Excite,S_Excite]=Perturbed_Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,[0 0 0],potential_std(j)*[1 1 1],[0 0 0],[0 0 0]);
        [T_Inhibit,S_Inhibit]=Perturbed_Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,[0 0 0],potential_std(j)*[1 1 1],[0,0,0],[0,0,0]);
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

    disp('Potential StdDev('+string(potential_std(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the alpha deviations
for j=1:size(alpha_std,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        [T_Excite,S_Excite]=Perturbed_Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,[0 0 0],[0 0 0],alpha_std(j)*[1 1 1],[0 0 0]);
        [T_Inhibit,S_Inhibit]=Perturbed_Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,[0 0 0],[0,0,0],alpha_std(j)*[1 1 1],[0,0,0]);
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

    disp('Alpha StdDev('+string(alpha_std(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Loop through the beta deviations
for j=1:size(beta_std,2)
    excitatory_fires = zeros(1,iterations);
    inhibitory_fires = zeros(1,iterations);

    total_timerval = tic();
    for i=1:iterations
        timerval = tic();
        [T_Excite,S_Excite]=Perturbed_Excitatory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,[0 0 0],[0 0 0],[0 0 0],beta_std(j)*[1 1 1]);
        [T_Inhibit,S_Inhibit]=Perturbed_Inhibitory_Model(-70,10,0,signal,length(signal)/Fs,Fs,0,[0 0 0],[0,0,0],[0 0 0],beta_std(j)*[1 1 1]);
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

    disp('Beta StdDev('+string(beta_std(j))+'): '+'mean inhibitory ('+string(mean(inhibitory_fires))+'), std dev inhibitory ('+string(std(inhibitory_fires))+'), mean excitatory ('+string(mean(excitatory_fires))+'), std dev excitatory ('+string(std(excitatory_fires))+')');
end

