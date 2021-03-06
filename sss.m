clear;
clc;

n=200; %observation
%% cri��o do ruido 
w1= randn(n,1);
w2= randn(n,1);
w_plot=[w1 w2];
plot1=1:1:n;
figure(1)
plot(plot1,w_plot,'*')
title('Erros Aleat�rios gerados')

%cria��o de wk
value=1;
i=1;
%eu s� empilho (w1(1) w2(1) w1(2) w2(2)...w1(200) w2(200)) formando uma
%400x1
  while i<(n*2)
    
    Wk(i,1)= w1(value,1);
    Wk((i+1),1)=w2(value,1);
    i=i+2;
    value=value+1;
    
  end

%% cria��o do Hk
   
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


%% cria��o do x real (100 vezes)

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


%ESTIMADOR RECURSIVO
n=1000;

%% cri��o do ruido 
w1= randn(n,1);
w2= randn(n,1);
w_plot=[w1 w2];
plot1=1:1:n;
figure(1)
plot(plot1,w_plot,'*')
title('Erros Aleat�rios gerados')

%cria��o de wk
value=1;
i=1;
%eu s� empilho (w1(1) w2(1) w1(2) w2(2)...w1(200) w2(200)) formando uma
%400x1
  while i<(n*2)
    
    Wk(i,1)= w1(value,1);
    Wk((i+1),1)=w2(value,1);
    i=i+2;
    value=value+1;
    
  end

%% cria��o do Hk
   
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



P=inv(Hk' * inv(Rk) * Hk);%MATRIZ DE COVARI�NCIA DO ESTIMADOR LS


  Zk = Hk*x_real+Wk;
   % ESTIMADOR 
   x=inv(Hk'*inv(Rk)*Hk)*Hk'*inv(Rk)*Zk
   x=[0,0]
ERRO=[];
for i=1:10
    
   S=Hk * P * Hk' + Rk;%COVARI�NCIA RESIDUAL
   W=P * Hk' * inv(S);%ATUALIZA��O DO GANHO
   
   %MATRIZ DE COVARI�NCIA
  
   Z=Hk*(x_real) + Wk; %CALCULANDO A MATRIZ DE MEDIDAS
   x=x + W*(Z - Hk*x)%ESTIMADOR RECURSIVO
   P=P- (W * S * W');%P(K+1)=CASO RECURSIVO PARA A   
   
   ERRO=[ERRO [((x_real(1,1) - x(1,1))^2  +  (x_real(2,1) - x(2,1))^2  ).^(1/2)]]; 
      
end
figure(3)
plot(ERRO, 'b');
grid on

disp('RESULTADOS PARA O ESTIMADOR RECURSIVO:')
x