% Προεργασία
n = 150:100:1550;
exec_times = zeros(size(n)); % Διάνυσμα όπου αποθηκεύονται οι πραγματικοί χρόνοι εκτέλεσης της εντολής chol(A)

for i = 1:length(n) % Δημιουργία τυχαίων ΣΘΟ μητρώων τάξης n
    dimension = n(i);
    A = rand(dimension, dimension); % Επιλογή τυχαίων τιμών για το τετραγωνικό μητρώο Α 
    A = (A + A') / 2; % Μετατρέπουμε το μητρώο Α σε συμμετρικό
    A = A * A'; % Μετατρέπουμε το συμμετρικό μητρώο Α σε θετικά ορισμένο 

    f = @() chol(A); % Χρονομέτρηση της εκτέλεσης της εντολής chol(A) για κάθε n
    exec_times(i) = timeit(f);
end

disp('Πραγματικοί χρόνοι εκτέλεσης για κάθε διάσταση n:')
disp(num2str(exec_times))

% Ερώτημα 1
p3 = polyfit(n, exec_times, 3); % Υπολογισμός συντελεστών a3...a0 του πολυωνύμου με σκοπό την ελαχιστοποίηση σφάλματος
Tchol3 = @(n) p3(1)*n.^3 + p3(2)*n.^2 + p3(3)*n + p3(4); % Δημιουργία της κυβικής συνάρτησης Tchol(n)
disp('Κυβικό Πολυώνυμο:') % Εκτύπωση του πολυωνύμου
fprintf('Tchol(n) = %.8fn^3 + %.8fn^2 + %.8fn + %.8f\n', p3(1), p3(2), p3(3), p3(4)); 

% Ερώτημα 2
predicted_times3 = arrayfun(Tchol3, n); % Υπολογισμός των προβλεπόμενων χρόνων εκτέλεσης
disp('Προβλεπόμενοι χρόνοι εκτέλεσης για κάθε διάσταση n:'); % Εκτύπωση των προβλεπόμενων χρόνων εκτέλεσης
disp(num2str(predicted_times3));

% Ερώτημα 3
figure; % Γραφική παράσταση των χρονομετρήσεων και των προβλέψεών τους
hold on;
plot(n, exec_times, 'o', 'DisplayName', 'Real Execution Times'); % Χάραξη χρονομετρήσεων με 'ο'
plot(n, predicted_times3, 'b', 'DisplayName', 'Predicted Execution Times - 3rd degree'); % Χάραξη προβλέψεων με συνεχή μπλε γραμμή
title('Comparison of Real and Predicted Execution Times'); % Τίτλος γραφήματος
xlabel('Matrix Size (n)'); % Ονοματοδοσία άξονα x
ylabel('Execution Time (sec)'); % Ονοματοδοσία άξονα y
legend; % Υπόμνημα
grid on;
hold off;

mse3 = mean((exec_times - predicted_times3).^2); % Υπολογισμός του Μέσου Τετραγωνικού Σφάλματος (MSE)
fprintf('Μέσο Τετραγωνικό Σφάλμα με κυβικό πολυώνυμο: %.8f\n', mse3);

% Ερώτημα 4
p2 = polyfit(n, exec_times, 2);
Tchol2 = @(n) p2(1)*n.^2 + p2(2)*n + p2(3);
disp('Πολυώνυμο 2ου βαθμού:') % Εκτύπωση του πολυωνύμου
fprintf('Tchol(n) = %.8fn^2 + %.8fn + %.8f\n', p2(1), p2(2), p2(3)); 
predicted_times2 = arrayfun(Tchol2, n);
disp('Προβλεπόμενοι χρόνοι εκτέλεσης για κάθε διάσταση n:'); % Εκτύπωση των προβλεπόμενων χρόνων εκτέλεσης
disp(num2str(predicted_times2));

p4 = polyfit(n, exec_times, 4);
Tchol4 = @(n) p4(1)*n.^4 + p4(2)*n.^3 + p4(3)*n.^2 + p4(4)*n + p4(5);
disp('Πολυώνυμο 4ου βαθμού:') % Εκτύπωση του πολυωνύμου
fprintf('Tchol(n) = %.8fn^4 + %.8fn^3 + %.8fn^2 + %.8fn + %.8f\n', p4(1), p4(2), p4(3), p4(4), p4(5)); 
predicted_times4 = arrayfun(Tchol4, n);
disp('Προβλεπόμενοι χρόνοι εκτέλεσης για κάθε διάσταση n:'); % Εκτύπωση των προβλεπόμενων χρόνων εκτέλεσης
disp(num2str(predicted_times4));

figure; % Γραφική παράσταση των χρονομετρήσεων και των προβλέψεων για όλα τα πολυώνυμα
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

mse2 = mean((exec_times - predicted_times2).^2); % Υπολογισμός του Μέσου Τετραγωνικού Σφάλματος (MSE)
fprintf('Μέσο Τετραγωνικό Σφάλμα με τετραγωνικό πολυώνυμο: %.8f\n', mse2);
mse4 = mean((exec_times - predicted_times4).^2); % Υπολογισμός του Μέσου Τετραγωνικού Σφάλματος (MSE)
fprintf('Μέσο Τετραγωνικό Σφάλμα με πολυώνυμο 4ου βαθμού: %.8f\n', mse4);
