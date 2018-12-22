clear;
clc;

n=200; %observation
%% crição do ruido 
w1= randn(n,1);
w2= randn(n,1);
w_plot=[w1 w2];
plot1=1:1:n;
figure(1)
plot(plot1,w_plot,'*')
title('Erros Aleatórios gerados')

%criação de wk
value=1;
i=1;
%eu só empilho (w1(1) w2(1) w1(2) w2(2)...w1(200) w2(200)) formando uma
%400x1
  while i<(n*2)
    
    Wk(i,1)= w1(value,1);
    Wk((i+1),1)=w2(value,1);
    i=i+2;
    value=value+1;
    
  end

%% criação do Hk
   
    h2= ones(2*n,1);
    h1= ones(2*n,1);
for  i=1:200
        h1(2*i,1)=0;
end
    Hk=[h1 h2];

%% Calculo do Rk

    covariancia=2; %covariancia que pode variar gerando o rk
    diagonal_var= covariancia*ones((n*2),1);
    Rk=diag(diagonal_var');


%% criação do x real (100 vezes)

   v1=3*rand;
   v2=4*rand;
   x_real=[v1 ;v2]
   
   Zk = Hk*x_real+Wk;
   % ESTIMADOR 
   x_estimado=inv(Hk'*inv(Rk)*Hk)*Hk'*inv(Rk)*Zk
   
erro=x_real-x_estimado


figure(2)
plot(x_real,'*')
hold on
plot(x_estimado,'*')
title('valor real x estimado')   

