Ansible EC2 Web App Deployment

&nbsp;

&nbsp;

This project uses Ansible to configure an AWS EC2 instance and deploy a static web app(index.html) using NGINX.

&nbsp;

&nbsp;

Project Structure:

&nbsp;

ansible-learning

|-main.tf

|-variable.tf

|-output.tf

|files

&nbsp;|-index.html

|-inventory

|-site.yml

|-README.md

&nbsp;

What it Does:

&nbsp;

\- Installs NGINX on an EC2 instance.

\- Copies a custom 'index.html' to '/var/www/html/'.

\- Starts and enables the NGINX service.

\- Verifies that the app is accessible via the public IP.

&nbsp;

Prerequisites:

&nbsp;

Ansible installed on your WSL2 machine.

EC2 instance (Ubuntu) running with:



-Port 22 (SSH) and 80 (HTTP) open in the security group.

&nbsp;    -Key pair (".pem" file) to access the instance.

&nbsp;

Author: Solomon Nitesh Devaneyan

&nbsp;

