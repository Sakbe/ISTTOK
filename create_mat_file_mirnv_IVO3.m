clear all
% pkg load optim
shotnr1=43666;
client = StartSdas()

mirnv1='MARTE_NODE_IVO3.DataCollection.Channel_129'; 
mirnv2='MARTE_NODE_IVO3.DataCollection.Channel_130';
mirnv3='MARTE_NODE_IVO3.DataCollection.Channel_131';
mirnv4='MARTE_NODE_IVO3.DataCollection.Channel_132';
mirnv5='MARTE_NODE_IVO3.DataCollection.Channel_133'; 
mirnv6='MARTE_NODE_IVO3.DataCollection.Channel_134';
mirnv7='MARTE_NODE_IVO3.DataCollection.Channel_135';
mirnv8='MARTE_NODE_IVO3.DataCollection.Channel_136'; 
mirnv9='MARTE_NODE_IVO3.DataCollection.Channel_137';
mirnv10='MARTE_NODE_IVO3.DataCollection.Channel_138';
mirnv11='MARTE_NODE_IVO3.DataCollection.Channel_139';
mirnv12='MARTE_NODE_IVO3.DataCollection.Channel_140';

mirnv1_raw='MARTE_NODE_IVO3.DataCollection.Channel_145'; 
mirnv2_raw='MARTE_NODE_IVO3.DataCollection.Channel_146';
mirnv3_raw='MARTE_NODE_IVO3.DataCollection.Channel_147';
mirnv4_raw='MARTE_NODE_IVO3.DataCollection.Channel_148';
mirnv5_raw='MARTE_NODE_IVO3.DataCollection.Channel_149'; 
mirnv6_raw='MARTE_NODE_IVO3.DataCollection.Channel_150';
mirnv7_raw='MARTE_NODE_IVO3.DataCollection.Channel_151';
mirnv8_raw='MARTE_NODE_IVO3.DataCollection.Channel_152'; 
mirnv9_raw='MARTE_NODE_IVO3.DataCollection.Channel_153';
mirnv10_raw='MARTE_NODE_IVO3.DataCollection.Channel_154';
mirnv11_raw='MARTE_NODE_IVO3.DataCollection.Channel_155';
mirnv12_raw='MARTE_NODE_IVO3.DataCollection.Channel_156';

mirnv1_corr='MARTE_NODE_IVO3.DataCollection.Channel_166'; 
mirnv2_corr='MARTE_NODE_IVO3.DataCollection.Channel_167';
mirnv3_corr='MARTE_NODE_IVO3.DataCollection.Channel_168';
mirnv4_corr='MARTE_NODE_IVO3.DataCollection.Channel_169';
mirnv5_corr='MARTE_NODE_IVO3.DataCollection.Channel_170'; 
mirnv6_corr='MARTE_NODE_IVO3.DataCollection.Channel_171';
mirnv7_corr='MARTE_NODE_IVO3.DataCollection.Channel_172';
mirnv8_corr='MARTE_NODE_IVO3.DataCollection.Channel_173'; 
mirnv9_corr='MARTE_NODE_IVO3.DataCollection.Channel_174';
mirnv10_corr='MARTE_NODE_IVO3.DataCollection.Channel_175';
mirnv11_corr='MARTE_NODE_IVO3.DataCollection.Channel_176';
mirnv12_corr='MARTE_NODE_IVO3.DataCollection.Channel_177';

prim='MARTE_NODE_IVO3.DataCollection.Channel_093';
hor='MARTE_NODE_IVO3.DataCollection.Channel_091';
vert='MARTE_NODE_IVO3.DataCollection.Channel_092';

Ip_rog='MARTE_NODE_IVO3.DataCollection.Channel_088';
chopper='MARTE_NODE_IVO3.DataCollection.Channel_141';


[mirnv(1,:),mirnv1_t]=LoadSdasData(client, mirnv1, shotnr1);
[mirnv(2,:),mirnv2_t]=LoadSdasData(client, mirnv2, shotnr1);
[mirnv(3,:),mirnv3_t]=LoadSdasData(client, mirnv3, shotnr1);
[mirnv(4,:),mirnv4_t]=LoadSdasData(client, mirnv4, shotnr1);
[mirnv(5,:),mirnv5_t]=LoadSdasData(client, mirnv5, shotnr1);
[mirnv(6,:),mirnv6_t]=LoadSdasData(client, mirnv6, shotnr1);
[mirnv(7,:),mirnv7_t]=LoadSdasData(client, mirnv7, shotnr1);
[mirnv(8,:),mirnv8_t]=LoadSdasData(client, mirnv8, shotnr1);
[mirnv(9,:),mirnv9_t]=LoadSdasData(client, mirnv9, shotnr1);
[mirnv(10,:),mirnv10_t]=LoadSdasData(client, mirnv10, shotnr1);
[mirnv(11,:),mirnv11_t]=LoadSdasData(client, mirnv11, shotnr1);
[mirnv(12,:),mirnv12_t]=LoadSdasData(client, mirnv12, shotnr1);


