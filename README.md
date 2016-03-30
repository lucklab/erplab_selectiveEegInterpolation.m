# Selective EEG Channel Interpolation
Modified version of EEGLAB's EEG channel interpolation function `eeg_interp.m` that allows the user to ignore a set of electrodes for interpolating bad channels

#### Inputs
- `eeg_in`        - EEGLAB EEG data struction to interpolate
- `replace_chans` - array of channels to replace via interpolation
- `ignored_chans` - array of channels to ignore as input for interpolation 

#### Outputs
- EEGLAB EEG data structure

#### Example
```matlab
eeglab;

%% Load test data set
data_filename = 'S1_Chan.set';
data_filepath = './data/';
eeg_in = pop_loadset('filename', data_filename, 'filepath', data_filepath);

%% Process data
replace_chans     = [1 2 3];                        % Replace these channels via interpolation
ignored_chans     = [4 5 6 7 8 9 10 11   14 15 16]; % Interpolate using electrodes 12 & 13
eeg_out_selective = erplab_selective_eeg_interp(eeg_in, replace_chans, ignored_chans);


```
