pipeline {
  agent any
  stages {
    stage('Provisioning') {
      steps {
        sh '''#!/bin/bash

./deploy.sh
'''
      }
    }

    stage('Testing/Validating') {
      steps {
        echo 'Test'
      }
    }

    stage('Purge') {
      steps {
        echo 'Purge content'
      }
    }

    stage('Notify') {
      steps {
        echo 'Notify'
      }
    }

  }
}