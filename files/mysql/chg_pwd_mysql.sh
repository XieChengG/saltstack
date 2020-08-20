#!/bin/bash

PATH=$HOME/bin:$PATH
export PATH

LOG_FILE="/var/log/mysqld.log"
INIT_PASSWD=`cat $LOG_FILE | grep password | awk '{print $11}' | head -n 1`

chgPwd() {
  mysql -uroot -p"$INIT_PASSWD" \
        --connect-expired-password \
        -e "set global validate_password_policy=0;set global validate_password_length=4;"

  mysqladmin -uroot -p"$INIT_PASSWD" password '123456'
}

main() {
  chgPwd
}
main
