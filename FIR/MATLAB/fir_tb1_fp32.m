close all;
dtconv = @(d) single(d);

fp_coeff_input = fopen('../FGen/LPF_1k_2k_64pt_fp32.fcf');
craw = fscanf(fp_coeff_input,"%f");
c_fp32 = single(craw');
c_fp16 = half(c_fp32);

L = 512;
fs = 10e3;
T = 1/fs;
f = 1e3;
i = [1:1:L];
ff = (0:(fs/L):(fs/2-fs/L));
t = (i*T);
sini = @(i,f)(sin(2*pi*f*(i*T)));
y = sini(i,0.5e3)+sini(i,1e3)+sini(i,1.5e3)+sini(i,2e3)+sini(i,2.5e3)+sini(i,3e3)+sini(i,3.5e3)+sini(i,4e3);
y = dtconv(y);

figure();
subplot(2,1,1);
plot(t,y);
xlabel("Time / s");
subplot(2,1,2);
y_fft = abs(fft(y.*hanning(L)'));
plot(ff,mag2db(y_fft(1:L/2)));
xlabel("Frequency / Hz");

% Doing FIR
yr = [y flip(y)];   % To ensure L+64 elements accessible
a = zeros(1,L);
pminmax = zeros(2,L);
for i = 1:1:L
    p = yr(i:i+63).*c_fp32;
    pminmax(:,i) = [min(abs(p)) max(abs(p))];
    a(i) = sum(p);
end

y_fp16 = half(y);
yr_fp16 = [half(y) flip(half(y))];   % To ensure L+64 elements accessible
a_fp16 = zeros(1,L);
pminmax_fp16 = zeros(2,L);
for i = 1:1:L
    p_fp16 = yr_fp16(i:i+63).*c_fp16;
    pminmax(:,i) = [min(abs(p_fp16)) max(abs(p_fp16))];
    a_fp16(i) = sum(p_fp16);
end

figure();
subplot(2,1,1);
hold on;
plot(t,a);
plot(t,a_fp16);
xlabel("Time / s");
subplot(2,1,2);
hold on;
a_fft = abs(fft(a.*hanning(length(a))'));
plot(ff,mag2db(a_fft(1:length(a)/2)));

a_fft_fp16 = abs(fft(a_fp16.*hanning(length(a_fp16))'));
plot(ff,mag2db(a_fft_fp16(1:length(a_fp16)/2)));
xlabel("Frequency / Hz");

% Write FP16 Coeff to Files
c_fp16_bin = halfprecision(c_fp32);
y_fp16_bin = halfprecision(y);
fp_coeff_fp16 = fopen('coeff_fp16_bin.txt','w+');
fp_dmem_fp16  = fopen('dmem_fp16_bin.txt', 'w+');
for i=1:1:64
    fprintf(fp_coeff_fp16,"%04X\n",c_fp16_bin(i));
end
for i=1:1:L
    fprintf(fp_dmem_fp16, "%04X\n",y_fp16_bin(i));
end
fclose(fp_coeff_fp16);
fclose(fp_dmem_fp16);
fclose(fp_coeff_input);

