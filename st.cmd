#!/epics/modules/omega_i_series/bin/linux-x86_64/omegaCNi32

## You may have to change omegaCNi32 to something else
## everywhere it appears in this file

< /epics/modules/omega_i_series/iocBoot/ioclocalhost/envPaths

epicsEnvSet("ENGINEER", "K. Gofron x5283")
epicsEnvSet("LOCATION", "XF:11IDA{RG:A2}")

epicsEnvSet("IOC_TOP", "$(PWD)")
epicsEnvSet("AS", "$(PWD)/as")

< /epics/common/xf11idb-ioc2-netsetup.cmd

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/omegaCNi32.dbd",0,0)
omegaCNi32_registerRecordDeviceDriver(pdbbase) 

## Streamdevice Protocol Path

epicsEnvSet ("STREAM_PROTOCOL_PATH", "protocols")
epicsEnvSet ("Sys", "XF:11IDA-CT")

drvAsynIPPortConfigure("tsrv1-p16","xf11ida-tsrv1.nsls2.bnl.local:4016")
drvAsynIPPortConfigure("tsrv2-p12","xf11idb-tsrv1.nsls2.bnl.local:4012")
drvAsynIPPortConfigure("tsrv2-p13","xf11idb-tsrv1.nsls2.bnl.local:4013")
drvAsynIPPortConfigure("tsrv2-p14","xf11idb-tsrv1.nsls2.bnl.local:4014")
drvAsynIPPortConfigure("tsrv2-p15","xf11idb-tsrv1.nsls2.bnl.local:4015")
drvAsynIPPortConfigure("tsrv1-p14","xf11ida-tsrv1.nsls2.bnl.local:4014")
drvAsynIPPortConfigure("tsrv3-p16","xf11ida-tsrv2.nsls2.bnl.local:4016")
#asynSetTraceMask("tsrv1-p16",0,0x09)
#asynSetTraceIOMask("tsrv1-p16",0,0x02)

## Load record instances
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:A2},Chan=01,N_T=,N_GAIN=,PORT=tsrv1-p16")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:B4},Chan=01,N_T=,N_GAIN=,PORT=tsrv2-p12")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:B3},Chan=01,N_T=,N_GAIN=,PORT=tsrv2-p13")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:B2},Chan=01,N_T=,N_GAIN=,PORT=tsrv2-p14")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:B1},Chan=01,N_T=,N_GAIN=,PORT=tsrv2-p15")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:A3},Chan=01,N_T=,N_GAIN=,PORT=tsrv1-p14")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:B5},Chan=01,N_T=,N_GAIN=,PORT=tsrv3-p16")
# N_T and N_GAIN macros used if there are multiple temperature controllers in a rack. Leading ':' required on N_T, no leading ':' required on N_GAIN.
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=${Sys},Dev={RG:A2},Chan=01,N_T=:1,N_GAIN=1,PORT=tsrv1-p16")

< global_config.cmd
#iocInit()

dbl > ${IOC_TOP}/records.dbl
#system "cp ${TOP}/records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
# < /epics/common/xf11id1-ioc1-netsetup.cmd
