%% Test script
function [outputEEG] = test_script()
try
    
    eeglab;
    
    %% Load test data set
    data_filename = 'S1_EEG.set';
    data_filepath = './data/';
    inputEEG = pop_loadset('filename', data_filename ...
        , 'filepath', data_filepath);
    
    %% View/Verify input data
    %     eegplot(inputEEG.data ...
    %         , 'srate'    , inputEEG.srate ...
    %         , 'events'   , inputEEG.event ...
    %         , 'winlength', 20);
    
    %% Process data
    eventcodes = {'22', '19'};
    timeshift  = -15;
    outputEEG  = erplab_shiftevents_eeg(inputEEG, eventcodes, timeshift);
    
    
    %% View/Confirm output data
    %     eegplot(outputEEG.data ...
    %         , 'srate'    , outputEEG.srate ...
    %         , 'events'   , outputEEG.event ...
    %         , 'winlength', 20);
    %
    
    
catch err;
    rethrow(err);
end

end % function
