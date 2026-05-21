#!/bin/bash
# ---Variables---
bk_pool="backup_pool"
control1="k8s-control-01" worker1="k8s-worker-01" worker2="k8s-worker-02"
export /etc/environment
log="/var/log/k8s/bk-uploader/$(date +%Y-%m-%d).log"
#--
qm destroy $BK_CONTROL1
qm clone 101 $BK_CONTROL1 --name "$control1-$(date +%d-%m)" --full 1 --pool "$bk_pool"
qm template $BK_CONTROL1
echo "-($date +"%H:%M:%S"): Se ha recreado la plantilla de $control1" >> $log
#--
qm destroy $BK_WORKER1
qm clone 102 $BK_WORKER1 --name "$worker1-$(date +%d-%m)" --full 1 --pool "$bk_pool"
qm template $BK_WORKER1
echo "-($date +"%H:%M:%S"): Se ha recreado la plantilla de $worker1" >> $log
#--
qm destroy $BK_WORKER2
qm clone 103 $BK_WORKER2 --name "$worker2-$(date +%d-%m)" --full 1 --pool "$bk_pool"
qm template $BK_WORKER2
echo "-($date +"%H:%M:%S"): Se ha recreado la plantilla de $worker2" >> $log
