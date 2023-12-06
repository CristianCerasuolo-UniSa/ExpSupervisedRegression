function [hatY0] = NaiveKernel(x_train, y_train, x0, h)
% Make a prediction using Naive kernel
    y_int = []; k=1;
    for j = 1:length(x_train)
        % Collect the label of train samples 
        % that are in the neighbourhood of test sample
        if abs(x_train(j) - x0) < h 
            y_int(k) = y_train(j);
            k = k+1;
        end
    end
    % Make an estimate for that test sample
    hatY0 = mean(y_int);

end

