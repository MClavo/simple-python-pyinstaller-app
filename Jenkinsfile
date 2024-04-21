pipeline {
    agent any 
    stages {
        stage('Setup') { 
            steps {
                script {
                    env.PATH = "/path/to/python:${env.PATH}"
                }
            }
        }
        stage('Build') { 
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py' 
                stash(name: 'compiled-results', includes: 'sources/*.py*') 
            }
        }
    }
}