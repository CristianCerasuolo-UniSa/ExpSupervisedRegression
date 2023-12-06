function [] = KNNAnalysis(MC)
    
    se = 1;
    a = 1;

    blue = [0 0.4470 0.7410];
    red = [0.9290 0.6940 0.1250];
    yellow = [0.4940 0.1840 0.5560];
    violet = (1/255)*[102 255 178];


    %% VARYING N

    NTrain_min = 1; % 10^0
    NTrain_max = 5; % 10^5

    K = 10;

    num_tests = 20;
    tests = round(logspace(NTrain_min, NTrain_max, num_tests));
    MSEs_NN = zeros(1, num_tests);

    for i = 1:length(tests)
        for j = 1:MC
            NTrain = tests(i);
            [~, MSE_NN] = NonParametricModels(NTrain, se, a, 0, K, 0, "nn");
            MSEs_MC(j) = MSE_NN;
        end
        MSEs_NN(i) = mean(MSEs_MC);
    end

    % Plot the values varying N
    figure("Name", "MSE of NN varying N")
    semilogx(tests, MSEs_NN, '-o','color', red,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    grid
    titles = [' $$K$$ = ', num2str(K), ...
    ' MC = ', num2str(MC)];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$N$', 'interpreter', 'latex','FontSize', 18)

    %% VARYING K

    NTrain = 10^5;
    
    K_min = 0; % 10^0
    K_max = 5; % 10^6
    num_tests = 20;
    tests = round(logspace(K_min, K_max, num_tests));
    MSEs_NN = zeros(1, num_tests);

    for i = 1:length(tests)
        for j = 1:MC
            K = tests(i);
            [~, MSE_NN] = NonParametricModels(NTrain, se, a, 0, K, 0, "nn");
            MSEs_MC(j) = MSE_NN;
        end
        MSEs_NN(i) = mean(MSEs_MC);
    end
    
    [~, min_index] = mink(MSEs_NN, 1);
 
    % Plot the values varying K
    figure("Name", "MSE of NN varying K")
    semilogx(tests, MSEs_NN, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    xline(tests(min_index), 'blue', {'$$\hat K$$'}, 'interpreter', 'latex', 'DisplayName', 'Best K');
    xline(round(sqrt(NTrain)), 'red', {'$$\sqrt{N_{train}}$$'}, 'interpreter', 'latex', 'DisplayName', 'Empiric Best K');
    grid
    titles = [ ' $$N_{train}$$ = ', ...
        num2str(NTrain), ' MC = ', num2str(MC)];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$K$', 'interpreter', 'latex','FontSize', 18)

    % Plot the values varying K
    figure("Name", "MSE of NN varying K log")
    loglog(tests, MSEs_NN, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    xline(tests(min_index), 'blue', {'$$\hat K$$'}, 'interpreter', 'latex', 'DisplayName', 'Best K');
    xline(round(sqrt(NTrain)), 'red', {'$$\sqrt{N_{train}}$$'}, 'interpreter', 'latex', 'DisplayName', 'Empiric Best K');
    grid
    titles = [ ' $$N_{train}$$ = ', ...
        num2str(NTrain), ' MC = ', num2str(MC)];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$K$', 'interpreter', 'latex','FontSize', 18)

    %% VARYING K/N
    
    num_tests = 20;
    tests = round(logspace(NTrain_min, NTrain_max, num_tests));
    MSEs_NN = zeros(1, num_tests);

    for i = 1:length(tests)
        for j = 1:MC
            NTrain = tests(i);
            K = round(sqrt(NTrain));
            [~, MSE_NN] = NonParametricModels(NTrain, se, a, 0, K, 0, "nn");
            MSEs_MC(j) = MSE_NN;
        end
        MSEs_NN(i) = mean(MSEs_MC);
    end

    % Plot the values varying K/N
    figure("Name", "MSE of NN varying K/N")
%     semilogx(round(sqrt(tests))./tests, MSEs_NN, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    semilogx(tests, MSEs_NN, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    grid
    titles = [' MC = ', num2str(MC), ' K = $$\sqrt{N}$$ '];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$N$', 'interpreter', 'latex','FontSize', 18)
end

