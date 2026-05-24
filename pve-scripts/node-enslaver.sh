#!/bin/bash
# Scirpt de auto redeploy de nodos k8s | by mosto
# ---Variables---
k8s_pool="kubernetes_pool"
control1="k8s-control-01" ct1_status=""
worker1="k8s-worker-01" w1_status=""
worker2="k8s-worker-02" w2_status=""
export /etc/environment
log="/var/log/k8s/vm-enslaver/$(date +%Y-%m-%d).log"
#--
ct1_status=$(qm status 101 | awk '{print $2}')
w1_status=$(qm status 102 | awk '{print $2}')
w2_status=$(qm status 103 | awk '{print $2}')
#--
if [ $ct1_status == "running" ] && [ $w1_status == "running" ] && [ $w2_status == "running" ]; then
    exit
else
    #--
    if [ -z $ct1_status ]; then
        qm clone "$BK_CONTROL1" 101 --name "$control1" --full 1 --pool "$k8s_pool"
        qm start 101
        echo "------" >> $log
        echo "-($date +"%H:%M:%S"): Se ha recreado la maquina $control1" >> $log
    elif [ $ct1_status == "stopped" ]; then
        qm start 101
        echo "------" >> $log
        echo "-($date +"%H:%M:%S"): Se ha reiniciado la maquina $control1" >> $log
    fi
    #--
    if [ -z $w1_status ]; then
        qm clone "$BK_WORKER1" 102 --name "$worker1" --full 1 --pool "$k8s_pool"
        qm start 102
        echo "------" >> $log
        echo "-($date +"%H:%M:%S"): Se ha recreado la maquina $worker1" >> $log
    elif [ $w1_status == "stopped" ]; then
        qm start 102
        echo "------" >> $log
        echo "-($date +"%H:%M:%S"): Se ha reiniciado la maquina $worker1" >> $log
    fi
    #--
    if [ -z $w2_status ]; then
        qm clone "$BK_WORKER2" 103 --name "$worker2" --full 1 --pool "$k8s_pool"
        qm start 103
        echo "------" >> $log
        echo "-($date +"%H:%M:%S"): Se ha recreado la maquina $worker2" >> $log
    elif [ $w2_status == "stopped" ]; then
        qm start 103
        echo "------" >> $log
        echo "-($date +"%H:%M:%S"): Se ha reiniciado la maquina $worker2" >> $log
    fi
fi
#-- 