close all;

fp_coeff_input = fopen('../FGen/LPF_1k_2k_64pt_fp32.fcf');
craw = fscanf(fp_coeff_input,"%f");
c_fp64 = double(craw');
c_fp32 = single(craw');
c_fp16 = half(c_fp32);
fclose(fp_coeff_input);

L = 512;
fs = 10e3;
T = 1/fs;
f = 1e3;
i = [1:1:L];
ff = (0:(fs/L):(fs/2-fs/L));
t = (i*T);
sini = @(i,f)(sin(2*pi*f*(i*T)));
y = sini(i,0.5e3)+sini(i,1e3)+sini(i,1.5e3)+sini(i,2e3)+sini(i,2.5e3)+sini(i,3e3)+sini(i,3.5e3)+sini(i,4e3);
y_fp64 = double(y);
y = single(y);


figure();
subplot(2,1,1);
plot(t,y);
xlabel("Time / s");
subplot(2,1,2);
y_fft = abs(fft(y.*hanning(L)'));
plot(ff,mag2db(y_fft(1:L/2)));
xlabel("Frequency / Hz");

% Doing FIR
yr = [y y(33:512)];   % To ensure L+64 elements accessible
a = zeros(1,L);
pminmax = zeros(2,L);
for i = 1:1:L
    p = yr(i:i+63).*c_fp32;
    pminmax(:,i) = [min(abs(p)) max(abs(p))];
    % a(i) = sum(p);
    for j = 1:1:64
        a(i) = single(a(i) + p(j));
    end
end

yr_ideal = [y_fp64 y_fp64(33:512)];   % To ensure L+64 elements accessible
a_ideal = zeros(1,L);
pminmax_ideal = zeros(2,L);
for i = 1:1:L
    p = yr(i:i+63).*c_fp32;
    pminmax_ideal(:,i) = [min(abs(p)) max(abs(p))];
    a_ideal(i) = sum(p);
end

y_fp16 = half(y);
yr_fp16 = [y_fp16 y_fp16(33:512)];   % To ensure L+64 elements accessible
a_fp16 = zeros(1,L);
pminmax_fp16 = zeros(2,L);
for i = 1:1:L
    p_fp16 = half(yr_fp16(i:i+63).*c_fp16);
    pminmax_fp16(:,i) = [min(abs(p_fp16)) max(abs(p_fp16))];
    for j = 1:1:64
        a_fp16(i) = half(a_fp16(i) + p_fp16(j));
    end
end

a_out_full = readmatrix("output.txt");
a_out = (a_out_full(1:512)');
a_out = [a_out flip(a_out)];
a_out = a_out(1:512);
figure();
subplot(2,1,1);
xlim([0 t(250)]);
hold on;
plot(t,a,'LineWidth',1.5);
plot(t,a_fp16,'LineWidth',1.5);
plot(t+T,a_out,'LineWidth',1.5);
legend('FP32','FP16','FIR Actual');
title('Time Domain');

xlabel("Time / s");
subplot(2,1,2);
hold on;
%a_fft_ideal = abs(fft(a_ideal.*hanning(length(a_ideal))'));
%plot(ff,mag2db(a_fft_ideal(1:length(a_ideal)/2)),'LineWidth',1.5);


a_fft = abs(fft(a.*hanning(length(a_out))'));
plot(ff,mag2db(a_fft(1:length(a)/2)),'LineWidth',1.5);

% Calculate RMSE
sl = 400;
rmse_list=zeros(3,500);
for sl = 1:1:500
    rmse     = sqrt(sum((a(2:sl+1)-a_out (1:sl)).^2)/sl);
    rmse_ref = sqrt(sum((a(1:sl)  -a_fp16(1:sl)).^2)/sl);
    rmse_ref1= sqrt(sum((a(1:sl)  -single(half(a(1:sl)))).^2)/sl);
    rmse_list(:,sl) =[rmse rmse_ref rmse_ref1];
end

a_fft_fp16 = abs(fft(a_fp16.*hanning(length(a_fp16))'));
plot(ff,mag2db(a_fft_fp16(1:length(a_fp16)/2)),'LineWidth',1.5);
xlabel("Frequency / Hz");


k_fft = abs(fft(a_out.*hanning(512)'));
plot(ff,mag2db(k_fft(1:256)),'LineWidth',1.5);
legend('FP32','FP16','FIR Actual');
title('FFT (Hanning Window)');

% Plot RMSE
figure();
hold on;
plot(rmse_list(3,:),'LineWidth',1.5);
plot(rmse_list(2,:),'LineWidth',1.5);
plot(rmse_list(1,:),'LineWidth',1.5);
legend('FP32 (Rounded to FP16)','FP16 Reference','Actual FIR');
% Write FP16 Coeff to Files
%c_fp16_bin = halfprecision(c_fp32);
%y_fp16_bin = halfprecision(y);
%fp_coeff_fp16 = fopen('coeff_fp16_bin.txt','w+');
%fp_dmem_fp16  = fopen('dmem_fp16_bin.txt', 'w+');
%for i=1:1:64
%    fprintf(fp_coeff_fp16,"%04X\n",c_fp16_bin(i));
%end
%for i=1:1:L
%    fprintf(fp_dmem_fp16, "%04X\n",y_fp16_bin(i));
%end
%fclose(fp_coeff_fp16);
%fclose(fp_dmem_fp16);

