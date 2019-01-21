function [ Br,Bz,z,r,y,By ] = Bmagnpoint( Zc,Ra,I ,turns,rpoint,zpoint)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


yp=zpoint;
zp=rpoint;
dist=0; %% X=0; plano YZ
xp=dist;
N=25;   % No of grids in the coil ( X-Y plane)
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

end
% return
% zp(1:Ny)=-(Ny-1)/2:1:(Ny-1)/2; % Y-coordinates of the plane 
% yp(1:Nz)=20:1:60;% Z-coordinates of the plane 
% xp(1:Ny)=dist;
% 
% Y(1:Ny,1:Nz)=0; % This array is for 1-d to 2-d conversion of coordinates
% Z(1:Ny,1:Nz)=0;
% 
% for i=1:Ny
%     Y(i,:)=yp(i); % all y-coordinates value in 2-d form
% end
% for i=1:Nz
%     Z(:,i)=zp(i);% all z-coordinates value in 2-d form
% end
% 
% %-------------------------------------------------------------------------
% %-variable "a" in for loop is along Y and variable "b" is along Z-axis----
% %-------------------------------------------------------------------------
% 
% 
% for a=1:Ny  
% for b=1:Nz  
%     
% %-------------------------------------------------------------------------    
% % calculate R-vector from the coil(X-Y plane)to Y-Z plane where we are 
% % interested to find the magnetic field and also the dl-vector along the
% % coil where current is flowing
% % (note that R is the position vector pointing from coil (X-Y plane) to
% % the point where we need the magnetic field (in this case Y-Z plane).)
% % dl is the current element vector which will make up the coil------------
% %-------------------------------------------------------------------------
% 
% for i=1:N-1
% Rx(i)=dist-0.5*(Xc(i)+Xc(i+1));
% Ry(i)=(Y(a,b)-(0.5*(Yc(i)+Yc(i+1))));
% Rz(i)=(Z(a,b)-(0.5*(Zc+Zc)));
% dlx(i)=Xc(i+1)-Xc(i);
% dly(i)=Yc(i+1)-Yc(i);
% end
% Rx(N)=dist-0.5*(Xc(N)+Xc(1));
% Ry(N)=(Y(a,b)-(0.5*(Yc(N)+Yc(1))));
% Rz(N)=(Z(a,b)-(0.5*(Zc+Zc)));
% dlx(N)=-Xc(N)+Xc(1);
% dly(N)=-Yc(N)+Yc(1);
% 
% %--------------------------------------------------------------------------
% % for all the elements along coil, calculate dl cross R -------------------
% % dl cross R is the curl of vector dl and R--------------------------------
% % XCross is X-component of the curl of dl and R, similarly I get Y and Z- 
% %--------------------------------------------------------------------------
% %%dl x r
% for i=1:N
% Xcross(i)=dly(i).*Rz(i);
% Ycross(i)=-dlx(i).*Rz(i);
% Zcross(i)=(dlx(i).*Ry(i))-(dly(i).*Rx(i));
% R(i)=sqrt(Rx(i).^2+Ry(i).^2+Rz(i).^2);
% end
% 
% %-------------------------------------------------------------------------
% % this will be the biot savarts law equation------------------------------
% %--------------------------------------------------------------------------
% %dB=m0/4pi (Idl x r)/r^2 
% Bx1=(I*u0./(4*pi*(R.^3))).*Xcross;
% By1=(I*u0./(4*pi*(R.^3))).*Ycross;
% Bz1=(I*u0./(4*pi*(R.^3))).*Zcross;
% %--------------------------------------------------------------------------
% % now we have  magnetic field from all current elements in the form of an
% % array named Bx1,By1,Bz1, now its time to add them up to get total
% % magnetic field 
% %-------------------------------------------------------------------------
% 
% BX(a,b)=0;       % Initialize sum magnetic field to be zero first
% BY(a,b)=0;
% BZ(a,b)=0;
% 
% %--------------------------------------------------------------------------
% % here we add all magnetic field from different current elements which 
% % make up the coil,each point of the mesh , it sums the magnetic field due
% % to each each dl
% %--------------------------------------------------------------------------
% 
% for i=1:N   % loop over all current elements along coil    
%     BX(a,b)=BX(a,b)+Bx1(i);
%     BY(a,b)=BY(a,b)+By1(i);
%     BZ(a,b)=BZ(a,b)+Bz1(i);
% end
% 
% %-------------------------------------------------------------------------
% 
% end
% end
% z=yp;
% r=zp;
% y=xp;
% Br=turns*BZ;
% Bz=turns*BY;
% By=turns*BX;
% end
% 
