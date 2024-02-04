function Y = ttv_1084661(X, V, N)

    if ~isnumeric(X) || ndims(X) ~= 3 % Ελέγχουμε εάν το X είναι τανυστής 3 τρόπων
        error('Το X πρέπει να είναι τανυστής 3 τρόπων.');
    end

    if ~isvector(V) % Ελέγχουμε εάν το V είναι διάνυσμα(στήλης)
        error('Το V πρέπει να είναι διάνυσμα.');
    end
    
    if not(any(length(V) == size(X))) % Έλεγχος αν η διάσταση του διανύσματος ταιριάζει με οποιαδήποτε από τις διαστάσεις του τανυστή
        error('Η διάσταση του διανύσματος δεν είναι συμβατή με τη διάσταση του τανυστή.');
    end

    I = size(X, 1);
    J = size(X, 2);
    K = size(X, 3);

    if N == 1   
        Y = squeeze(sum(bsxfun(@times, X, reshape(V, I, 1, 1)), 1));
    elseif N == 2
        Y = squeeze(sum(bsxfun(@times, X, reshape(V, 1, J, 1)), 2));
    elseif N == 3
        Y = squeeze(sum(bsxfun(@times, X, reshape(V, 1, 1, K)), 3));
    end
end
