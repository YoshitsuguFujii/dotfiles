# pc runnning time

run_segment() {
  uptime | sed -e 's/.* up *\(.*\)/\1/' -e 's/\(.*\),.* user.*/\1/' | awk -F, '{print $1 $2}' | tr -s ' '
}
