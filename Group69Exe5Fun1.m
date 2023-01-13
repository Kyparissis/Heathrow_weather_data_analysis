%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [mutualInfoEstimate, p, n] = Group69Exe5Fun1(sample1, sample2)
    %% Both samples must be vectors
    if ~(isvector(sample1) && isvector(sample2))
        error("ERROR FOUND! Two samples must be vectors. Aborting...");
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
        error("ERROR FOUND! Two sample vectors must have the same length. Aborting...");
    end

    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexesToKeep = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexesToKeep);
    sample2 = sample2(indexesToKeep);
    n = length(sample1); % == length(sample2)

    %% ============== (b') ==============
    % Discriminate both samples and make them "binary samples"
    sample1_discriminated = sample1 > median(sample1);
    sample2_discriminated = sample2 > median(sample2);
    
    % Calculate the marginal probabilities
    pS1 = sum(sample1_discriminated) / n;
    pS2 = sum(sample2_discriminated) / n;

    % Calculate the entropy of sample1
    H_S1 = -pS1 * log2(pS1) - (1 - pS1) * log2(1 - pS1);

    % Calculate the entropy of sample2
    H_S2 = -pS2 * log2(pS2) - (1 - pS2) * log2(1 - pS2);
    
    % Calculate the joint probabilities and joint entropy  
    % Bibliog.:  https://www.icg.isy.liu.se/courses/infotheory/lect1.pdf
    % Bibliog.:  https://people.cs.umass.edu/~elm/Teaching/Docs/mutInf.pdf
    % H_S1S2 = - pS1S2 * log2(pS1S2) - pS1_S2 * log2(pS1_S2) - pS2_S1 * log2(pS2_S1) p_S1S2 * log2(p_S1S2);
    % but it is assumed that 0*log(0) == 0 .The justification for this is that the limit of xlog x as x becomes small is 0.
    % So we do it step-by-step:
    H_S1S2 = 0; 
    pS1S2 = sum(sample1_discriminated & sample2_discriminated) / n;     % Pr{sample1_discrimination = 1, sample2_discrimination = 1}
    if pS1S2 ~= 0
        H_S1S2 = H_S1S2 - pS1S2 * log2(pS1S2);
    end
    pS1_S2 = sum(sample1_discriminated & ~sample2_discriminated) / n;   % Pr{sample1_discrimination = 1, sample2_discrimination = 0}
    if pS1_S2 ~= 0
        H_S1S2 = H_S1S2 - pS1_S2 * log2(pS1_S2);
    end
    pS2_S1 = sum(sample2_discriminated & ~sample1_discriminated) / n;   % Pr{sample1_discrimination = 0, sample2_discrimination = 1}
    if pS2_S1 ~= 0
        H_S1S2 = H_S1S2 - pS2_S1 * log2(pS2_S1);
    end
    p_S1S2 = sum(~sample1_discriminated & ~sample2_discriminated) / n;  % Pr{sample1_discrimination = 0, sample2_discrimination = 0}
    if p_S1S2 ~= 0
        H_S1S2 = H_S1S2 - p_S1S2 * log2(p_S1S2);
    end

    % Calculate the mutual information estimate
    mutualInfoEstimate = H_S1 + H_S2 - H_S1S2;

    %% ============== (c') ==============
    %% Non-parametric test using the randomization method
    % TODO: Check correctness. Gives expected output but formula might be wrong?
    numOfRandomizations = 3000;

    mutualInfoEstimate_rnd = nan(1, numOfRandomizations);
    
    for j = 1:numOfRandomizations
        ind = randperm(n);
%         ind2 = randperm(n);
        % Discriminate both samples and make them "binary samples"
        sample1_discriminated = sample1 > median(sample1);
        sample2_discriminated = sample2(ind) > median(sample2(ind));
        
        % Calculate the marginal probabilities
        pS1 = sum(sample1_discriminated) / n;
        pS2 = sum(sample2_discriminated) / n;

        % Calculate the entropy of sample1
        H_S1 = -pS1 * log2(pS1) - (1 - pS1) * log2(1 - pS1);

        % Calculate the entropy of sample2
        H_S2 = -pS2 * log2(pS2) - (1 - pS2) * log2(1 - pS2);

        % Calculate the joint probabilities and joint entropy  
        H_S1S2 = 0; 
        pS1S2 = sum(sample1_discriminated & sample2_discriminated) / n;     % Pr{sample1_discrimination = 1, sample2_discrimination = 1}
        if pS1S2 ~= 0
            H_S1S2 = H_S1S2 - pS1S2 * log2(pS1S2);
        end
        pS1_S2 = sum(sample1_discriminated & ~sample2_discriminated) / n;   % Pr{sample1_discrimination = 1, sample2_discrimination = 0}
        if pS1_S2 ~= 0
            H_S1S2 = H_S1S2 - pS1_S2 * log2(pS1_S2);
        end
        pS2_S1 = sum(sample2_discriminated & ~sample1_discriminated) / n;   % Pr{sample1_discrimination = 0, sample2_discrimination = 1}
        if pS2_S1 ~= 0
            H_S1S2 = H_S1S2 - pS2_S1 * log2(pS2_S1);
        end
        p_S1S2 = sum(~sample1_discriminated & ~sample2_discriminated) / n;  % Pr{sample1_discrimination = 0, sample2_discrimination = 0}
        if p_S1S2 ~= 0
            H_S1S2 = H_S1S2 - p_S1S2 * log2(p_S1S2);
        end

        % Calculate the mutual information estimate
        mutualInfoEstimate_rnd(j) = H_S1 + H_S2 - H_S1S2;
    end
    
    p = sum(mutualInfoEstimate_rnd >= mutualInfoEstimate) / numOfRandomizations;

end