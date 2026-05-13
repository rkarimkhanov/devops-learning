Scripts
health_check.sh
A system monitoring script that checks the health of a Linux machine, warns when something exceeds a threshold, and saves everything to a timestamped log file.
I built this because checking CPU, memory and disk is something every sysadmin does manually when something feels off. This just automates that habit and makes it consistent.
What it checks:

CPU usage
Memory usage — total, used, free
Disk usage on root partition
Top 5 processes consuming the most memory

Thresholds — warnings trigger at:

CPU: 80%
Memory: 80%
Disk: 80%

Usage:
bashchmod +x health_check.sh
./health_check.sh
Log files are saved to ~/logs/ with a timestamp in the filename so nothing gets overwritten.

Output
When thresholds are exceeded:



When everything is healthy:



Key practices applied:

 set -euo pipefail — stops immediately on unexpected failures, no silent errors
Error handling on log directory creation — if logs can't be written, there's no point continuing

 check_threshold function — one reusable function handles all three checks instead of repeating logic
Threshold variables defined at the top — change them in one place, not scattered through the script

 tee — writes output to terminal and log file at the same time
Conventional commits — every feature built and committed separately

