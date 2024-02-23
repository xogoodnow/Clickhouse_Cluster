
resource "null_resource" "Clickhouse" {
  provisioner "local-exec" {
    command = "sleep 111  && PWD='../' ANSIBLE_HOST_KEY_CHECKING=False ANSIBLE_ROLES_PATH='../Ansible/roles/' ansible-playbook -i ../Ansible/inventory ../Ansible/playbooks/Deploy.yaml --private-key sshkey/private_key.pem"
  }
}

