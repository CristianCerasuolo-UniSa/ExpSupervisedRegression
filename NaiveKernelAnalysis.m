function [] = NaiveKernelAnalysis(MC)

    se = 1;
    a = 1;

    blue = [0 0.4470 0.7410];
    red = [0.9290 0.6940 0.1250];
    yellow = [0.4940 0.1840 0.5560];
    violet = (1/255)*[102 255 178];

    %% VARYING N

    NTrain_min = 1; % 10^0
    NTrain_max = 6; % 10^6
    h = 0.5;
    
    num_tests = 20;
    tests = round(logspace(NTrain_min, NTrain_max, num_tests));
    MSEs_NK = zeros(1, num_tests);

    for i = 1:length(tests)
        for j = 1:MC
            NTrain = tests(i);
            [MSE_NK, ~, ~] = NonParametricModels(NTrain, se, a, h, 0, 0, "nk");
            MSEs_MC(j) = MSE_NK;
        end
        MSEs_NK(i) = mean(MSEs_MC);
    end
    
    % Plot the values varying N
    figure("Name", "MSE of NK varying N")
    semilogx(tests, MSEs_NK, '-o','color', red,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    grid
    titles = [' $$h$$ = ', num2str(h), ...
    ' MC = ', num2str(MC)];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$N$', 'interpreter', 'latex','FontSize', 18)
    axis([min(tests), max(tests), min(MSEs_NK), max(MSEs_NK)])

    %% VARYING H

    NTrain = 10^5;
    
    H_min = 0; % 10^0
    H_max = -5; % 10^-5
    num_tests = 20;
    tests = logspace(H_min, H_max, num_tests);
    MSEs_NK = zeros(1, num_tests);

    for i = 1:length(tests)
        for j = 1:MC
            h = tests(i);
            [MSE_NK, ~, ~] = NonParametricModels(NTrain, se, a, h, 0, 0, "nk");
            MSEs_MC(j) = MSE_NK;
        end
        MSEs_NK(i) = mean(MSEs_MC);
    end
    
    [~, min_index] = mink(MSEs_NK, 1);
 
    % Plot the values varying H
    figure("Name", "MSE of NK varying H")
    semilogx(tests, MSEs_NK, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    xline(tests(min_index), 'blue', {'$$\hat h$$'}, 'interpreter', 'latex', 'DisplayName', 'Best h');
    xline(1/sqrt(NTrain), 'red', {'$$\sqrt{N_{train}}$$'}, 'interpreter', 'latex', 'DisplayName', 'Empiric Best h');
    grid
    titles = [ ' $$N_{train}$$ = ', ...
        num2str(NTrain), ' MC = ', num2str(MC)];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$h$', 'interpreter', 'latex','FontSize', 18)
    axis([min(tests), max(tests), min(MSEs_NK), max(MSEs_NK)])

    % Plot the values varying H
    figure("Name", "MSE of NK varying H log")
    loglog(tests, MSEs_NK, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    xline(tests(min_index), 'blue', {'$$\hat h$$'}, 'interpreter', 'latex', 'DisplayName', 'Best h');
    xline(1/sqrt(NTrain), 'red', {'$$\sqrt{N_{train}}$$'}, 'interpreter', 'latex', 'DisplayName', 'Empiric Best h');
    grid
    titles = [ ' $$N_{train}$$ = ', ...
        num2str(NTrain), ' MC = ', num2str(MC)];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$h$', 'interpreter', 'latex','FontSize', 18)
    axis([min(tests), max(tests), min(MSEs_NK), max(MSEs_NK)])

    %% VARYING N•h

    NTrain_min = 1; % 10^0
    NTrain_max = 6; % 10^6
    num_tests = 20;
    tests = round(logspace(NTrain_min, NTrain_max, num_tests));
    MSEs_NK = zeros(1, num_tests);

    for i = 1:length(tests)
        for j = 1:MC
            NTrain = tests(i);
            h = 1/sqrt(NTrain);
            [MSE_NK, ~, ~] = NonParametricModels(NTrain, se, a, h, 0, 0, "nk");
            MSEs_MC(j) = MSE_NK;
        end
        MSEs_NK(i) = mean(MSEs_MC);
    end

    % Plot the values varying N
    figure("Name", "MSE of NK varying N•h")
%     semilogx(tests.*(1./sqrt(tests)), MSEs_NK, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    semilogx(tests, MSEs_NK, '-o','color', blue,'markersize', 10, 'linewidth', 2, 'DisplayName', 'MSE')
    grid
    titles = [' MC = ', num2str(MC), ' h = $$1/\sqrt{N}$$ '];
    title(titles,'interpreter', 'latex', 'FontSize', 20)
    ylabel({'$$MSE$$'}, 'interpreter', 'latex', 'FontSize',18)
    xlabel('$N$', 'interpreter', 'latex','FontSize', 18)
%     axis([min(tests.*(1./sqrt(tests))), max(tests.*(1./sqrt(tests))), min(MSEs_NK), max(MSEs_NK)])
    axis([min(tests), max(tests), min(MSEs_NK), max(MSEs_NK)])

end

