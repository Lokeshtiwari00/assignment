---
- name: Disable SE
  hosts: frontend
  tasks:
   - name: Check Firewalld status in CentOs
     command: systemctl is-active firewalld
     register: firewalld_status
     changed_when: false
     failed_when: false
   - name: Stop and disable the Firewall in Centos
     systemd:
      name: firewalld
      state: stopped
      enabled: no
     when: ansible_distribution =="RedHat" and firewalld_status.stdout == "active"
   - name: Disable SE linuX in CentOS
     selinux:
      state: disabled
     when: ansible_distribution =="RedHat"
