code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e "\e[36m$1\e[0m"
}

status_check() {
  if [ $1 = 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    echo "Read the log file ${log_file} for more information about error"
    Exit 1
  fi
}


print_head"Installing Redis RPM"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>{log_file}
status_check $?

print_head"Enabling Redis 6.2"
dnf module enable redis:remi-6.2 -y &>>{log_file}
status_check $?

print_head"Installing Redis 6.2"
yum install redis -y &>>{log_file}
status_check $?

print_head"Enable Redis"
systemctl enable redis &>>{log_file}
status_check $?

print_head"Restart Redis"
systemctl restart redis &>>{log_file}
status_check $?


