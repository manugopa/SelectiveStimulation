This folder contains the scripts and models needed to reproduce the results
in "Harnessing Nonlinearity of Neural Response for Cell-type Selective
Stimulation: A Computational Study"

Files:

Excitatory_Model.m:

    Function for simulating single compartment excitatory model

Inhibitory_Model.m:

    Function for simulating single compartment inhibitory model

FiringVsFrequencyVsAmplitude.m:

    Script to generate plots that indicate firing rate of neurons in 
    response to sinusoidal inputs

ParameterPlotGenerator.m:

    Script to generate plots for steady state values and time constants for
    m, n, and h parameters of neuron types

SelectivitySignals_wExciteandInhibit.m:

    Script to generate plots of waveforms and responses for selective
    stimulation between excitatory and inhibitory models
Perturbed_Excitatory_Model.m

    Function for simulating single compartment excitatory model with
    perturbed dynamics
    
Perturbed_Inhibitory_Model.m

    Function for simulating single compartment inhibitory model with
    perturbed dynamics
    
NonSelectiveSignalPertubation.m

	Script to analyze performance of non-selective signals on models with
	perturbed dynamics
    
InhibitSelectiveSignalPerturbation.m

	Script to analyze performance of inhibit-selective signals on models with
	perturbed dynamics
    
ExciteSelectiveSignalPerturbation.m

	Script to analyze performance of excite-selective signals on models with
	perturbed dynamics
    
NoisySignals.m

	Script to analyze performance of signals in the presence of white
	Gaussian noise

Folder:

multicompartment:

    Folder containing NEURON models and waveforms needed to reproduce
    multicompartment results
    
