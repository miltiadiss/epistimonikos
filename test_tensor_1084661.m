function test_tensor_1084661
    % Αρχικοποίηση
    tol = 1e-8; nd = 3; rng(0); err = zeros(1, nd+2);
    ndim = [2, 3, 4]; Atemp = randi(5, ndim); Btemp = randi(4, ndim);
    X = randi([-1, 1], max(ndim), 1); A = tt_tensor(Atemp); B = tt_tensor(Btemp);

    % Έλεγχος των συναρτήσεων
    try
        for k = 1:nd
            err(k) = norm(ttv_myid(A, X(1:ndim(k), 1), k) - double(ttv(A, X(1:ndim(k), 1), k)));
        end
        assert(max(err) < tol, 'ttm modal multiplication fails');
    catch ME1
    end

    try
        err(nd+1) = norm(tensor(ttt_myid(A, B)) - ttt(A, B));
        assert(err(nd+1) < tol, 'ttt outer multiplication fails');
    catch ME2
    end

    try
        err(nd+2) = abs(ttt_myid(A, B, 'all') - double(ttt(A, B, 1:nd)));
        assert(err(nd+2) < tol, 'ttt inner product fails');
    catch ME3
    end

    % Εκτύπωση τυχόν σφαλμάτων
    if (exist('ME1', 'var'))
        disp(ME1.message);
    end
    if (exist('ME2', 'var'))
        disp(ME2.message);
    end
    if (exist('ME3', 'var'))
        disp(ME3.message);
    end
end
