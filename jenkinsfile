stage('Deploy with Ansible') {
  steps {
    sh '''
      ansible-playbook -i inventory.ini deploy-docker.yml
    '''
  }
}
