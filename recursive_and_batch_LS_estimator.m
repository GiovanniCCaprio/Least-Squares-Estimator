%Estimador de mínimos quadrados lotes e recursivo

clear all;
close all;
clc;


Z=[];%OBSERVAÇÕES
w=[];%RUÍDO
h=[];%MATRIZES
N=200;%N° DE OBSERVAÇÕES
R=[1 0; 0 1];%MATRIZ DE COVARIÂNCIA DO RUÍDO
x_real = [3;4;5];%X1 E X2 REAL

%ESTIMADOR EM LOTES
H=[1 1 0; 0 1 0; 0 0 0];

for i=1:(N) 
   w=[w; [(randn); (randn); (randn)]];%EMPILHANDO AS OBSERVAÇÕES
   
end

for i=1:N
    h=[h; H];%EMPILHANDO A MATRIZ FATOR DE OBSERVAÇÃO(AQUI CONSTANTE)
end

disp('VALOR REAL DOS PARÂMETROS:')
x_real
Z=h*(x_real) + w; %CALCULANDO A MATRIZ DE MEDIDAS

disp('RESULTADOS PARA O ESTIMADOR EM LOTE:')
x=h\Z %PARÂMETROS ESTIMADOS PELO ESTIMADOR EM LOTES



%ESTIMADOR RECURSIVO
N=100;
COV = 1;
H=[1 1; 0 1];%CONSTANTE
ERRO=[];
ERRO2=[];
Z=[];%OBSERVAÇÕES
R_k = COV * ones((N*2),1);%GERA UM VETOR 1x1000 DE VALORES COV*1
R=diag(R_k);%GERA UMA MATRIZ DIAGONAL 1000X1000 COM DIAGONAL R_K
x_real = [3;4];
x_k=[x(1,1) ; x(2,1)];

w=[];
for i=1:(N) 
   w=[w; [(randn); (randn)]];%EMPILHANDO AS OBSERVAÇÕES
   
end

h=[];
for i=1:N
    h=[h; H];%EMPILHANDO A MATRIZ FATOR DE OBSERVAÇÃO(AQUI CONSTANTE)
end

P=inv(h' * inv(R) * h)%MATRIZ DE COVARIÂNCIA DO ESTIMADOR LS


Z=h*x_real + w;%CRIANDO AS MEDIDAS INICIAIS
x=[0;0];
for i=1:20
    
   S=h * P * h' + R;%COVARIÂNCIA RESIDUAL
   W=P * h' * inv(S);%ATUALIZAÇÃO DO GANHO
   P=P - (W * S * W');%P(K+1)=CASO RECURSIVO PARA A 
   %MATRIZ DE COVARIÂNCIA
  
   Z=h*(x_real) + w; %CALCULANDO A MATRIZ DE MEDIDAS
   x=x + W*(Z - h*x)%ESTIMADOR RECURSIVO
     
   
   ERRO=[ERRO [((x_real(1,1) - x(1,1)).^2  +  (x_real(2,1) - x(2,1)).^2  ).^(1/2)]]; 
    
    
end

plot(ERRO, 'b');



disp('RESULTADOS PARA O ESTIMADOR RECURSIVO:')
x