Jenkins Setup and Monitoring Automation
📌 Overview

This project demonstrates end-to-end Jenkins installation, monitoring, and self-healing automation using Ansible, Shell scripting, Cron, and Linux system services on Ubuntu EC2 instances.

The solution ensures that:

Jenkins is installed automatically using Ansible

Jenkins service status is continuously monitored

Jenkins is automatically restarted if it stops

Logs and alerts are generated for observability

🧱 Architecture

Ansible Controller: Manages configuration and installation

EC2 Target Instance (Ubuntu): Hosts Jenkins

Cron Job: Runs monitoring script periodically

Shell Script: Checks Jenkins service and restarts if required

⚙️ Jenkins Installation Using Ansible
Description

Jenkins is installed on the EC2 target instance using an Ansible playbook.
The playbook performs the following actions:

Updates apt cache

Installs Java (OpenJDK)

Adds Jenkins GPG key and repository

Installs Jenkins

Enables and starts Jenkins service

Execution
ansible-playbook -i inventory.txt install_jenkins.yml

Verification
systemctl status jenkins


Expected result:

Active: active (running)

🛠 Jenkins Monitoring & Auto-Restart Script
Script Name
check_jenkins.sh

Purpose

Monitor Jenkins service status

Automatically restart Jenkins if it is stopped

Send alert notification (optional email)

Script Logic

Check Jenkins service using systemctl is-active

If Jenkins is running → log status

If Jenkins is stopped:

Restart Jenkins service

Log the event

Send alert email

Script Location
/home/ubuntu/check_jenkins.sh

🔁 Cron Job Configuration
Purpose

Run the monitoring script every 5 minutes automatically.

Root Crontab Entry (Recommended)
sudo crontab -e

*/5 * * * * /bin/bash /home/ubuntu/check_jenkins.sh >> /var/log/jenkins_monitor.log 2>&1

Why Root Cron?

Restarting system services requires root privileges

Writing logs to /var/log requires root access

Ensures non-interactive automation

🔐 Sudo Privileges Configuration
Purpose

Allow Jenkins restart without password for automation (optional approach).

Configuration
sudo visudo


Add:

ubuntu ALL=NOPASSWD: /bin/systemctl restart jenkins, /bin/systemctl status jenkins

Benefit

Enables secure, passwordless automation

Follows principle of least privilege

🔍 Workflow Summary

Jenkins installed via Ansible

Jenkins service enabled and started

Cron runs monitoring script every 5 minutes

Script checks Jenkins service status

If Jenkins stops:

Service is restarted automatically

Event is logged

Alert notification is sent

Jenkins resumes normal operation without manual intervention

✅ Verification Steps
1️⃣ Stop Jenkins manually
sudo systemctl stop jenkins

2️⃣ Wait 5 minutes
3️⃣ Verify Jenkins restarted
systemctl status jenkins


Expected:

Active: active (running)

4️⃣ Check logs
sudo tail -f /var/log/jenkins_monitor.log

📂 Logs & Alerts

Log file: /var/log/jenkins_monitor.log

Alert: Email notification (via mailutils, if configured)

🎯 Key DevOps Concepts Demonstrated

Configuration management with Ansible

Jenkins CI server installation

Linux service management

Shell scripting

Cron scheduling

Privilege escalation & sudoers

Self-healing infrastructure

Monitoring and alerting

🏁 Conclusion

This project showcases a production-ready Jenkins setup with automated monitoring and recovery, reducing downtime and manual intervention while following DevOps best practices.