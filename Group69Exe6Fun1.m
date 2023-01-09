%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function R2 = Group69Exe6Fun1(sample1, sample2)
    %% Two sample vectors must have the same length
    if length(sample1) ~= length(sample2)
        fprintf("ERROR FOUND! Two sample vectors must have the same length.\n");
        fprintf("Aborting...\n")
        R2 = NaN;

        return;
    end

    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);
    n = length(sample1);


    %% ============== (b') ==============
    % Linear regression model using least squares method
    x = [ones(n,1) sample1];
    Y = sample2;
    [b, ~] = regress(Y, x);

    % Linear regression model: y = ax + b = b(2)*x + b(1)
    x0 = linspace(min(sample1), max(sample1), 2)';
    y0 = b(2)*x0 + b(1);
    
    y = x * b;     % Predicted values
    e = Y - y;    % Error

    % R-squared statistic
    R2 = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2));

    %% ============== (c') ==============
    % Create the scatter plot
    figure;
    scatter(sample1, sample2, 12, 'blue', 'filled');
    hold on;
    plot(x0,y0,'LineWidth',2, 'Color', 	"#D95319");
    text(max(xlim), max(ylim), sprintf("R^2 = %f", R2), 'Horiz','right', 'Vert', 'cap')


end