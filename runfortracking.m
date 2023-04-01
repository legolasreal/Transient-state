

clear
clc
close all

dtI=0.05; 
maxtime=430; 
frequency=0.03; 
amplitude=18/4*10^4;
average=8/4*10^4; 
q1=inputheatflux(maxtime,frequency,amplitude,average,dtI);

hf=2*10^3;
Rloadin=Load(maxtime,dtI); 


[time0,Vtolout0,Vout0,Iout0,Rin0,Rload0,Ptotout0,Qtotout0,Jhout0,Jcehout0,Ttegh0,Ttegc0,Effsemi0,Effsystem0,Tceh0,Tcuh0,Tslh0,T20,T30,T40,T50,Tslc0,Tcuc0,Tcec0,Tb10,Tb20,Tb30]=trackingwithalgorithm(0,q1,hf,dtI,maxtime,Rloadin);
[time1,Vtolout1,Vout1,Iout1,Rin1,Rload1,Ptotout1,Qtotout1,Jhout1,Jcehout1,Ttegh1,Ttegc1,Effsemi1,Effsystem1,Tceh1,Tcuh1,Tslh1,T21,T31,T41,T51,Tslc1,Tcuc1,Tcec1,Tb11,Tb21,Tb31]=trackingwithalgorithm(1,q1,hf,dtI,maxtime,Rloadin);
[time2,Vtolout2,Vout2,Iout2,Rin2,Rload2,Ptotout2,Qtotout2,Jhout2,Jcehout2,Ttegh2,Ttegc2,Effsemi2,Effsystem2,Tceh2,Tcuh2,Tslh2,T22,T32,T42,T52,Tslc2,Tcuc2,Tcec2,Tb12,Tb22,Tb32]=trackingwithalgorithm(2,q1,hf,dtI,maxtime,Rloadin);
[time3,Vtolout3,Vout3,Iout3,Rin3,Rload3,Ptotout3,Qtotout3,Jhout3,Jcehout3,Ttegh3,Ttegc3,Effsemi3,Effsystem3,Tceh3,Tcuh3,Tslh3,T23,T33,T43,T53,Tslc3,Tcuc3,Tcec3,Tb13,Tb23,Tb33]=trackingwithalgorithm(3,q1,hf,dtI,maxtime,Rloadin);
[time4,Vtolout4,Vout4,Iout4,Rin4,Rload4,Ptotout4,Qtotout4,Jhout4,Jcehout4,Ttegh4,Ttegc4,Effsemi4,Effsystem4,Tceh4,Tcuh4,Tslh4,T24,T34,T44,T54,Tslc4,Tcuc4,Tcec4,Tb14,Tb24,Tb34]=trackingwithalgorithm(4,q1,hf,dtI,maxtime,Rloadin);
[time5,Vtolout5,Vout5,Iout5,Rin5,Rload5,Ptotout5,Qtotout5,Ttegh5,Ttegc5,Effsemi5,Effsystem5,Tceh5,Tcuh5,Tslh5,T25,T35,T45,T55,Tslc5,Tcuc5,Tcec5,Tb15,Tb25,delT5]=trackingwithoutalgorithm(1,q1,hf,dtI,maxtime,Rloadin);
[time6,Vtolout6,Vout6,Iout6,Rin6,Rload6,Ptotout6,Qtotout6,Ttegh6,Ttegc6,Effsemi6,Effsystem6,Tceh6,Tcuh6,Tslh6,T26,T36,T46,T56,Tslc6,Tcuc6,Tcec6,Tb16,Tb26,Tb36]=trackingwithnewT(q1,hf,dtI,maxtime,Rloadin);
[time7,Vtolout7,Vout7,Iout7,Rin7,Rload7,Ptotout7,Qtotout7,Ttegh7,Ttegc7,Effsemi7,Effsystem7,Tceh7,Tcuh7,Tslh7,T27,T37,T47,T57,Tslc7,Tcuc7,Tcec7,Tb17,Tb27,Tb37]=trackingwithpredicT(q1,hf,dtI,maxtime,Rloadin);

Pout0=Vout0.*Iout0;
Pout1=Vout1.*Iout1;
Pout2=Vout2.*Iout2;
Pout3=Vout3.*Iout3;
Pout4=Vout4.*Iout4;
Pout5=Vout5.*Iout5;
Pout6=Vout6.*Iout6;
Pout7=Vout7.*Iout7;

Ave0=mean(Pout0);
Ave1=mean(Pout1);
Ave2=mean(Pout2);
Ave3=mean(Pout3);
Ave4=mean(Pout4);
Ave5=mean(Pout5);
Ave6=mean(Pout6);
Ave7=mean(Pout7);
