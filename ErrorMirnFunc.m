function error=ErrorMirnFunc(Mirnv_B_exp,Z_filament,R_filament,I_filament,r_mirnv,z_mirnv)

for i=1:12
Bmirn(i)=Bmagnmirnv(Z_filament,R_filament,I_filament,r_mirnv(i),z_mirnv(i));
end
error=sum(abs(Mirnv_B_exp-Bmirn));

end