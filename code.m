function [time,Vtolout,Vout,Iout,Rinout,Rloadout,Ptotout,Qtotout,Jhout,Jcehout,Ttegh,Ttegc,Effsemi,Effsystem,Tceh,Tcuh,Tslh,T2,T3,T4,T5,Tslc,Tcuc,Tcec,Tb1,Tb2,Tb3]=trackingwithalgorithm(Mode,qin,hf,dtI,maxtime,Rloadin)

tceh =293; tcuh =293; tslh =293; tslc =293 ;tcuc =293; tcec =293; tb1=293; tb2=293; tb3=293;  
t1=293 ; t2=293; t3=293 ; t4=293  ; t5=293   ; t6=293   ; 
Ttegh(1)=t1;Ttegc(1)=t6; T2(1)=t2;T3(1)=t3;T4(1)=t4;T5(1)=t5;
Tceh(1)=tceh; Tcuh(1)=tcuh; Tslh(1)=tslh;Tslc(1)=tslc;Tcuc(1)=tcuc;Tcec(1)=tcec;Tb1(1)=tb1;Tb2(1)=tb2;Tb3(1)=tb3;
time(1)=0;
Iout(1)=0;
Vout(1)=0;
dttem = 1e-5; 
N=1; 
Ace=N*20*20*1e-6;
n = 0;
i = 1;
Pout=0   ;       
Jh=0     ;       
Jceh=0   ;       
Qtot=0   ;         
V_heat1 = 0;
V_heat0 = 0;
P_heat1 = 0;
P_heat0 = 0;
I_heat0 = 0;
I_heat1 = 0;
I_heat2 = 0.001;   

fixDetaI=0.0005; 
maxDetaI=0.005;
Imax=0.0579;          
detaI=0;
step=1;

for t=0:dtI:maxtime
    n=n+1;
    
    Qinput=qin(n)*Ace;

    [Vtol,Iout2,Rin,qh,qceh,tceh,tcuh,tslh,t1,t2,t3,t4,t5,t6,tslc,tcuc,tcec,tb1,tb2,tb3,~]=getTVfromH(I_heat2,Qinput,dttem,dtI,tceh,tcuh,tslh,t1,t2,t3,t4,t5,t6,tslc,tcuc,tcec,tb1,tb2,tb3,hf,Rloadin);
    V_heat2= Vtol-I_heat2 * Rin ;
    P_heat2 = I_heat2*V_heat2    ;                    

    Pout = Pout+P_heat2;       
    Jh = Jh + qh*dtI ;                      
    effsemi = P_heat2 / (qh+eps) *100;            
    Jceh = Jceh + qceh*dtI  ;                 
    effsystem = P_heat2 / (Qinput+eps) *100;                  
             
    Qtot=Qtot + Qinput;       
    I_heat0=I_heat1;
    I_heat1=I_heat2;
    V_heat0=V_heat1;
    V_heat1=V_heat2;
    P_heat0=P_heat1;
    P_heat1=P_heat2;
   

    if mod(n,1/dtI)==0  
        i=i+1;
    time(i) = i-1;    
    Ttegh(i)=t1;
    Ttegc(i)=t6;
    Iout(i)=I_heat2;
    Vout(i)=V_heat2;
    Vtolout(i)=Vtol;
    Effsemi(i)=abs(effsemi);
    Effsystem(i)=abs(effsystem);
    Rinout(i)=Rin;
    Rloadout(i)=Rloadin;
    Tceh(i)=tceh;
    Tcuh(i)=tcuh;
    Tslh(i)=tslh;
    T2(i)=t2;
    T3(i)=t3;
    T4(i)=t4;
    T5(i)=t5;
    Tslc(i)=tslc;
    Tcuc(i)=tcuc;
    Tcec(i)=tcec;
    Tb1(i)=tb1;
    Tb2(i)=tb2;
    Tb3(i)=tb3;    
    end 
delP=P_heat1-P_heat0;
delI=I_heat1-I_heat0;

if Mode==0 
    detaI=fixDetaI;
    if delI==0
        delI=0.0001;
    end
    if delP==0
        delP=0.0001;
    end
    detaI=abs(delP/delI)*fixDetaI;
    if detaI>maxDetaI
        detaI=maxDetaI;
    end

elseif Mode==2 
    detaI=fixDetaI;
elseif Mode==3 
    if delI==0
        delI=0.0001;
    end
    if delP==0
        delP=0.0001;
    end
    detaI=abs(delP/delI)*fixDetaI; 
    if detaI>maxDetaI
        detaI=maxDetaI;
    end
elseif Mode==4 
    detaI=0.001;

end

  
if Mode==0 || Mode==1 
    if P_heat1>=P_heat0
         if I_heat1<I_heat0
            I_heat2=I_heat1-detaI;
         else
             I_heat2=I_heat1+detaI;
         end
    else
         if I_heat1<I_heat0
            I_heat2=I_heat1+detaI;
          else
            I_heat2=I_heat1-detaI;
         end
    end    
elseif Mode==2 || Mode==3 
    if abs(I_heat1-I_heat0) == 0
        if V_heat1-V_heat0 == 0
            I_heat2=I_heat1-0.0001;
        elseif V_heat1>V_heat0
                I_heat2=I_heat1+detaI; 
        else 
                I_heat2=I_heat1-detaI;  
        end
    else
         if V_heat1/I_heat1+(V_heat1-V_heat0)/(I_heat1-I_heat0)>=0
            I_heat2=I_heat1+detaI;
         else 
            I_heat2=I_heat1-detaI;                
         end
    end
elseif Mode==4 
     if step<10      
        step=step+1;
            if P_heat1>=P_heat0
                if I_heat1<I_heat0
                    I_heat2=I_heat1-detaI;
                else
                    I_heat2=I_heat1+detaI;
                end
            else
                if I_heat1<I_heat0
                   I_heat2=I_heat1+detaI;
                else
                   I_heat2=I_heat1-detaI;
                end
            end 
     end
     
     if step==10 
        step=1;
        polyfitX=[I_heat0,I_heat1]; 
        polyfitY=[V_heat0,V_heat1];
        p=polyfit(polyfitX,polyfitY,1);
        I_heat2=0.5*(-p(2))/p(1);   
     end
end
if I_heat2>Imax
        I_heat2=Imax;
end
if I_heat2<0
        I_heat2=0.0001;
end

end
Jhout=Jh;
Jcehout=Jceh;
Ptotout=Pout;
Qtotout=Qtot;

end
