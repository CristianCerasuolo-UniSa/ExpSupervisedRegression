function [MSE_NN_distance, MSE_NK_distance, MSE_NN_error, MSE_NK_error] = NK_vs_KNN(NTrain, NPred, a, se, h, K)

    %%% GENERATE TRAINING DATA
    x = unifrnd(0, a, 1, NTrain);
    e = normrnd(0, se, 1, NTrain);
    y = sin(2*pi*x) + e;

    %%% GENERATE PREDICTION DATA
    x0s = unifrnd(0, a, 1, NPred);
    x0s = sort(x0s);
    e0 = normrnd(0, se, 1, NPred);

    fx = sin(2*pi*x0s);
    y0s = fx + e0; % r(x0s)

    %%% MAKE PREDICTION
    NK_pred = zeros(1, NPred);
    NN_pred = zeros(1, NPred);

    for i=1:length(x0s)
        
        %%% NAIVE KERNEL
        NK_pred(i) = NaiveKernel(x, y, x0s(i), h);

        %%% KNN
        NN_pred(i) = KNN(x, y, x0s(i), K);

    %%% PLOT

    end
    figure("Name","Estimates")
    hold on
    grid
    plot(x0s, fx,' -', 'Color', "#77AC30",'markersize', 10, 'linewidth', 2, 'DisplayName', 'True Regression')
    plot(x0s, NK_pred, '-', 'Color', "#D95319",'markersize', 10, 'linewidth', 2, 'DisplayName', 'Naive Kernel Estimates')
    plot(x0s, NN_pred, '-', 'Color', "#EDB120", 'markersize', 10, 'linewidth', 2, 'DisplayName', 'Nearest Neighbours Estimates')
    xlabel({'$$X$$'}, 'interpreter', 'latex', 'FontSize', 18)
    ylabel('$$\hat Y$$', 'Interpreter', 'latex', 'FontSize', 18)
    titles = ['$$N_{train}$$ = ', num2str(NTrain) ,' $$K$$ = ', num2str(K), ...
    ' h = ', num2str(h)];
    title(titles, 'interpreter', 'latex', 'FontSize', 20)
    legend("show")

    %%% ERROR CALCULATION
    
    % (r_n(x0s)-r(x0s))^2 -> Distance from true regression function
    MSE_NN_distance = mean((NN_pred - sin(2*pi*x0s)).^2);
    MSE_NK_distance = mean((NK_pred - sin(2*pi*x0s)).^2);


    % (r_n(x0s)-y0s)^2 -> Error from the observation
    MSE_NN_error = mean((NN_pred - y0s).^2);
    MSE_NK_error = mean((NK_pred - y0s).^2);
end

