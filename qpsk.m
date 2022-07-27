clc
clear all;
close all;
N=8;
m=randi([0,1],1,N);
%% Generate Quadratic Carrier Signal
Tb=1; t=0:Tb/100:Tb; fc=5;
c1=sqrt(2/Tb)*cos(2*pi*fc*t);
c2=sqrt(2/Tb)*sin(2*pi*fc*t);
% Plot carrier signals
subplot 421
plot(t,c1);
title('carrier signal 1');
subplot 422
plot(t,c2);
title('carrier signal 2');
subplot 423
stem(m);
title('Bits');
%% Generate Message and Modulated Signals
t1=0;t2=Tb;
for i=1:2:N-1
    t=t1:Tb/100:t2;
    if m(i)==1
        m_s=ones(1,length(t));
    else
        m_s= -1*ones(1,length(t));
    end
    odd_signal(i,:)=m_s.*c1;
    if m(i+1)==1
        m_s=ones(1,length(t));
    else
        m_s= -1*ones(1,length(t));
    end
    even_signal(i,:)=m_s.*c2;
    qpsk1=odd_signal+even_signal;
    
    
    subplot 424
    plot(t,odd_signal(i,:));
    hold on
    title('odd');
    subplot 425
    plot(t,even_signal(i,:));
    hold on
    title('even');
    subplot 426
    plot(t,qpsk1(i,:));
    
    title('QPSK');
    hold on
    t1=t1+(Tb+Tb/100);
    t2=t2+(Tb+Tb/100);
    
end
hold off
%% QPSK Demodulation
t1=0;t2=Tb;
demod=[];
for i=1:2:N-1
    t=t1:Tb/100:t2;
    disp('cycle')
    disp(i)
    x1=trapz(c1.*qpsk1(i,:))
    x2=trapz(c2.*qpsk1(i,:))
    
    if(x1>0 && x2>0)
        demod(i)=1
        demod(i+1)=1
    elseif(x1>0 && x2<0)
        demod(i)=1
        demod(i+1)=0
    elseif(x1<0 && x2<0)
        demod(i)=0
        demod(i+1)=0
    elseif(x1<0 && x2>0)
        demod(i)=0
        demod(i+1)=1
    end
    
        
end
subplot 427
stem(demod);
