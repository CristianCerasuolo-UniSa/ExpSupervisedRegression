function [hatY0] = KNN(x_train, y_train, x0, K)
% Make a prediction using KNN
    distances = [];
    for j=1:length(x_train)
        % Compute euclidean distance
        distances(j) = sqrt((x0 - x_train(j))^2);
    end
     % Trova gli indici dei k punti più vicini
    [~, neighbours] = mink(distances, K);

    % Prendi le etichette di classe dei k punti più vicini
    neighbours_labels = y_train(neighbours);

    hatY0 = mean(neighbours_labels);
end

