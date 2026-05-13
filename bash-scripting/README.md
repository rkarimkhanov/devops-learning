# Bash Scripting

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

---

## Scripts

### health_check.sh

A system monitoring script that checks the health of a Linux machine, warns when something exceeds a threshold, and saves everything to a timestamped log file.

I built this because checking CPU, memory and disk is something every sysadmin does manually when something feels off. This just automates that habit and makes it consistent.

**What it checks:**

- CPU usage
- Memory usage — total, used, free
- Disk usage on root partition
- Top 5 processes consuming the most memory

**Thresholds — warnings trigger at:**

| Metric | Threshold |
|--------|-----------|
| CPU | 80% |
| Memory | 80% |
| Disk | 80% |

**Usage:**

```bash
chmod +x health_check.sh
./health_check.sh
```

Log files are saved to `~/logs/` with a timestamp in the filename so nothing gets overwritten.

---

## Output

**When thresholds are exceeded:**

![warning](screenshot_warning.png)

**When everything is healthy:**

![ok](screenshot_ok.png)

---

## Key Practices Applied

| Practice | Why |
|----------|-----|
| `set -euo pipefail` | stops immediately on unexpected failures, no silent errors |
| Error handling on `mkdir` | if logs can't be written, no point continuing |
| `check_threshold` function | one reusable function handles all three checks |
| Threshold variables at the top | change in one place, not scattered through the script |
| `tee` | writes to terminal and log file at the same time |
| Conventional commits | every feature built and committed separately |

---
