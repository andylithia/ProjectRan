close all;
dtconv = @(d) single(d);

c_fp32 = dtconv([ ...
-0.000013127122656442224979400634765625   
-0.000016471984054078347980976104736328125
 0.000018280186850461177527904510498046875
 0.000090801506303250789642333984375      
 0.000118109790491871535778045654296875   
-0.00001928822530317120254039764404296875 
-0.00031051362748257815837860107421875    
-0.0004830732359550893306732177734375     
-0.000156051173689775168895721435546875   
 0.0006979227182455360889434814453125     
 0.00140154059045016765594482421875       
 0.0009203759836964309215545654296875     
-0.001045623910613358020782470703125      
-0.00315489131025969982147216796875       
-0.002993165515363216400146484375         
 0.000676059047691524028778076171875      
 0.0057442630641162395477294921875        
 0.0073128580115735530853271484375        
 0.00176680623553693294525146484375       
-0.008520965464413166046142578125         
-0.014833779074251651763916015625         
-0.008512272499501705169677734375         
 0.0097854137420654296875                 
 0.02652197517454624176025390625          
 0.0234552882611751556396484375           
-0.0059739868156611919403076171875        
-0.0447894819080829620361328125           
-0.0576818175613880157470703125           
-0.01385118067264556884765625             
 0.087243430316448211669921875            
 0.2075435817241668701171875              
 0.289062082767486572265625               
 0.289062082767486572265625               
 0.2075435817241668701171875              
 0.087243430316448211669921875            
-0.01385118067264556884765625             
-0.0576818175613880157470703125           
-0.0447894819080829620361328125           
-0.0059739868156611919403076171875        
 0.0234552882611751556396484375           
 0.02652197517454624176025390625          
 0.0097854137420654296875                 
-0.008512272499501705169677734375         
-0.014833779074251651763916015625         
-0.008520965464413166046142578125         
 0.00176680623553693294525146484375       
 0.0073128580115735530853271484375        
 0.0057442630641162395477294921875        
 0.000676059047691524028778076171875      
-0.002993165515363216400146484375         
-0.00315489131025969982147216796875       
-0.001045623910613358020782470703125      
 0.0009203759836964309215545654296875     
 0.00140154059045016765594482421875       
 0.0006979227182455360889434814453125     
-0.000156051173689775168895721435546875   
-0.0004830732359550893306732177734375     
-0.00031051362748257815837860107421875    
-0.00001928822530317120254039764404296875 
 0.000118109790491871535778045654296875   
 0.000090801506303250789642333984375      
 0.000018280186850461177527904510498046875
-0.000016471984054078347980976104736328125
-0.000013127122656442224979400634765625]');

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

