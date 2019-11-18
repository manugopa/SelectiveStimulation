This folder contains the scripts and models needed to reproduce the results
in "Harnessing Nonlinearity of Neural Response for Cell-type Selective
Stimulation: A Computational Study"

Files:
Excitatory_Model.m
    Function for simulating single compartment excitatory model
Inhibitory_Model.m
    Function for simulating single compartment inhibitory model
PV_Model.m
    Function for simulating single compartment PV model
FiringVsFrequencyVsAmplitude.m
    Script to generate plots that indicate firing rate of neurons in 
    response to sinusoidal inputs
ParameterPlotGenerator.m
    Script to generate plots for steady state values and time constants for
    m, n, and h parameters of neuron types
SelectivitySignals_wExciteandInhibit.m
    Script to generate plots of waveforms and responses for selective
    stimulation between excitatory and inhibitory models
SelectivitySignals_wPVandInhibit.m
    Script to generate plots of waveforms and responses for selective
    stimulation between PV and inhibitory models
SelectivitySignals_wPVandExcite.m
    Script to generate plots of waveforms and responses for selective
    stimulation between PV and excitatory models
SelectivitySignals_wPVandInhibitandExcite.m
    Script to generate plots of waveforms and responses for selective
    stimulation between all three neuron models

Folder:
multicompartment
    Folder containing NEURON models and waveforms needed to reproduce
    multicompartment results
    
