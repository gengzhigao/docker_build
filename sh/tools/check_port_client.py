#!/usr/bin/python
# -*- coding: UTF-8 -*-
# 文件名：client.py

import socket               # 导入 socket 模块

host = "192.168.1.222"
port_lists = [ 80, 443, 18443, 28443, 8000, 1883 ]

def port_client(host, port) :
    s = socket.socket()         # 创建 socket 对象
    s.connect((host, port))
#    print s.recv(1024)
    print port, " 端口测试通过"
    s.close()

for port in port_lists :
    port_client(host, port)