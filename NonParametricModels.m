function [SE_NK, SE_NN, MMSE] = NonParametricModels(NTrain, se, a, h, K, p, model)
    % NTrain is the number of training samples to generate
    % NTest is the number of test sample to take in the interval [0, a]
    % a is the upper bound of the considered interval
    % h is the neighbourood ray
    % K is the number of neighbours to consider in KNN
    % p indicates if we want plot or not
    % model indicates the model we want to use
        % "nk" for Naive Kernel
        % "nn" for KNN
        % "both"

    

    x_train = unifrnd(0, a, 1, NTrain);
    e = normrnd(0, se, 1, NTrain);

    y_train = sin(2*pi*x_train) + e;
    
    if p
        figure("Name", "Dataset")
        hold on
        grid
        plot(x_train, y_train, 'o', 'markersize', 10, 'linewidth', 2, 'DisplayName', 'Data')
        xlabel("$x_{train}$", "Interpreter","latex", "FontSize", 18)
        ylabel("$y_{train}$", "Interpreter","latex", "FontSize", 18)
    end

    % Generate test samples
    x0 = unifrnd(0,a);
    e0 = normrnd(0, se);
    y0 = sin(2*pi*x0) + e0;

    %% NAIVE KERNEL
    if model == "nk" || model == "both"
        NKE = NaiveKernel(x_train, y_train, x0, h);
    end
    %% KNN
    if model == "nn" || model == "both"
        NNE = KNN(x_train, y_train, x0, K);
    end

    %% RESULTS
    SE_NK = 0;
    SE_NN = 0;

    % Calculting the error as distance from the true regression functon
    % estimates
    if model == "nk" || model == "both"
        SE_NK = (NKE - sin(2*pi*x0))^2;
    end
    if model == "nn" || model == "both"
        SE_NN = (NNE - sin(2*pi*x0))^2;
    end

    % Calculating the error of optimal estimator
    MMSE = (sin(2*pi*x0) - y0).^2;

end

