#!/usr/bin/python
# -*- coding: UTF-8 -*-
# 文件名：server.py

import socket,time               # 导入 socket 模块
import thread

EMM=1
MAS=1
IM=1
PCIM=1

def port_server( port ):
    s = socket.socket()         # 创建 socket 对象
    s.bind(("0.0.0.0", port))        # 绑定端口
    s.listen(5)
    while True:
        c, addr = s.accept()     # 建立客户端连接。
        print '连接地址：', addr
        c.send('端口测试通过！')
        c.close()                # 关闭连接

try:
    # 创建多个线程
    thread.start_new_thread( port_server, (80,) )
    thread.start_new_thread( port_server, (443,) )
    if EMM == 1 :
        thread.start_new_thread( port_server, (18443,) )
        thread.start_new_thread( port_server, (28443,) )
    if MAS == 1 :
        thread.start_new_thread( port_server, (8000,) )
        thread.start_new_thread( port_server, (1883,) )
    if IM == 1 :
        thread.start_new_thread( port_server, (5223,) )
    if PCIM == 1 :
        thread.start_new_thread( port_server, (5290,) )
        thread.start_new_thread( port_server, (5291,) )
except:
    print "Error: unable to start thread"

while 1:
    pass