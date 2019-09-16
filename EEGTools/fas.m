function W=fas(Rx,estim_A)
%function W=fas(Rx,estim_A)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%																								%
%     			 Calcul d'une matrice de filtrage (FAS s�paration de source)                    %
%																								%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%																								%
% Rx : matrice de covariance des observations													%
% estim_A : matrice de m�lange estim�e par s�paration de source									%
%																								%
% W : matrice de filtrage FAS (separateur : y = W s) obtenue en calculant 						%
%		W(p,:)=( Rx^-1 . estim_A(:,p))* / (estim_A(:,p)' . Rx^-1 . estim_A(:,p))			    %
%       avec p=1..P o� P est le nombre de sources                                               %
%																								%
% Le filtre FAS est optimal pour des sources d�corr�l�es et est d�fini � une matrice diagonale  %
% pr�s, celle que l'on choisi ici permet un meilleur conditionnement.                           %
%                                                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,P]=size(estim_A);
inv_Rx=inv(Rx);        %calcul de la pseudo inverse de Rx
num=inv_Rx*estim_A;
den=diag(estim_A'*inv_Rx*estim_A);
for p=1:P
	W(p,:)=num(:,p)'./den(p);
end
