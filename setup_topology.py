#!/usr/bin/python

import csv
import paramiko

lines = []

with open('demo.csv', 'r') as file:
    reader = csv.reader(file)
    for row in reader:
        lines.append(row)

for row in lines:
    if row[3] == 'TEL354_ovs':
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname=row[2], username='ubuntu',password='ubuntu')
        print "Configurando Host/Switch, IP: "+ row[2]
        stdin, stdout, stderr = ssh.exec_command("git clone https://github.com/gespinozat/tel354.git && cd tel354 && ./setup_node.sh")
        #stdin, stdout, stderr = ssh.exec_command("cd tel354 && ./setup_node.sh")
        ssh.close()
        
    else:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname=row[2], username='ubuntu',password='ubuntu')
        print "Configurando Controlador, IP: "+ row[2]        
        stdin, stdout, stderr = ssh.exec_command("git clone https://github.com/gespinozat/tel354.git && cd tel354 && ./setup_controller.sh")
        #stdin, stdout, stderr = ssh.exec_command("cd tel354 && ./setup_controller.sh")
        #stdin, stdout, stderr = ssh.exec_command("cd tel354 && ./run_controller.sh")
        ssh.close()
