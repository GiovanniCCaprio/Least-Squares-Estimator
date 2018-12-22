clear;
clc;

n=1000; %observation
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
for  i=1:n
        h1(2*i,1)=0;
end
    Hk=[h1 h2];

%% Calculo do Rk

    covariancia=2; %covariancia que pode variar gerando o rk
    diagonal_var= covariancia*ones((n*2),1);
    Rk=diag(diagonal_var');

%% calculo do Pk

  Pk=inv(Hk'*inv(Rk)*Hk);
  
  Pk_futuro= Pk-Pk*Hk'*inv(Hk*Pk*Hk'+Rk)*Hk*Pk;

%% criação do x real (100 vezes)
w=1000;
   v1(1)=5*1+32;
   v2(1)=1;
   x_real=[v1(1) ;v2(1)];
   
   Zk = Hk*x_real+Wk;
   % ESTIMADOR (valor 1)
   
   
   x1(1)=x_estimado(1,1);
   x2(1)=x_estimado(2,1);
   
for i=2:w 
   v1(i)=5*i+32;
   v2(i)=i;
   x_real=[v1(i) ;v2(i)];
   
   Zk = Hk*x_real+Wk;
end
%%Wk
Wk=Pk_futuro*Hk'*inv(Rk);
%% x estimado


for i=2:w

   x_estimado= x_estimado+Wk*(Zk-Hk*x_estimado );
   x1(i)=x_estimado(1,1);
   x2(i)=x_estimado(2,1);
   
end

%% geracao de valores
x_real_total=[v1;v2]; %junta todos para plotar
x_estimado_total=[x1; x2];

figure(2)
plot(x_real_total','r')
hold on
plot(x_estimado_total','b')
title('valor real(red) x estimado(blue)')

%% Erro
e= ((x_real_total - x_estimado_total)');
figure (3)
plot(e)
title('Erro Gerado')




























