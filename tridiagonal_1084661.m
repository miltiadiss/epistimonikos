function x = tridiagonal_1084661(A, B)
   
    A_0 = A; % Ξεκινάμε διασπώντας το μητρώο Α(0) σε D, L, U
    D = diag(diag(A_0)); % Κατασκευάζουμε το διαγώνιο μητρώο D
    D_inv = diag(1 ./ diag(D)); % Κατασκευάζουμε το αντίστροφο D
    L = diag(diag(A_0, -1),-1); % Κατασκευάζουμε το κάτω τριγωνικό μητρώο L
    U = diag(diag(A_0, 1),1); % Κατασκευάζουμε το άνω τριγωνικό μητρώο U

    % Μετασχηματίζουμε τα D, L, U σε D(1), L(1), U(1)
    D_1 = D - L * D_inv * U - U * D_inv * L; 
    L_1 = L * D_inv * L; 
    U_1 = U * D_inv * U; 
    A_1 = D_1 - L_1 - U_1; % Μετασχηματίζουμε το μητρώο Α(0) σε Α(1)

    % Μετασχηματίζουμε τα διανύσματα b(0) του μητρώου B(0) σε b(1) στο
    % μητρώο Β(1)
    B_0 = B;
    B_1 = zeros(size(B));
    for i = 1 : size(B)
        B_1(:,i) = B_0(:,i) + L * D_inv * B_0(:,i) + U * D_inv * B_0(:,i);
    end

    A_k=A_1;
    disp(A_k);
    B_k = B_1;
    x = zeros(5, 5);
  
    for i = 1 : ceil(log2((size(A) - 1) / 2)) + 1
        if not(isequal(A_k, diag(diag(A_k))))
            % Calculate A_{k+1} 
            D_k = diag(diag(A_k));
            D_inv_k = diag(1 ./ diag(D_k));
            L_k = diag(diag(A_k, -2^i), -2^i);
            U_k = diag(diag(A_k, 2^i), 2^i);
           
            D_k = D_k - L_k * D_inv_k * U_k - U_k * D_inv_k * L_k;
            L_k = L_k * D_inv_k * L_k;
            U_k = U_k * D_inv_k * U_k;
            D_inv_k = diag(1 ./ diag(D_inv_k));
            
            A_k = (D_k + L_k + U_k) * D_inv_k * (D_k - L_k - U_k);
            disp(num2str(A_k));
    
            B_k = B_k + L_k * D_inv_k * B_k + U_k * D_inv_k * B_k; 
            %disp(num2str(B_k));
        else
            for j = 1:size(B,2)
                x(:, j) =  A_k \ B_k(:, j); % A is diagonal, solve the system directly
            end
        end
    end
end
