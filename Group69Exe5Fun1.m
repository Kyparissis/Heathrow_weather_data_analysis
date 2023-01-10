%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [mutualInfoEstimate, p, n] = Group69Exe5Fun1(sample1, sample2)
    %% Both samples must be vectors
    if ~(isvector(sample1) & isvector(sample2))
        error("ERROR FOUND! Two samples must be vectors.\nAborting...\n");
    end
    
    %% Make both vector samples column vectors
    if ~iscolumn(sample1)
        sample1 = sample1';
    end
    if ~iscolumn(sample2)
        sample2 = sample2';
    end

    %% Two sample vectors must have the same length
    if length(sample1) ~= length(sample2)
        error("ERROR FOUND! Two sample vectors must have the same length.\nAborting...\n");
    end

    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);
    n = length(sample1); % == length(sample2)

    %% ============== (b') ==============
    sample1_median = median(sample1);
    sample2_median = median(sample2);
    sample1_discrimination = sample1 > sample1_median;
    sample2_discrimination = sample2 > sample2_median;
    
    % Calculate the marginal probabilities
    pS1 = sum(sample1_discrimination) / n;
    pS2 = sum(sample2_discrimination) / n;

    % Calculate the entropy of sample1
    H_S1 = -pS1 * log2(pS1) - (1 - pS1) * log2(1 - pS1);

    % Calculate the entropy of sample2
    H_S2 = -pS2 * log2(pS2) - (1 - pS2) * log2(1 - pS2);
    
    % Calculate the joint probabilities and joint entropy  
    % https://www.icg.isy.liu.se/courses/infotheory/lect1.pdf
    % H_S1S2 = - pS1S2 * log2(pS1S2) - pS1_S2 * log2(pS1_S2) - pS2_S1 * log2(pS2_S1) p_S1S2 * log2(p_S1S2);
    % but it is assumed that 0*log(0) == 0 , so we do it step-by-step:
    H_S1S2 = 0; 
    pS1S2 = sum(sample1_discrimination & sample2_discrimination) / n;     % Pr{sample1_discrimination = 1, sample2_discrimination = 1}
    if pS1S2 ~= 0
        H_S1S2 = H_S1S2 - pS1S2 * log2(pS1S2);
    end
    pS1_S2 = sum(sample1_discrimination & ~sample2_discrimination) / n;   % Pr{sample1_discrimination = 1, sample2_discrimination = 0}
    if pS1_S2 ~= 0
        H_S1S2 = H_S1S2 - pS1_S2 * log2(pS1_S2);
    end
    pS2_S1 = sum(sample2_discrimination & ~sample1_discrimination) / n;   % Pr{sample1_discrimination = 0, sample2_discrimination = 1}
    if pS2_S1 ~= 0
        H_S1S2 = H_S1S2 - pS2_S1 * log2(pS2_S1);
    end
    p_S1S2 = sum(~sample1_discrimination & ~sample2_discrimination) / n;  % Pr{sample1_discrimination = 0, sample2_discrimination = 0}
    if p_S1S2 ~= 0
        H_S1S2 = H_S1S2 - p_S1S2 * log2(p_S1S2);
    end

    % Calculate the mutual information estimate
    mutualInfoEstimate = H_S1 + H_S2 - H_S1S2;

    %% ============== (c') ==============
    % Non-parametric test using the randomization method
    p = NaN;
    



end