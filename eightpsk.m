clc
clear all;
close all;
N=16;
m=randi([0,1],1,N);
%% Generate Eight Carrier Signal
Tb=1; t=0:Tb/100:Tb; fc=5;
p=pi/4;
c1=sqrt(2/Tb)*sin(2*pi*fc*t);
c2=sqrt(2/Tb)*sin(2*pi*fc*t+p);
c3=sqrt(2/Tb)*sin(2*pi*fc*t+2*p);
c4=sqrt(2/Tb)*sin(2*pi*fc*t+3*p);
% Plot carrier signals
subplot 431
plot(t,c1);
title('carrier signal 1');
subplot 432
plot(t,c2);
title('carrier signal 2');
subplot 433
plot(t,c3);
title('carrier signal 3');
subplot 434
plot(t,c4);
title('carrier signal 4');
subplot 435
stem(m);
title('Bits');
%% Generate Message and Modulated Signals
t1=0;t2=Tb;
for i=1:4:N-1
    t=t1:Tb/100:t2;
    if m(i)==1
        m_s=ones(1,length(t));
    else
        m_s= -1*ones(1,length(t));
    end
    quarter1(i,:)=m_s.*c1;
    if m(i+1)==1
        m_s=ones(1,length(t));
    else
        m_s= -1*ones(1,length(t));
    end
    quarter2(i,:)=m_s.*c2;
    if m(i+2)==1
        m_s=ones(1,length(t));
    else
        m_s= -1*ones(1,length(t));
    end
    quarter3(i,:)=m_s.*c3;
    if m(i+3)==1
        m_s=ones(1,length(t));
    else
        m_s= -1*ones(1,length(t));
    end
    quarter4(i,:)=m_s.*c4;
    
    epsk=quarter1+quarter2+quarter3+quarter4;
    
    
    subplot 436
    plot(t,quarter1(i,:));
    hold on
    title('1st quarter');
    subplot 437
    plot(t,quarter2(i,:));
    hold on
    title('2nd quarter');
    subplot 438
    plot(t,quarter3(i,:));
    hold on
    title('3rd quarter');
    subplot 439
    plot(t,quarter4(i,:));
    hold on
    title('4th quarter');
    subplot(4,3,10);
    plot(t,epsk(i,:));
    
    title('8PSK');
    hold on
    t1=t1+(Tb+Tb/100);
    t2=t2+(Tb+Tb/100);
    
end
hold off
%% 8PSK Demodulation
t1=0;t2=Tb;
demod=[];
for i=1:4:N-3
    t=t1:Tb/100:t2;
    disp('cycle')
    disp(i)
    x1=sum(smooth(c1.*epsk(i,:)))
    x2=sum(smooth(c2.*epsk(i,:)))
    x3=sum(smooth(c3.*epsk(i,:)))
    x4=sum(smooth(c4.*epsk(i,:)))
    
    if(x1>0 && x2>0 && x3>0 && x4>0)
        demod(i)=1
        demod(i+1)=1
        demod(i+2)=1
        demod(i+3)=1
    elseif(x1>0 && x2>0 && x3>0 && x4<0)
        demod(i)=1
        demod(i+1)=1
        demod(i+2)=1
        demod(i+3)=0
    elseif(x1>0 && x2>0 && x3<0 && x4>0)
        demod(i)=1
        demod(i+1)=1
        demod(i+2)=0
        demod(i+3)=1
    elseif(x1>0 && x2>0 && x3<0 && x4<0)
        demod(i)=1
        demod(i+1)=1
        demod(i+2)=0
        demod(i+3)=0
    elseif(x1>0 && x2<0 && x3>0 && x4>0)
        demod(i)=1
        demod(i+1)=0
        demod(i+2)=1
        demod(i+3)=1
    elseif(x1>0 && x2<0 && x3>0 && x4<0)
        demod(i)=1
        demod(i+1)=0
        demod(i+2)=1
        demod(i+3)=0
    elseif(x1>0 && x2<0 && x3<0 && x4>0)
        demod(i)=1
        demod(i+1)=0
        demod(i+2)=0
        demod(i+3)=1
    elseif(x1>0 && x2<0 && x3<0 && x4<0)
        demod(i)=1
        demod(i+1)=0
        demod(i+2)=0
        demod(i+3)=0
    elseif(x1<0 && x2>0 && x3>0 && x4>0)
        demod(i)=0
        demod(i+1)=1
        demod(i+2)=1
        demod(i+3)=1
    elseif(x1<0 && x2>0 && x3>0 && x4<0)
        demod(i)=0
        demod(i+1)=1
        demod(i+2)=1
        demod(i+3)=0       
    elseif(x1<0 && x2>0 && x3<0 && x4>0)
        demod(i)=0
        demod(i+1)=1
        demod(i+2)=0
        demod(i+3)=1
    elseif(x1<0 && x2>0 && x3<0 && x4<0)
        demod(i)=0
        demod(i+1)=1
        demod(i+2)=0
        demod(i+3)=0
    elseif(x1<0 && x2<0 && x3>0 && x4>0)
        demod(i)=0
        demod(i+1)=0
        demod(i+2)=1
        demod(i+3)=1
    elseif(x1<0 && x2<0 && x3>0 && x4<0)
        demod(i)=0
        demod(i+1)=0
        demod(i+2)=1
        demod(i+3)=0
    elseif(x1<0 && x2<0 && x3<0 && x4>0)
        demod(i)=0
        demod(i+1)=0
        demod(i+2)=0
        demod(i+3)=1     
    elseif(x1<0 && x2<0 && x3<0 && x4<0)
        demod(i)=0
        demod(i+1)=0
        demod(i+2)=0
        demod(i+3)=0        
    end
    
        
end
subplot(4,3,11)
stem(demod);