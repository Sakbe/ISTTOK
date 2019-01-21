close all
clear all

%% Lets estimate plasma as a central filament

%%% Draw the vessel
th = 0:pi/50:2*pi;
xvess = 9 * cos(th)+46;
yvess = 9 * sin(th) ;

%% Lets draw a plasma in the centerr of the chamber
th1 = 0:pi/50:2*pi;
R_pls=46;
z_plsm= 0 ;

%% %% Mirnov positions
ang=-15;
for i=1:12
R_mirn(i)=9.35*cosd(ang)+46;
z_mirn(i)=9.35*sind(ang);
ang=ang-30;
end

%% Measured magnetic field on the center of each mirnov coil due to a wire in the center...
%% of the chamber
turns=1;
dist=0;
I_plasma=4000;
Rp=46;
Zp=0;
for i=1:12
[Br(i),Bz(i),z,r,y,By]=Bmagnpoint(Zp,Rp,I_plasma,turns,R_mirn(i),z_mirn(i));
end
%% Measured field on each mirnov 
for i=1:12
 B_mirnv(i)=10*sqrt(Br(i)^2+Bz(i)^2); %fator de 10 pra ter [mT]
end
B_mirnv_fact=1./(B_mirnv/(max(B_mirnv)));
%% Ploting
figure(1)
plot(xvess,yvess,'k','linewidth',2)
hold on

plot(R_mirn,z_mirn,'sk','MarkerSize',17)
plot(46,0,'.m','MarkerSize',770)
plot(46,0,'.b','MarkerSize',25)
for i = 1:12
    text(R_mirn(i),z_mirn(i),num2str(i),'Color','r','FontSize',13)
    
     text(R_mirn(i)+1,z_mirn(i)+1,strcat(num2str(B_mirnv(i)),'[mT]'),'Color','k','FontSize',10)
end
text(57,0,'LFS','FontSize',15)
text(33,0,'HFS','FontSize',15)
axis equal
ylim([-11,11])
xlabel('R[cm]')
ylabel('Z[cm]')
% xlim([30,65])

return

%% Lets consider a multi-filament model
close all
%%%% Lets estimate plasma as a central filament

%%% Draw the vessel
th = 0:pi/50:2*pi;
xvess = 9 * cos(th)+46;
yvess = 9 * sin(th) ;


%%% Mirnov positions
ang=-15;
for i=1:12
R_mirn(i)=9.35*cosd(ang)+46;
z_mirn(i)=9.35*sind(ang);
ang=ang-30;
end

%%%%%% Lets draw the plasma filaments
th1 = 0:pi/50:2*pi;
R_pls=46;
z_plsm= 0;
R_filaments(1)=46;
z_filaments(1)=0;
degr=0;
R_filaments(1)=46;
    z_filaments(1)=0;
for i=2:7
    R_filaments(i)=(46)+6*cosd(degr);
    z_filaments(i)=6*sind(degr);
    degr=degr+60;
end

turns=1;
dist=0;
I_plasma=1;
for j=1:7
for i=1:12
[Br(j,i),Bz(j,i),z,r,y,By]=Bmagnpoint(z_filaments(j),R_filaments(j),I_plasma,turns,R_mirn(i),z_mirn(i));
end
end
%%% Measured magnetic field on the center of each mirnov coil due to unitary ..
%%% current on each filament
for j=1:7
for i=1:12
 B_mirnv(j,i)=10*sqrt(Br(j,i)^2+Bz(j,i)^2); %fator de 10 pra ter [mT]
end
end
%%%% normalize
% B_mirnv_fact=1./(B_mirnv/(max(max(B_mirnv))));
 B_mirnv_fact=B_mirnv/(mean(mean(B_mirnv)));
 B_mirnv_fact_pseudo=pinv(B_mirnv_fact');
%%%%plots
figure(2)
plot(xvess,yvess,'k','linewidth',2)
hold on
plot(46,0,'.m','MarkerSize',770)

for i=1:7
plot(R_filaments(i),z_filaments(i),'.b','MarkerSize',20)
end

text(57,0,'LFS','FontSize',15)
text(33,0,'HFS','FontSize',15)
plot(R_mirn,z_mirn,'sk','MarkerSize',17)
for i = 1:12
    text(R_mirn(i),z_mirn(i),num2str(i),'Color','r','FontSize',13)    
end
for i=1:7
    text(R_filaments(i),z_filaments(i),strcat(['I_', num2str(i)]),'Color','k','FontSize',13)
end
axis equal
ylim([-11,11])
xlabel('R[cm]')
ylabel('Z[cm]')
grid on