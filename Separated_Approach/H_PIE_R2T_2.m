% import the raw data
rawData = importdata('signal_R2T_2');
%initialization of variables
n = 0;

%process raw data
% if the value is higher than a threshold, set it as 1, otherwise 0
for i = 1 : 3930
    if rawData(i) > 0.33 % 0.33 is the the threshold
        processedData(i) = 1
    else
        processedData(i) = 0
    end
end

%plot(processedData);

%create an aray of counter that can be used to measure the length of continous 1's
for j = 1 : 3930
    if processedData(j) == 0
        ; % if the element is 0, do nothing
    else % when processedData(j) == 1
        if (j ~= 1 && processedData(j-1) == 1)
            counter(n) = counter(n)+1; % this is executed when there is an 1 appearing before this one, at which time counter(n) was initialized
        else
            if (j == 1 && processedData(j) == 1) || (j ~= 1 && processedData(j-1) == 0)
            n = n+1;
            counter(n) = 1;
            end
        end
    end
end

for k = 1 : n
    if counter(k) >= 67 % this is another threshold. if less than this threshold, the encoding is set to be 0, otherwise 1
        encoding(k) = 1
    else
        encoding(k) = 0
    end
end