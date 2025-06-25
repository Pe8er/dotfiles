function log
  set -l LOG_FILE "/tmp/log.fish"
  if not test -f "$LOG_FILE"
    touch "$LOG_FILE"
  end

  set -l timestamp (date "+%Y-%m-%d %H:%M:%S")
  echo "[$timestamp] (log.fish) > $argv" >> "$LOG_FILE"
end