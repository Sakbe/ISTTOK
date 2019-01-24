%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Plasma current centroid position reconstruction%%%%%%%%
%%%%%% Multifilaments,9 freedom degrees%%%%%%%%%%
close all
clear all
%%% Load Shot
load('shot_45052.mat');
time=1e-3*data.time; %%%% time in ms

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
radius=4; %%% in [cm]
for i=2:7
    R_filaments(i)=(46)+radius*cosd(degr);
    z_filaments(i)=radius*sind(degr);
    degr=degr+60;
end


%%%Experimental mesurements[Wb]
%%%Shot 45052 t=140[ms]
Mirnv_flux=[-2.1877e-5,-1.8424e-5,-1.6136e-5,-1.7539e-5,-1.9190e-5,-2.0694e-5,-1.916e-5,-2.4294e-5,-2.3897e-5,-1.6563e-5,-2.4345e-5,-2.018e-5];
time_index=find(time == 145);
Mirnv_flux(:)=data.mirnv_corr(:,time_index);

Mirnv_B_exp=Mirnv_flux/(50*49e-6); %%%% [T]


%%% 1st approximation just one filament in the center with 3 degrees of
%%% freedom

%%%% Minimization function
fval=fminsearch(@(x) ErrorMirnFunc(Mirnv_B_exp,x(1),x(2),x(3),R_mirn,z_mirn),[0.5,46.5,4000])

%%%%Lets check
for i=1:12
%     Mirnv_B_predic(i)=Bmagnmirnv();
x(i)=Bmagnmirnv(0,46,4000,R_mirn(i),z_mirn(i));

xx(i)=Bmagnmirnv(fval(1),fval(2),fval(3),R_mirn(i),z_mirn(i));

end


%%%%%%%%%%Plotting

figure(4)
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*Mirnv_B_exp,'-o')
hold on
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*x,'-*')
grid on
title('Shot #45052  t=140[ms]  Ip~4[kA]')
legend('Experimental Data','Biot-savart ')
xlabel('Mirnov #')
ylabel('Measured B field [mT]')

figure(5)
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*Mirnv_B_exp,'-o')
hold on
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*xx,'-*')
grid on
title('Shot #45052  t=140[ms]  Ip~4[kA]')
legend('Experimental Data','Biot-savart  (optimized )')
xlabel('Mirnov #')
ylabel('Optimization [mT]')


figure(3)
plot(xvess,yvess,'k','linewidth',2)
hold on
plot(46,0,'.m','MarkerSize',770)
plot(R_mirn,z_mirn,'sk','MarkerSize',17)
for i = 1:12
    text(R_mirn(i),z_mirn(i),num2str(i),'Color','r','FontSize',13)    
end
axis equal
ylim([-11,11])
xlabel('R[cm]')
ylabel('Z[cm]')
grid on