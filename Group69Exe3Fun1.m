function [p1, p2] = Group69Exe3Fun1(years, indicatorSample)
    %% ============== (a') ==============
    % Find discontinued values on the years vector argument
    problematicIndexes = find(diff(years) ~= 1);
    
    % If no such point is found, stop execution and throw an error
    if isempty(problematicIndexes)
        fprintf("ERROR FOUND! Discontinuity couldn't be found the first argument.\n")
        fprintf("Aborting...\n")
        
        p1 = NaN;
        p2 = NaN;
        
        return;
    end
    
%     % Debugging:
%     fprintf("Discontinuity, in the first argument, found firstly between index #%d and index #%d .\n", problematicIndexes(1), problematicIndexes(1) + 1)
%     fprintf("Value at index #%d is %d .\n", (problematicIndexes(1)) , years((problematicIndexes(1))) );
%     fprintf("Value at index #%d is %d .\n", (problematicIndexes(1) + 1) , years(problematicIndexes(1) + 1) );

    %% ============== (b') ==============
    % Splitting the indicatorSample into two vectors based on where discontinuity is first found
    sample_X1 = indicatorSample(1:(problematicIndexes(1)));
    sample_X2 = indicatorSample((problematicIndexes(1) + 1):length(indicatorSample));

    %% ============== (c') ==============
    

    %% ============== (d') ==============
    

end