# Use brew command-not-found
if brew command command-not-found-init > /dev/null; then
  eval "$(brew command-not-found-init)"
fi

# Use brew sbin to path
export PATH="/usr/local/sbin:$PATH"
