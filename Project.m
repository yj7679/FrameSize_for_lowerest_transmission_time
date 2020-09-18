syms t n real
Total_Times=[]


%802.11a
L = 1000 % The size of frame for a transmission is 1kB = 1024 * 8 
N = 100 
R = 6*1024*1024 * 8 % 6Mbps in bpsk
A = 112 % ACK size = 14 Bytes
P = 0.3 % Error rate
S = 0.000016 %802.11a SIFS


for X = 273:1:300
disp(X)
Q = symsum(nchoosek(X,n)*P^n*(1-P)^(X-n), n, 0, N) 
fully_fragment_count = floor ((L-272)/(X-272)) 
EofCount = symsum(t*((1-Q)^t) * Q, t, 0, inf) 
One_transmission_time = 2*S +X/R+A/R 
Last_transmission_time = 2*S + A/R + mod((L-272),(X-272))/R 
T = One_transmission_time * EofCount 
Total_Time = (fully_fragment_count * T + Last_transmission_time *EofCount - S) %Total transmission time
Total_Times = [Total_Times, Total_Time]

end
Total_Times= double(Total_Times)
[M,I] = min(Total_Times)
plot(Total_Times)
