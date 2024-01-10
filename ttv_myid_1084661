function Y = ttv_myid_1084661(X, V, N)
    % Έλεγχος εάν το X είναι multidimensional array
    if ~isnumeric(X) || ndims(X) < 2
        error('Το X πρέπει να είναι ένα multidimensional array.');
    end

    % Έλεγχος εάν το V είναι διάνυσμα
    if ~isvector(V)
        error('Το V πρέπει να είναι διάνυσμα.');
    end

    % Έλεγχος εάν το N είναι έγκυρος ακέραιος
    if ~isscalar(N) || N < 1 || N > ndims(X)
        error('Το N πρέπει να είναι ένας έγκυρος ακέραιος που δείχνει μία διάσταση του X.');
    end

    % Έλεγχος συμβατότητας διαστάσεων
    if size(X, N) ~= length(V)
        error('Η διάσταση του X κατά το N πρέπει να ταιριάζει με το μήκος του V.');
    end

    % Πραγματοποίηση του πολλαπλασιασμού
    Y = shiftdim(X, N-1);
    % Προσαρμογή του διανύσματος V στις διαστάσεις του X
    V = shiftdim(V(:), N - 1); % Εξασφαλίζουμε ότι το V είναι σωστά προσανατολισμένο
    Y = bsxfun(@times, Y, V.');
    Y = shiftdim(Y, ndims(Y) - N + 1);
    Y = squeeze(Y);
end
