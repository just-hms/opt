P = [0.7 0.8
     0.8 0.3
     0.3 0.5
     0.7 0.7
     0.7 0.9
     0.2 1.0
     0.1 0.5
     0.5 1.0
     1.0 0.1
     0.3 0.3
     0.6 0.8
     0.2 0.3];

l = height(P);

k = 4;

% starting centroids
C = [0 0; 1 1; 0 1; 0.5 0.5];

a = zeros(l, k);

% TODO IMPLEMENT STOPPING CRITERION
for step = 1:10
    % Update the alfas
    for i = 1:l
        min_v = +inf;
        for h = 1:k
            min_v = min(min_v, norm(P(i,:) - C(h,:)));
        end
    
        for j = 1:k
            if norm(P(i,:) - C(j,:)) == min_v
                a(i, j) = 1;
                break
            end
        end
    end
    
    for j = 1:k
        num = 0;
        for i = 1:l
            num = num + a(i,j)*P(i,:);
        end
        den = 0;
        for i = 1:l
            den = den + a(i,j);
        end
    
        if den ~= 0
            C(j,:) = num/den;
        end
    end


end

function n = f(x, a)
    n = 5;
end