[mirnv_raw(1,:),mirnv1_raw_t]=LoadSdasData(client, mirnv1_raw, shotnr1);
[mirnv_raw(2,:),mirnv2_raw_t]=LoadSdasData(client, mirnv2_raw, shotnr1);
[mirnv_raw(3,:),mirnv3_raw_t]=LoadSdasData(client, mirnv3_raw, shotnr1);
[mirnv_raw(4,:),mirnv4_raw_t]=LoadSdasData(client, mirnv4_raw, shotnr1);
[mirnv_raw(5,:),mirnv5_raw_t]=LoadSdasData(client, mirnv5_raw, shotnr1);
[mirnv_raw(6,:),mirnv6_raw_t]=LoadSdasData(client, mirnv6_raw, shotnr1);
[mirnv_raw(7,:),mirnv7_raw_t]=LoadSdasData(client, mirnv7_raw, shotnr1);
[mirnv_raw(8,:),mirnv8_raw_t]=LoadSdasData(client, mirnv8_raw, shotnr1);
[mirnv_raw(9,:),mirnv9_raw_t]=LoadSdasData(client, mirnv9_raw, shotnr1);
[mirnv_raw(10,:),mirnv10_raw_t]=LoadSdasData(client, mirnv10_raw, shotnr1);
[mirnv_raw(11,:),mirnv11_raw_t]=LoadSdasData(client, mirnv11_raw, shotnr1);
[mirnv_raw(12,:),mirnv12_raw_t]=LoadSdasData(client, mirnv12_raw, shotnr1);
% 
[mirnv_corr(1,:),mirnv1_corr_t]=LoadSdasData(client, mirnv1_corr, shotnr1);
[mirnv_corr(2,:),mirnv2_corr_t]=LoadSdasData(client, mirnv2_corr, shotnr1);
[mirnv_corr(3,:),mirnv3_corr_t]=LoadSdasData(client, mirnv3_corr, shotnr1);
[mirnv_corr(4,:),mirnv4_corr_t]=LoadSdasData(client, mirnv4_corr, shotnr1);
[mirnv_corr(5,:),mirnv5_corr_t]=LoadSdasData(client, mirnv5_corr, shotnr1);
[mirnv_corr(6,:),mirnv6_corr_t]=LoadSdasData(client, mirnv6_corr, shotnr1);
[mirnv_corr(7,:),mirnv7_corr_t]=LoadSdasData(client, mirnv7_corr, shotnr1);
[mirnv_corr(8,:),mirnv8_corr_t]=LoadSdasData(client, mirnv8_corr, shotnr1);
[mirnv_corr(9,:),mirnv9_corr_t]=LoadSdasData(client, mirnv9_corr, shotnr1);
[mirnv_corr(10,:),mirnv10_corr_t]=LoadSdasData(client, mirnv10_corr, shotnr1);
[mirnv_corr(11,:),mirnv11_corr_t]=LoadSdasData(client, mirnv11_corr, shotnr1);
[mirnv_corr(12,:),mirnv12_corr_t]=LoadSdasData(client, mirnv12_corr, shotnr1);


[prim,prim_t]=LoadSdasData(client, prim, shotnr1);
[vert,vert_t]=LoadSdasData(client, vert, shotnr1);
[hor,hort_]=LoadSdasData(client, hor, shotnr1);

[Ip_rog,t]=LoadSdasData(client, Ip_rog, shotnr1);
[chopper,choppert]=LoadSdasData(client, chopper, shotnr1);

data.shot=shotnr1;
data.chopper=chopper;
data.time=t;
data.Ip=Ip_rog;
data.mirnv=mirnv;
data.mirnv_corr=mirnv_corr;
data.mirnv_raw=mirnv_raw;
data.prim=prim;
data.vert=vert;
data.hor=hor;
data.info='informatico, cabos novos ligados';
file= strcat('shot_',num2str(shotnr1),'.mat');
save(file, 'data');