%-------------------------------------------------------------------------------
% get_analytic_signal: analytic signal as per [1]
%
% Syntax: [z,N2,N,Nh]=get_analytic_signal(z)
%
% INPUT:
%      s = real-valued signal
%
% OUTPUT:
%      z = complex-valued analytic signal
%
% EXAMPLE:
%      N=64;  f=0.1; N2=2*N;
%      s=cos( 2*pi*f.*(0:N-1));     
%      z=get_analytic_signal(s);
%      plot(1:N2,real(z),1:N2,imag(z));
%      legend('real','imaginary');
%     
%
% [1] J. M. O' Toole, M. Mesbah, and B. Boashash, "A New Discrete Analytic Signal for
%     Reducing Aliasing in the Discrete Wigner-Ville Distribution", IEEE Trans.  on Signal
%     Processing, vol. 56, no. 11, pp. 5427-5434, Nov. 2008.


% John M. O' Toole, University College Cork
% Started: 14-04-2014
%
% last update: Time-stamp: <2014-04-14 14:18:22 (otoolej)>
%-------------------------------------------------------------------------------
function [z,N2,N,Nh]=get_analytic_signal(z)
if(isreal(z)) 
  z=get_analytic(z); 
end
N2=length(z); N=N2/2; Nh=ceil(N/2);

if(N~=fix(N))
  error('Analytic signal must be length 2N.');
end



function gen_analytic(s1)
%---------------------------------------------------------------------
% generate the analytic signal (with zero-padding in the time-direction)
%---------------------------------------------------------------------
s1=real(s1);
N=length(s1); N2=2*N;

% 1. zero-pad N-point signal to 2N
s1=[s1(:); zeros(N,1)];
S1=fft(s1);

% 2. Get analytic signal of 2N-point signal
H=zeros(N2,1); 
H([1 N+1])=1;
H(2:N)=2;
z_cb=ifft(S1.*H);


% 3. Force the second half of the time-domain signal to zero.
z=[z_cb(1:N); zeros(N,1)];

