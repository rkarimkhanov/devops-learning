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

get_memory() {
    log "=== Memory Usage ==="

    mem_total=$(free | awk 'NR==2 {print $2}')
    mem_used=$(free  | awk 'NR==2 {print $3}')
    mem_free=$(free  | awk 'NR==2 {print $4}')
    mem_percent=$(( mem_used * 100 / mem_total ))

    log "Used: ${mem_percent}%"
    free -h | awk 'NR==2 {printf "Total: %s  |  Used: %s  |  Free: %s\n", $2, $3, $4}' | tee -a "$LOG_FILE"
}

get_disk() {
    log "=== Disk Usage ==="

    disk_percent=$(df / | awk 'NR==2 {print $5}')

    log "Disk Used: ${disk_percent}"
    df -h / | awk 'NR==2 {printf "Total: %s  |  Used: %s  |  Free: %s\n", $2, $3, $4}' | tee -a "$LOG_FILE"
}

get_top_processes() {
    log "=== Top 5 Processes by Memory ==="

    ps aux --sort=-%mem | awk 'NR<=6 {printf "%-10s %-6s %-6s %s\n", $1, $3, $4, $11}' | tee -a "$LOG_FILE"
}



get_cpu

get_memory

get_top_processes

get_disk

