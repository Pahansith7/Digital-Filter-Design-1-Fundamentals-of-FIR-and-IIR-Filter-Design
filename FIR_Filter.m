
%sampling frequency 

fsampling = 3200/(2*pi);

% Filter specifications

bandedges = [200/(2*pi) 500/(2*pi) 1000/(2*pi) 1200/(2*pi)];
magnitudes = [0 1 0];
deviations = [10^(-54/20) 10^(0.16/20) 10^(-54/20)];

%obtaining the FIR filter related to the given specifications

[n,Wn,beta,filter_type] = kaiserord(bandedges,magnitudes,deviations,fsampling);
n = n + rem(n,2);
hn = fir1(n,Wn,filter_type,kaiser(n+1,beta),'noscale');

%plot impulse response

figure('name','Impulse Response of the FIR Filter');
impz(hn,1);
grid on;

% Magnitude response in between [-pi,pi]
figure('name','Magnitude response of the FIR filter');
[H,f] = freqz(hn,1);
plot(f/pi,20*log10(abs(H)),'b');
hold on;
plot(-f/pi,20*log10(abs(H)),'b');
xlabel("$frequency \ *\pi  \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude  (db)$","Interpreter","Latex");

% Magnitude response in between [-pi,pi]
figure('name','Magnitude response of the FIR filter');
[H,f] = freqz(hn,1);
plot(f/pi,abs(H),'b')
hold on
plot(-f/pi,abs(H),'b')
xlabel("$frequency \ *\pi  \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude$","Interpreter","Latex");

% Magnitude response in between [Wp1,Wp2]
figure('name','Magnitude response of the FIR filter for [Wp1,Wp2]');
plot(f/pi, 20*log10(abs(H)),'b')
xlim([(5/16) (10/16)])
xlabel("$frequency \ *\pi \ \omega \ rad/sample$","Interpreter","Latex");
ylabel("$Magnitude  (db)$","Interpreter","Latex");
grid on;


