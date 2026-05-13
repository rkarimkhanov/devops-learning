#!/bin/bash
set -euo pipefail

# ================================================
# Script:  health_check.sh
# Purpose: System health monitor with thresholds
# Usage:   ./health_check.sh
# ================================================

# ---- configuration ----
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/system_$(date +%Y%m%d_%H%M%S).log"

# ---- thresholds ----
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# ---- colors ----
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# ---- setup ----
mkdir -p "$LOG_DIR" || {
    echo "ERROR: Cannot create log directory"
    exit 1
}

# ---- log function ----
log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# ---- check threshold function ----
check_threshold() {
    local value="$1"
    local threshold="$2"
    local label="$3"

    if [ "$value" -ge "$threshold" ]; then
        log "${RED}WARNING: $label is at ${value}% - threshold is ${threshold}%${RESET}"
    else
        log "${GREEN}OK: $label is at ${value}%${RESET}"
    fi
}

# ---- cpu ----
get_cpu() {
    log "=== CPU Usage ==="

    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
    cpu_used=$((100 - cpu_idle))

    check_threshold "$cpu_used" "$CPU_THRESHOLD" "CPU"
    log "CPU Used: ${cpu_used}%"
    log "CPU Idle: ${cpu_idle}%"
}

# ---- memory ----
get_memory() {
    log "=== Memory Usage ==="

    mem_total=$(free | awk 'NR==2 {print $2}')
    mem_used=$(free  | awk 'NR==2 {print $3}')
    mem_free=$(free  | awk 'NR==2 {print $4}')
    mem_percent=$(( mem_used * 100 / mem_total ))

    check_threshold "$mem_percent" "$MEM_THRESHOLD" "Memory"
    free -h | awk 'NR==2 {printf "Total: %s  |  Used: %s  |  Free: %s\n", $2, $3, $4}' | tee -a "$LOG_FILE"
}

# ---- disk ----
get_disk() {
    log "=== Disk Usage ==="

    disk_percent=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

    check_threshold "$disk_percent" "$DISK_THRESHOLD" "Disk"
    df -h / | awk 'NR==2 {printf "Total: %s  |  Used: %s  |  Free: %s\n", $2, $3, $4}' | tee -a "$LOG_FILE"
}

# ---- top processes ----
get_top_processes() {
    log "=== Top 5 Processes by Memory ==="

    ps aux --sort=-%mem | awk 'NR<=6 {printf "%-10s %-6s %-6s %s\n", $1, $3, $4, $11}' | tee -a "$LOG_FILE"
}

# ---- run ----
get_cpu
get_memory
get_disk
get_top_processes