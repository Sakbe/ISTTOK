%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Plasma current centroid position reconstruction%%%%%%%%
%%%%%% One filament ,3 freedom degrees%%%%%%%%%%
close all
clear all
%%% Load Shot
load('shot_45520.mat');
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

Mirnv_10_fact=1.2823;

time_index=find(time == 115); %%% Select a time moment where there is plasma current! in [ms]

%%%%%%%%%% Find the exprimental values for that time moment

%%%%without external flux correction
Mirnv_flux(:)=data.mirnv_corr(:,time_index);
Mirnv_flux(10)=Mirnv_10_fact*Mirnv_flux(10);

%%%%with external flux correction!!
Mirnv_flux_corr(:)=data.mirnv_corr_flux(:,time_index);
Mirnv_flux_corr(10)=Mirnv_10_fact*Mirnv_flux_corr(10);

%%%%% Let's go from [Wb] to {T]
Mirnv_B_exp=Mirnv_flux/(50*49e-6); %%%% [T]
Mirnv_B_exp_corr=Mirnv_flux_corr/(50*49e-6); %%%% [T]


%%%%%%%%% 1st approximation just one filament in the center with 3 degrees of
%%%%%%% freedom

%%%% Minimization function with and without external flux correction ,
%%%% units are given in [cm] and [A]
fval=fminsearch(@(x) ErrorMirnFunc(Mirnv_B_exp,x(1),x(2),x(3),R_mirn,z_mirn),[0.5,46.5,4000])
fval_corr=fminsearch(@(x) ErrorMirnFunc(Mirnv_B_exp_corr,x(1),x(2),x(3),R_mirn,z_mirn),[0.5,46.5,4000])



%%%%Lets check how close is our minimization values to the experimental
%%%%ones by applaying Biot-Savart with them 
for i=1:12

xx(i)=Bmagnmirnv(fval(1),fval(2),fval(3),R_mirn(i),z_mirn(i));
xx_corr(i)=Bmagnmirnv(fval_corr(1),fval_corr(2),fval_corr(3),R_mirn(i),z_mirn(i));
end



%%%% Compute the Error

RMSE=sqrt(mean((xx(:)-Mirnv_B_exp(:)))^2);
RMSE_corr=sqrt(mean((xx_corr(:)-Mirnv_B_exp_corr(:)))^2);



%%%%%%%%%%Plotting


figure(6)
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*Mirnv_B_exp,'-o')
hold on
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*xx,'-*')
grid on
title('Shot #45410  t=195[ms]  Ip~4.1[kA]')
legend('Experimental Data','Biot-savart  (optimized )')
xlabel('Mirnov #')
ylabel('Optimization [mT]')
axis equal

figure(7)
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*Mirnv_B_exp_corr,'-o')
hold on
plot([1,2,3,4,5,6,7,8,9,10,11,12],1000*xx_corr,'-*')
grid on
title('Shot #45410  t=195[ms]  Ip~4.1[kA] (External flux corrected)')
legend('Experimental Data corrected','Biot-savart  (optimized )')
xlabel('Mirnov #')
ylabel('Optimization [mT]')
axis equal


return
%% 

%%%%%% Plasma, vessel and mirnov coil plot

close all

figure(3)
plot(xvess,yvess,'k','linewidth',2)
hold on
plot(46,0,'.m','MarkerSize',790)
plot(R_mirn,z_mirn,'sk','MarkerSize',17)
plot(R_filaments(1),z_filaments(1),'.b','MarkerSize',20)
for i = 1:12
    text(R_mirn(i),z_mirn(i),num2str(i),'Color','r','FontSize',13)    
end
axis equal
text(57,0,'LFS','FontSize',15)
text(33,0,'HFS','FontSize',15)
ylim([-11,11])
xlabel('R[cm]')
ylabel('Z[cm]')
grid on