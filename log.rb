
def debug(message)
  log(message, "DEBUG") if $debug == true
end

def log(message, type="INFOS")
  puts "[#{type}] #{message}"
end
