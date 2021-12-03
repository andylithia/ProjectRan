close all;

fp_coeff_input = fopen('../FGen/LPF_1k_2k_64pt_i16.fcf');
craw = fscanf(fp_coeff_input,"%f");
c_i16 = int16(craw'.*2^15);
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
y = y/max(y);
y = int16(y*2^15);

figure();
subplot(2,1,1);
plot(t,y);
xlabel("Time / s");
subplot(2,1,2);
y_fft = abs(fft(double(y).*hanning(L)'));
plot(ff,mag2db(y_fft(1:L/2)));
xlabel("Frequency / Hz");

% Doing FIR
yr = [y flip(y)];   % To ensure L+64 elements accessible
a = int32(zeros(1,L));
pminmax = zeros(2,L);
for i = 1:1:L
    p = int32(int32(yr(i:i+63)).*int32(c_i16));
    pminmax(:,i) = [min(abs(p)) max(abs(p))];
    a(i) = sum(p);
end


figure();
subplot(2,1,1);
hold on;
plot(t,a);
xlabel("Time / s");
subplot(2,1,2);
hold on;
a_fft = abs(fft(double(a).*hanning(length(a))'));
plot(ff,mag2db(a_fft(1:length(a)/2)));
xlabel("Frequency / Hz");

% Write FP16 Coeff to Files
%c_fp16_bin = halfprecision(c_fp32);
%y_fp16_bin = halfprecision(y);
fp_coeff_i16 = fopen('coeff_i16_bin.txt','w+');
fp_dmem_i16  = fopen('dmem_i16_bin.txt', 'w+');
for i=1:1:64
    t = binaryVectorToHex(dec2bin(c_i16(i),16)-'0','MSBFirst');
    fprintf(fp_coeff_i16,"%s\n",t);
end
for i=1:1:L
    t = binaryVectorToHex(dec2bin(y(i),16)-'0','MSBFirst');
    fprintf(fp_dmem_i16, "%s\n",t);
end
fclose(fp_coeff_i16);
fclose(fp_dmem_i16);

