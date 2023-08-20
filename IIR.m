%Sampling interval
Tsm = (2*pi)/3200;

%Spceification of the Analog FIlter
Wp = [abs((2/Tsm)*tan((5*pi)/32)) abs((2/Tsm)*tan((10*pi)/32))];
Ws = [abs((2/Tsm)*tan(pi/16)) abs((2/Tsm)*tan((12*pi)/32))];
Rp = 0.16;
Rs = 54;


% obtain the analog filter according to the above specification
[n,W] = cheb1ord(Wp,Ws,Rp,Rs,'s');

%obtaining the transfer function of the analog filter
[b,a] = cheby1(n,Rp,W,'s');


%obtaining the transfer function of the digital filter using the bilinear
%transformation
[zd,zp]=bilinear(b,a,1/Tsm);

[H,f]= freqs(b,a);
[A,w] = freqz(zd,zp);



% Magnitude response of analog filter
figure('name','Magnitude response of the analog filter');
plot(f,20*log10(abs(H)),'b');
hold on;
plot(-f,20*log10(abs(H)),'b');
xlabel("$frequency \ *\pi  \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude  (db)$","Interpreter","Latex");



% Magnitude response of Analog filter
figure('name','Magnitude response of the analog filter');
plot(f,abs(H),'b')
hold on
plot(-f,abs(H),'b')
xlabel("$frequency \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude$","Interpreter","Latex");



% Magnitude response in between [-pi,pi]
figure('name','Magnitude response of the IIR filter');
plot(w/pi,20*log10(abs(A)),'b');
hold on;
plot(-w/pi,20*log10(abs(A)),'b');
xlabel("$frequency \ *\pi  \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude  (db)$","Interpreter","Latex");

% Magnitude response in between [-pi,pi]
figure('name','Magnitude response of the IIR filter');
plot(w/pi,abs(A),'b')
hold on
plot(-w/pi,abs(A),'b')
xlabel("$frequency \ *\pi  \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude$","Interpreter","Latex");

% Magnitude response in between [Wp1,Wp2]
figure('name','Magnitude response of the IIR filter for [Wp1,Wp2]');
plot(w/pi, 20*log10(abs(A)),'b')
xlim([(5/16) (10/16)])
xlabel("$frequency \ *\pi \ \omega \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude  (db)$","Interpreter","Latex");
grid on;

fvtool(zd,zp);