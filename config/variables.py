hostname = '65.2.29.173'
getmemoryUtlizationCmd = "free | grep Mem | awk '{print ($2-$7)/$2 * 100}'"
getCpuUtlizationCmd = "top -b -n 1 -d1 | grep \"%Cpu(s)\""
