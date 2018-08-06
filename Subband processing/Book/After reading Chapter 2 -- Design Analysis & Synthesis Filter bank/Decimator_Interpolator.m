clear; clc;

%% parameter setting
D = 2;      % decimation factor
I = 2;      % interpolation factor
L = 17;     % filter length
h_LP = fir1(L-1,1/2);

%% input signal
fs = 1000; freq = 50; N = 100;
n = 0:N-1;
x = sin(2*pi*n*(freq/fs));

%% decimation and interpolation
x_D = x(1:D:end);       % decimation
x_I = zeros(1,length(x));
x_I(1:I:end) = x_D;     % interpolation
y = filter(h_LP,1,x_I); % remove unwanted high-frequency components resulting from zero-insertion
                        % reconstruct the original signal

%% plot
figure;
subplot(4,1,1); stem(0:20, x(1:21));
xlabel('Time index, n');
subplot(4,1,2); stem(0:10, x_D(1:11));
xlabel('Time index, k');
subplot(4,1,3); stem(0:20, x_I(1:21));
xlabel('Time index, n');
subplot(4,1,4); stem(0:20, y(1:21));
xlabel('Time index, n');