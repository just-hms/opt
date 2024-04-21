
%% Clustering problem - Exercise 7.1 a) b)

clear; close all; clc;

data = [ 1.2734    6.2721
    2.7453    7.4345
    1.6954    8.6408
    1.1044    8.6364
    4.8187    7.3664
    2.7224    6.3303
    4.8462    8.4123
    4.0497    6.7696
    1.0294    8.6174
    3.7202    5.1327
    3.8238    7.1297
    3.5805    7.8660
    3.2092    5.7172
    1.8724    6.3461
    4.0895    5.7509
    1.9121    6.2877
    2.4835    6.6154
    4.5637    7.1943
    4.4255    5.1950
    2.6097    7.2109
    6.0992    8.0496
    5.9660    7.3042
    5.9726    7.9907
    5.6166    7.5821
    8.8257    5.4929
    8.7426    7.0176
    8.2749    6.3890
    7.9130    5.3686
    5.7032    5.5914
    6.4415    5.7927
    5.7552    7.6891
    5.0048    6.7260
    6.2657    7.7776
    7.7985    6.0271
    7.5010    5.0390
    7.1722    7.1291
    6.7561    6.1176
    6.1497    8.7849
    7.0066    8.6258
    8.0462    6.5707
    3.0994    1.7722
    5.6857    2.3666
    6.3487    4.7316
    6.8860    2.5627
    3.2277    2.0929
    4.8013    1.6078
    5.3299    2.5884
    5.7466    2.4989
    5.8777    1.5245
    5.6002    2.7402
    5.9077    1.3661
    4.4954    3.4585
    5.3263    1.0439
    3.4645    3.2930
    3.2306    4.1589
    6.9191    1.9415
    4.1393    2.7921
    5.3799    3.2774
    6.8486    1.2456
    3.7431    2.9852];

l = size(data,1); % number of patterns

k=3;

% to improve the result we could also try a multistart approach, hence
% write a program that tries the algorithm different times with different
% starts

% HA DETTO CHE QUESTA VARIANTE NON E' DA IMPARARE

%{
vbest = inf 
xbest = []
clusterbets = []
maxiter = 1000
iter = 0

where iter < maxiter

    %consider a random centroid 
    InitialCentroids=10*rand(k,2);

    [x,cluster,v] = kmeans1(data,k,InitialCentroids);
    
    if v < vbest 
        xbest=x;
        clusterbest=cluster;
        vbest=v;
    end
    iter = iter +1
end 

%}

% se ti da le associazioni dei centroidi iniziali invece delle loro coordinate 
% cioè avrai un vettore tipo 
% k = [ 1 , 1 , 1 , 2 , 2 , 2 , 3 , 3 , 3 , 4 , 4 , 4 ]
% dove per ogni punto ti dice il cluster iniziale di assegnamento 
% devi calcolarti i centroidi iniziali con questo codice 

%{
X is the dataset

for p = 1 : 4
    InitialCentroids( p , : ) = mean( X( k == p , : ) , 1 );
end
%}



InitialCentroids=[5,7;6,3;4,4]; 


% v is the optimal value given by objective function for the centroids and the assignment found so far in the 
% algorithm 
[x,cluster,v] = kmeans1(data,k,InitialCentroids)

 % plot centroids

 plot(x(1,1),x(1,2),'b*',x(2,1),x(2,2),'r*',x(3,1),x(3,2),'g*');
hold on

% plot cluster

c1 = data(cluster==1,:);
c2 = data(cluster==2,:);
c3 = data(cluster==3,:);
plot(c1(:,1),c1(:,2),'bo',c2(:,1),c2(:,2),'ro',c3(:,1),c3(:,2),'go');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,cluster,v] = kmeans1(data,k,InitialCentroids)

l = size(data,1); % number of patterns

% initialize centroids
x = InitialCentroids;

% initialize clusters
cluster = zeros(l,1);

% we assign to each pattern the cluster corresponding to the minimum norm
% using the 2 nested loops
for i = 1 : l
    d = inf;
    for j = 1 : k
        if norm(data(i,:)-x(j,:)) < d
            d = norm(data(i,:)-x(j,:));
            cluster(i) = j;
        end
    end
end

% compute the objective function value
vold = 0;
% you sum the minimum square distances
for i = 1 : l
    vold = vold + norm(data(i,:)-x(cluster(i),:))^2 ;
end

while true


    
    % update centroids

    % for each j you consider the elements in the j-th cluster
    % and 

    for j = 1 : k
        ind = find(cluster == j);
        if isempty(ind)==0
            % this is the mean of the first element of each row
            x(j,:) = mean(data(ind,:),1);
        end
    end
    
    % update clusters
    for i = 1 : l
        d = inf;
        for j = 1 : k
            if norm(data(i,:)-x(j,:)) < d
                d = norm(data(i,:)-x(j,:));
                cluster(i) = j;
            end
        end
    end

    % update objective function
    % la metti a valore della nuova somma delle distanze euclidee
    % per come sono assegnati attualmente i punti e i centroidi
    v = 0;
    for i = 1 : l
        v = v + norm(data(i,:)-x(cluster(i),:))^2 ;
    end
    
    % stopping criterion
    % vold is the value of the objective function at the past iteration
    if vold - v < 1e-5
        break
    else
        vold = v;
    end 
end
end
