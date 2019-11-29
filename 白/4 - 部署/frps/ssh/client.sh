#!/bin/bash

/usr/sbin/sshd -D &
/frpc -c /frpc.ini