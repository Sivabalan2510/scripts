#! /usr/bin/ruby

# Automating the redis such as install, start, stop and backup

#only root user is allowed to execute

if Process::euid == 0
  print "Allowed to execute. \n"
else
  print "Access denied. Execute as sudoer. \n"
end

# Installing the redis in the VM

def install_redis()
  print "Welcome to the redis installion.. \n"
  print "Do you want to install redis? Enter {install} else {no} \n"
  installion_start = $stdin.gets.chomp
  case installion_start
  when "install"
    output1 = `sudo apt update`
    output2 = `sudo apt install redis-server`
    print ("The Redis server has been installed successfully. \n")
  when "no"
    print "Installion has been cancelled! \n"
  else
    print "Invalid input. \n"
  end
end

# Starting the redis in the VM

def start_redis()
  print "To start the redis server enter {start}: \n"
  start = $stdin.gets.chomp
  if start == "start" 
    ouput = `sudo systemctl start redis`
    print ("Your redis servers has started. \n")
  else 
    print "Invalid input! \n"
  end
end

# Stop the redis in the VM

def stop_redis()
  print "To stop the redis server enter {stop}: \n"
  stop = $stdin.gets.chomp.to_s
  if stop == "stop"
    ouput = `sudo systemctl stop redis`
    print ("Your redis servers has stoped. \n")
  else 
    print "Invalid input! \n"
  end
end

# Backuping redis data

def backup_data()
  print "To backup the database. Enter {backup} \n"
  database_backup = $stdin.gets.chomp
  if database_backup == "backup"
    checking_status = `sudo systemctl is-active redis`.strip
    puts "Redis status: #{checking_status}" # Debugging statement
    if checking_status == "active"
      output = `redis-cli BGSAVE`
      puts "Your database has been backedup successfully! \n"
    else 
      puts "The Redis server is inactive. Please start the redis server to backup the data! \n"
    end
  else
    puts "Please enter the valid input \n"
  end
end

# Calling function based on CLI argument
case ARGV[0]
when "install"
  install_redis()
when "start"
  start_redis()
when "stop"
  stop_redis()
when "backup"
  backup_data()
else
  print "Help: ./redis-automation.rb {install!start!stop!backup!} \n"
end 
