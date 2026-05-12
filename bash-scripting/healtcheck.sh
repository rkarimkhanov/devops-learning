#!/bin/bash

# ================================================
# Script:  health_check.sh
# Purpose: System health monitor
# ================================================

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/system_$(date +%Y%m%d_%H%M%S).log"

mkdir -p "$LOG_DIR"

log() {
    echo "$1" | tee -a "$LOG_FILE"
}

get_cpu() {
    log "=== CPU Usage ==="
    
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
    cpu_used=$((100 - cpu_idle))
    
    log "CPU Used: ${cpu_used}%"
    log "CPU Idle: ${cpu_idle}%"
}

get_cpu