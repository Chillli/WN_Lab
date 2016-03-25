% import the raw data
rawData = importdata('signal_T2R_1');

%initialization of variables
n = 0;
p = 1;
m = 1;

%process raw data
% if the value is higher than a threshold, set it as 1, otherwise 0
for i = 1 : 2179
    if rawData(i) > 0.635 % 0.635 is the the threshold
        processedData(i) = 1
    else
        processedData(i) = 0
    end
end

%plot(processedData);

for j = 1 : 2179
    if (j ~= 1 && processedData(j) == processedData(j-1))
        counter(n) = counter(n)+1;
    else
        if (j == 1) || (j ~= 1 && processedData(j) ~= processedData(j-1))
            n = n+1;
            counter(n) = 1;
        end
    end
end


for k = 1 : n
    counter_new(k) = round(counter(k)/8);
end

while m <= n
    if counter_new(m) == 2
        encoding(p) = 1;
        p = p+1;
        m = m+1;
    else
        if (counter_new(m) == 1 && counter_new(m+1) == 1)
            encoding(p) = 0;
            p = p+1;
            m = m+2;
        else
            if (counter_new(m) == 1 && counter_new(m+1) == 3)
                encoding(p) = 0;
                encoding(p+1) = -1;
                p = p+2;
                m = m+2;
            elseif  (counter_new(m) == 3 && counter_new(m+1) == 1)
                encoding(p) = -1;
                encoding(p+1) = 0;
                p = p+2;
                m = m+2;
            end
        end
    end
end