function [ Bmirn ] = Bmagnmirnv( Z_filament,R_filament,I_filament,r_mirnv,z_mirnv)

Zc=Z_filament;
Ra=R_filament;
I=I_filament;
turns=1; %%%% porque é modelo de filamentos
rpoint=r_mirnv;
zpoint=z_mirnv;
yp=zpoint;
zp=rpoint;
dist=0; %% X=0; plano YZ
xp=dist;
N=1000;   % No of grids in the coil ( X-Y plane)
u0=4*pi*0.001;   % [microWb/(A cm)]
phi=-pi/2:2*pi/(N-1):3*pi/2; % For describing a circle (coil)

Xc=Ra*cos(phi); % X-coordinates of the coil
Yc=Ra*sin(phi); % Y-coordinates of the coil
% Zc(1:25)=Zc;

for i=1:N-1
Rx(i)=dist-0.5*(Xc(i)+Xc(i+1));
Ry(i)=(yp-(0.5*(Yc(i)+Yc(i+1))));
Rz(i)=(zp-(0.5*(Zc+Zc)));
dlx(i)=Xc(i+1)-Xc(i);
dly(i)=Yc(i+1)-Yc(i);
end
Rx(N)=dist-0.5*(Xc(N)+Xc(1));
Ry(N)=(yp-(0.5*(Yc(N)+Yc(1))));
Rz(N)=(zp-(0.5*(Zc+Zc)));
dlx(N)=-Xc(N)+Xc(1);
dly(N)=-Yc(N)+Yc(1);

%%dl x r
for i=1:N
Xcross(i)=dly(i).*Rz(i);
Ycross(i)=-dlx(i).*Rz(i);
Zcross(i)=(dlx(i).*Ry(i))-(dly(i).*Rx(i));
R(i)=sqrt(Rx(i).^2+Ry(i).^2+Rz(i).^2);
end


%dB=m0/4pi (Idl x r)/r^2 
Bx1=(I*u0./(4*pi*(R.^3))).*Xcross;
By1=(I*u0./(4*pi*(R.^3))).*Ycross;
Bz1=(I*u0./(4*pi*(R.^3))).*Zcross;

BX=0;       % Initialize sum magnetic field to be zero first
BY=0;
BZ=0;

for i=1:N   % loop over all current elements along coil    
    BX=BX+Bx1(i);
    BY=BY+By1(i);
    BZ=BZ+Bz1(i);
end
z=yp;
r=zp;
y=xp;
Br=turns*BZ;
Bz=turns*BY;
By=turns*BX;

vector=[Z_filament-z_mirnv,R_filament-r_mirnv];
unit_vec=[vector]./norm(vector);
Bmirn=abs(Br*unit_vec(1)+Bz*unit_vec(2));
Bmirn=sqrt(Br^2+Bz^2);
Bmirn=0.01*Bmirn;%fator de 0.01 pra ter [T] 
end