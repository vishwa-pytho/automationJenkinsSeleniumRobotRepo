import paramiko
from datetime import datetime

class Ec2UsageCalculator(object):

    def __init__(self, host):
        self.host = host

    def runSsh(self, cmd):
        userName = "ec2-user"
        try:
            key = paramiko.RSAKey.from_private_key_file("C:/Users/GS-2412/Downloads/JenkinsVM.pem")
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            paramiko.util.log_to_file("filename.log")
            ssh.connect(hostname=self.host, username=userName, port=22, pkey=key)
            print("connected to host", self.host)
            stdin, stdout, stderr = ssh.exec_command(cmd, timeout=10)
            result = stdout.read()
            result1 = result.decode()
            print("query result", result1)
            error = stderr.read().decode('utf-8')
            if not error:
                ssh.close()
            return result1
        except paramiko.AuthenticationException:
            print("Authentication failed, please verify your credentials: %s")

    def get_memory_utlization(self, cmd):
        memory_utlization = self.runSsh(cmd).strip()
        return memory_utlization

    def get_cpu_utlization(self, cmd):
        cpu_utlization = int(100- float(self.runSsh(cmd).split("ni,")[1].split("id")[0]))
        return cpu_utlization

    def disk_space_calculator(self):
        cmd = "df -h"
        disk_space = self.runSsh(cmd)
        return disk_space

    def write_output_to_file_with_timestamp(self, data, outputFor):
        with open('CliOutput.txt', mode="a") as outputFile:
            time= datetime.now()
            outputFile.write("\n"+ str(time) + " - " + outputFor+ " = " + str(data))


