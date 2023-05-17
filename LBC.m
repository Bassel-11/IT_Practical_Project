action = input('Do you want to encode or decode a message? ', 's');

if strcmp(action, 'encode')
    % Encoding code
    p = input('Enter the parity check matrix: ');
    k = input('Enter the message length: ');
    n = input('Enter the codword length: ');
    g = [p eye(k)];
    u = input('Enter the message: ');
    disp('The encoded message:');
    v = encode(u, n, k, 'linear' ,g)';
    disp(v);
elseif strcmp(action, 'decode')
    % Decoding code
    g = input('Enter the generator matrix: ');
    [k, n] = size(g);
    x = n - k;
    h = gen2par(g);
    v = input('Enter the received message: ');
    ht = h';
    sv = v * ht;
    s = mod(sv, 2);
    if sum(s) == 0
        disp('No error');
        disp('The decoded message:');
        u = v(x+1:n);
        disp(u);
    else
        for i = 1:size(ht, 1)
            if ht(i,1:x) == s
                v(i) = 1 - v(i);
                break;
            end
        end
        disp('The error is in bit:');
        disp(i);
        disp('The corrected code vector:');
        disp(v);
        disp('The decoded message:');
        u = v(x+1:n);
        disp(u);
    end
else
    disp('Invalid input');
end
