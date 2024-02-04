% Ερώτημα 1
n = 5; % Ορισμός του μεγέθους των μητρώων Α, Β διάστασης nxn

A = full(gallery('tridiag', n, randn(1, n-1), randn(1, n), randn(1, n-1)));
B = randn(n, n); % Δημιουργία ενός τυχαίου μητρώου B διάστασης nxn, δηλαδή έχουμε n διανύσματα b nx1 για n διαφορετικά συστήματα Ax = b

disp('Τριδιαγώνιο Μητρώο Α:');
disp(num2str(A));

disp('Διανύσματα b (Στήλες Μητρώου Β):')
disp(num2str(B));

tic;  % Εκκίνηση χρονομέτρησης
x = tridiagonal_1084661(A, B); % Επιλύουμε τα συστήματα με τη συνάρτηση που κατασκευάσαμε 
disp('Λύσεις συστημάτων Αx = b:')
disp(num2str(x));
cost = toc;  % Συνολικός χρόνος εκτέλεσης
disp('Χρόνος εκτέλεσης:');
disp(num2str(cost));

% Ερώτημα 3
A = zeros(n, n);
for i = 1 : n
    for j = 1 : n
        if i~= j
            A(i, j) = randn(); % Τυχαία γέμισμα του μητρώου
        end
    end
end

A = A + diag(sum(abs(A), 2) + randn()); % Δημιουργία τυχαίου διαγώνια κυρίαρχου μητρώου
disp('Διαγώνια Κυρίαρχο Μητρώο Α:');
disp(num2str(A));

upper_diag_norm = norm(triu(A), 2); % Υπολογισμός νόρμας υπερδιαγωνίων
disp('Νόρμα L2 υπερδιαγωνίων');
disp(num2str(upper_diag_norm));

lower_diag_norm = norm(tril(A), 2); % Υπολογισμός νόρμας υποδιαγωνίων
disp('Νόρμα L2 υποδιαγωνίων');
disp(num2str(lower_diag_norm));

