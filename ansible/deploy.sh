#!/bin/bash 

# Orden de ejecución de los playbooks de Ansible

# Instalación y configuración de Kubernetes

ansible-playbook -i hosts prev_config.yml
ansible-playbook -i hosts add_nfs.yml
ansible-playbook -i hosts common_config.yml
ansible-playbook -i hosts install_docker.yml
ansible-playbook -i hosts install_kubernetes.yml
ansible-playbook -i hosts k8s_master_config.yml
ansible-playbook -i hosts install_cni.yml
ansible-playbook -i hosts kubectl_config.yml
ansible-playbook -i hosts sdn_azure.yml
ansible-playbook -i hosts k8s_workers_config.yml
ansible-playbook -i hosts ingress_controller.yml

# Despliegue de la aplicación: Jenkins

ansible-playbook -i hosts deploy_jenkins.yml