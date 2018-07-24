#Andre Torres - 23/07/2018
#computes horizontal and vertical displacement from the mirnovs

from sdas.core.client.SDASClient import SDASClient
from sdas.core.SDAStime import Date, Time, TimeStamp
import numpy as np
import matplotlib.pyplot as plt
from StartSdas import StartSdas

#CHANGE SHOT NUMBER HERE
shotnr=43740;
client = StartSdas()

mirnv=['MARTE_NODE_IVO3.DataCollection.Channel_129',
'MARTE_NODE_IVO3.DataCollection.Channel_130',
'MARTE_NODE_IVO3.DataCollection.Channel_131',
'MARTE_NODE_IVO3.DataCollection.Channel_132',
'MARTE_NODE_IVO3.DataCollection.Channel_133',
'MARTE_NODE_IVO3.DataCollection.Channel_134',
'MARTE_NODE_IVO3.DataCollection.Channel_135',
'MARTE_NODE_IVO3.DataCollection.Channel_136',
'MARTE_NODE_IVO3.DataCollection.Channel_137',
'MARTE_NODE_IVO3.DataCollection.Channel_138',
'MARTE_NODE_IVO3.DataCollection.Channel_139',
'MARTE_NODE_IVO3.DataCollection.Channel_140']

mirnv_raw=['MARTE_NODE_IVO3.DataCollection.Channel_145',
'MARTE_NODE_IVO3.DataCollection.Channel_146',
'MARTE_NODE_IVO3.DataCollection.Channel_147',
'MARTE_NODE_IVO3.DataCollection.Channel_148',
'MARTE_NODE_IVO3.DataCollection.Channel_149',
'MARTE_NODE_IVO3.DataCollection.Channel_150',
'MARTE_NODE_IVO3.DataCollection.Channel_151',
'MARTE_NODE_IVO3.DataCollection.Channel_152',
'MARTE_NODE_IVO3.DataCollection.Channel_153',
'MARTE_NODE_IVO3.DataCollection.Channel_154',
'MARTE_NODE_IVO3.DataCollection.Channel_155',
'MARTE_NODE_IVO3.DataCollection.Channel_156']

mirnv_corr=['MARTE_NODE_IVO3.DataCollection.Channel_166',
'MARTE_NODE_IVO3.DataCollection.Channel_167',
'MARTE_NODE_IVO3.DataCollection.Channel_168',
'MARTE_NODE_IVO3.DataCollection.Channel_169',
'MARTE_NODE_IVO3.DataCollection.Channel_170',
'MARTE_NODE_IVO3.DataCollection.Channel_171',
'MARTE_NODE_IVO3.DataCollection.Channel_172',
'MARTE_NODE_IVO3.DataCollection.Channel_173',
'MARTE_NODE_IVO3.DataCollection.Channel_174',
'MARTE_NODE_IVO3.DataCollection.Channel_175',
'MARTE_NODE_IVO3.DataCollection.Channel_176',
'MARTE_NODE_IVO3.DataCollection.Channel_177']

prim='MARTE_NODE_IVO3.DataCollection.Channel_093';
hor='MARTE_NODE_IVO3.DataCollection.Channel_091';
vert='MARTE_NODE_IVO3.DataCollection.Channel_092';

Ip_rog='MARTE_NODE_IVO3.DataCollection.Channel_088';
chopper='MARTE_NODE_IVO3.DataCollection.Channel_141';

#SAVES MIRNOV DATA IN A MATRIX
coilNr=0
data=[]
for coil in mirnv_corr:
    coilNr+=1
    structArray=client.getData(coil,'0x0000', shotnr)
    struct=structArray[0]
    data.append(struct.getData())

#TIME
tstart = struct.getTStart()
tend = struct.getTEnd()
#Calculate the time between samples
tbs = (tend.getTimeInMicros() - tstart.getTimeInMicros())/(len(data[coilNr-1])*1.0)
#Get the events  associated with this data
events = struct.get('events')
tevent = TimeStamp(tstamp=events[0].get('tstamp'))
#The delay of the start time relative to the event time
delay = tstart.getTimeInMicros() - tevent.getTimeInMicros()
#Finally create the time array
times = np.linspace(delay,delay+tbs*(len(data[coilNr-1])-1),len(data[coilNr-1]))
#plt.plot(times, data[coilNr-1]);

#PLOTS ALL DATA FROM MIRNOVS
coilNr=0
for coil in data:
    coilNr+=1
    ax = plt.subplot(3, 4, coilNr)
    plt.plot(times, coil)
plt.show()
