#cloud-config
users:
  - name: ${username_def}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ${ssh_key_def}



yum_repos:
  # The name of the repository
  Kubernetes:
    # Any repository configuration options
    # See: man yum.conf
    #
    # This one is required!
    baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    enabled: true
    failovermethod: priority
    gpgcheck: true
    gpgkey: https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    name: Kubernetes

package_update: true
packages:
  - epel-release
  - git
  - mc
  - bash-completion
  - vim
  - kubectl


runcmd:
  # Prepare infrastructure
  - sudo -u ${username_def} git clone ${infra_repo_url} /home/${username_def}/cluster_infra
  - sudo -u ${username_def} echo ${YC_cloud_id} > /tmp/YC_cloud_id
  - sudo -u ${username_def} echo ${YC_folder_id} > /tmp/YC_folder_id
  - sudo -u ${username_def} echo ${k8s-id} > /tmp/k8s-id
  - sudo -i -u ${username_def} /home/${username_def}/cluster_infra/src/deploy_cluster_infra.sh > /tmp/deploy_cluster_infra.log 2>&1
