n = 100:100:2000;
exec_times = zeros(size(n)); % Πραγματικοί χρόνοι

% Χρονομέτρηση για κάθε n
for i = 1:length(n)
    n_value = n(i);
    A = randn(n_value); % Δημιουργία τυχαίου μητρώου
    A = A * A'; % Μετατροπή σε συμμετρικό και θετικά ορισμένο μητρώο

    % Χρονομέτρηση της εκτέλεσης της chol
    f = @() chol(A);
    exec_times(i) = timeit(f);
end

% Προσαρμογή κυβικού πολυωνύμου στους χρόνους
p3 = polyfit(n, exec_times, 3);
p2 = polyfit(n, exec_times, 2);
p4 = polyfit(n, exec_times, 4);

% Δημιουργία της συνάρτησης Tchol
Tchol3 = @(n) p3(1)*n.^3 + p3(2)*n.^2 + p3(3)*n + p3(4);
Tchol2 = @(n) p2(1)*n.^2 + p2(2)*n + p2(3);
Tchol4 = @(n) p4(1)*n.^4 + p4(2)*n.^3 + p4(3)*n.^2 + p4(4)*n + p4(5);

% Υπολογισμός των προβλεπόμενων χρόνων
predicted_times3 = arrayfun(Tchol3, n);
predicted_times2 = arrayfun(Tchol2, n);
predicted_times4 = arrayfun(Tchol4, n);

% Γραφική παράσταση των χρονομετρήσεων και των προβλέψεων
figure;
hold on;
plot(n, exec_times, 'o', 'DisplayName', 'Real Execution Times');
plot(n, predicted_times3, 'b', 'DisplayName', 'Predicted Execution Times - 3rd degree');
plot(n, predicted_times2, 'r', 'DisplayName', 'Predicted Execution Times - 2nd degree');
plot(n, predicted_times4, 'g', 'DisplayName', 'Predicted Execution Times - 4th degree');
title('Comparison of Real and Predicted Execution Times');
xlabel('Matrix Size (n)');
ylabel('Execution Time (sec)');
legend;
grid on;
hold off;
