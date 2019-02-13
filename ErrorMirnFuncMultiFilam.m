function error=ErrorMirnFuncMultiFilam(Mirnv_B_exp,Z_filament,R_filament,I_filament,...
    I_filament2,I_filament3,I_filament4,I_filament5,I_filament6,I_filament7,R_filaments,z_filaments,r_mirnv,z_mirnv)


for i=1:12
vector(i,[1,2])=[z_filaments(1)-z_mirnv(i),R_filaments(1)-r_mirnv(i)];%Vector from center of chamber to mirnov center
unit_vec(i,[1,2])=[vector(i,[1,2])]./norm(vector(i,[1,2])); %% Unit vector
norm_vec(i,[1,2])=[unit_vec(i,2),-unit_vec(i,1)];%%%  Normal vector, coil direction
end


for i=1:12
    
[Bz(i,1),BR(i,1)]=BmagnmirnvMulti(Z_filament,R_filament,I_filament,r_mirnv(i),z_mirnv(i));
[Bz(i,2),BR(i,2)]=BmagnmirnvMulti(z_filaments(2),R_filaments(2),I_filament2,r_mirnv(i),z_mirnv(i));
[Bz(i,3),BR(i,3)]=  BmagnmirnvMulti(z_filaments(3),R_filaments(3),I_filament3,r_mirnv(i),z_mirnv(i));
[Bz(i,4),BR(i,4)]= BmagnmirnvMulti(z_filaments(4),R_filaments(4),I_filament4,r_mirnv(i),z_mirnv(i));
[Bz(i,5),BR(i,5)]= BmagnmirnvMulti(z_filaments(5),R_filaments(5),I_filament5,r_mirnv(i),z_mirnv(i));
[Bz(i,6),BR(i,6)]=  BmagnmirnvMulti(z_filaments(6),R_filaments(6),I_filament6,r_mirnv(i),z_mirnv(i));
[Bz(i,7),BR(i,7)]=  BmagnmirnvMulti(z_filaments(7),R_filaments(7),I_filament7,r_mirnv(i),z_mirnv(i));
    
end


for i=1:12
Bz_tot(i)=0;
BR_tot(i)=0;
end

for i=1:12
for j=1:7
     BR_tot(i)=BR_tot(i)+BR(i,j);
     Bz_tot(i)=Bz_tot(i)+Bz(i,j);
end
end


for i=1:12
Bmirn(i)=dot([Bz_tot(i),BR_tot(i)],norm_vec(i,[1,2]));
end

Bmirn=0.01*Bmirn;%fator de 0.01 pra ter [T] 


error=sum(abs(Mirnv_B_exp-Bmirn));

end