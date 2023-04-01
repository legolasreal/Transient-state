%% use voltage to get current based on the characteristic of TEG
function I=TEG(V,TH,TC)
N=199;
A=40*40*10^(-6);
l=1*10^(-3);
TH=TH+273.15; % hot side temperature of TEG (¡æ to K)
TC=TC+273.15; % cold side temperature of TEG (¡æ to K)
Tm=(TH+TC)*0.5;
apan=(44448.0+1861.2*Tm-1.981*Tm^2)*10^(-9); 
p1p2=(10224.0+326.8*Tm+1.2558*Tm^2)*10^(-10); 
R=p1p2*N*l/A;    % internal resistance of TEG
a=apan*N;
% RL=V*R./(a*(TH-TC)-V);
% I=a*(TH-TC)./(R+RL);
I=(a*(TH-TC)-V)/R/1000;
% I=a*(TH-TC)/(2*R);
