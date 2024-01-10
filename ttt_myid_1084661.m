function C = ttt_myid_1084661(A, B, mode)
    sizeA = size(A);
    sizeB = size(B);
    % Έλεγχος εάν το mode είναι ορισμένο και είναι 'all'
    if nargin == 3 && strcmp(mode, 'all')
        % Εσωτερικό γινόμενο των τανυστών
        if sizeA ~= sizeB
            disp('Τα arrays είναι συμβατά για εσωτερικό γινόμενο.');
        else
            C = sum(A(:) .* B(:));
        end
    else
        % Εξωτερικό γινόμενο των τανυστών
        % Υποθέτουμε ότι οι τανυστές A και B είναι multidimensional arrays
        C = reshape(A, [], 1) * reshape(B, 1, []);
        
        % Διαμόρφωση του αποτελέσματος στις σωστές διαστάσεις
        C = reshape(C, [sizeA, sizeB]);
    end
end
