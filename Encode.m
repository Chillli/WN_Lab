%The result of encoding is stored in
%'encodingRT1','encodingTR1','encodingRT2','encodingTR2' arrays, which
%represents the first reader to tag data, the first tag to reader data, the
%second reader to tag data and the second tag to reader data respectively.

clear
% import the raw data
rawData = importdata('signal');

%initialization of variables
n = 1;

%process raw data
% if the value is higher than a threshold, set it as 1, otherwise 0
for i = 1 : size(rawData)
    if rawData(i) > 0.62 % 0.62 is the the threshold, data higher than it will be regarded as 1
        processedData(i) = 1;
    else if rawData(i) > 0.33 % data between 0.33 and 0.62 will be regarded as 0.5
        processedData(i) = 0.5;
        else
            processedData(i) = 0;
        end
    end
end

%plot(processedData);

%create an aray of counter that can be used to measure the length of continous 1's
% and in the backscatter segments, the length of continous 0.5 values will
% also be measured
sizeData = size(processedData);
counter5 = zeros(1,202);
counter1 = zeros(1,202);
for i = 1:sizeData(2)-1
    if (processedData(i) ~= 1) && (processedData (i+1) == 1)
        n = n + 1;
        counter1(n) = 1;
        counter5(n) = 0;
    else if (processedData(i) == 1) && (processedData(i+1) == 1 )
            counter1(n) = counter1(n) + 1;
        else if  (processedData(i+1) == 0.5)
                counter5(n) = counter5(n) + 1;
            end
        end
    end
end

m = 1;

% encoding of the first segment of reader to tag data
for k = 6 : 23
    if counter1(k) >= 30 % this is another threshold. if less than this threshold, the encoding is set to be 0, otherwise 1
        encodingRT1(m) = 1;
    else
        encodingRT1(m) = 0;
    end
    m = m + 1;
end

% encoding of the first segment of tag to reader data
x = 1;
for k = 24 : 139
    if counter1(k) < 12
        encodingTR1(x) = 0;
        x = x + 1;
    else if (counter1(k) >= 12) && (counter1(k) < 20)
            encodingTR1(x) = 1;
            x = x + 1;
        else if (counter1(k) < 27)
            encodingTR1(x) = 0;
            x = x + 1;
            encodingTR1(x) = -1; % 2 represents v
            x = x + 1;
            end
        end
    end

    if (counter5(k) >= 12) && (counter5(k) < 20)
        encodingTR1(x) = 1;
        x = x + 1;
    else if (counter5(k) >= 20) && (counter5(k) < 27)
            encodingTR1(x) = -1;
            x = x + 1;
        end
    end
    
end

% encoding of the second segment of reader to tag data
m = 1;
for k = 143 : 182
    if counter1(k) >= 30 
        encodingRT2(m) = 1;
    else
        encodingRT2(m) = 0;
    end
    m = m + 1;
end

% encoding of the second segment of tag to reader data
x = 1;
for k = 183 : 203
    if counter1(k) < 12
        encodingTR2(x) = 0;
        x = x + 1;
    else if (counter1(k) >= 12) && (counter1(k) < 20) 
            encodingTR2(x) = 1;
            x = x + 1;
        else if (counter1(k) < 27)
            encodingTR2(x) = 0;
            x = x + 1;
            encodingTR2(x) = -1; % 2 represents v
            x = x + 1;
            end
        end
    end

    if (counter5(k) >= 12) && (counter5(k) < 20) 
        encodingTR2(x) = 1;
        x = x + 1;
    else if (counter5(k) >= 20) && (counter5(k) < 27)
            encodingTR2(x) = -1;
            x = x + 1;
        end
    end
end

disp('The first signal from Reader to Tag is:');

dataSize = size(encodingRT1);
for i = 1:dataSize(2)
fprintf( num2str(encodingRT1(i)) );
end

dataSize = size(encodingTR1);
disp(' ');
disp('The first signal from Tag to Reader is:');
for i = 1:dataSize(2)
    if encodingTR1(i) ~= -1
fprintf( num2str(encodingTR1(i)) )
    else
        fprintf('v');
    end
end
disp(' ');
disp('The second signal from Reader to Tag is:');
dataSize = size(encodingRT2);
for i = 1:dataSize(2)
fprintf( num2str(encodingRT2(i)) );
end
disp(' ');
disp('The second signal from Tag to Reader is:');
dataSize = size(encodingTR2);
for i = 1:dataSize(2)
    if encodingTR2(i) ~= -1
fprintf( num2str(encodingTR2(i)) )
    else
        fprintf('v');
    end
end
disp(' ');
