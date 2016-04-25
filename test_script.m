%% Test script
function [] = test_script()
try
    eeglab;
    
    %% Load test data set
    data_filename = 'S1_Chan.set';
    data_filepath = './data/';
    eeg_in = pop_loadset('filename', data_filename ...
        , 'filepath', data_filepath);
    
    %% View/Verify input data
    eegplot(eeg_in.data ...
        , 'srate'    , eeg_in.srate ...
        , 'events'   , eeg_in.event ...
        , 'winlength', 20);
    
    %% Process data
    %     eeg_out_original  = eeg_interp(eeg_in, badchans);

    % Error test: Interpolating w/ only 1 channel
    ignored_chans     = [4 5 6 7 8 9 10 11 13 14 15 16];
    badchans          = [1 2 3];
    %     eeg_out_original  = eeg_interp(eeg_in, badchans);
    eeg_out_selective = erplab_selectiveEegInterpolation(eeg_in, badchans, ignored_chans);
    
    % Error occurs when you ignore all the channels
    ignored_chans     = [3 4 5 6 7 8 9 10 11 12 13 14 15 ];
    ignored_chans     = [3 4 5 6 7 8 9 10 11 12 13 14 15 16];
    eeg_out_selective = erplab_selectiveEegInterpolation(eeg_in, badchans, ignored_chans);
    
    % Error occurs when only 1 channel is used for interpolation
    
    
    %% View/Confirm output data
    eegplot(eeg_out_selective.data ...
        , 'srate'    , eeg_out_selective.srate ...
        , 'events'   , eeg_out_selective.event ...
        , 'winlength', 20);
    
    
catch err;
    rethrow(err);
end

end % function
