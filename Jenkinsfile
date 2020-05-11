pipeline {
    agent {
        docker { 
            image "python" 
            args "--network=skynet"
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Baixando as depedências do projeto'
                sh 'pip install -r requirements.txt'
            } 
        }
        stage('Tests') {
            steps {
                echo 'Executando testes de regressão'
                sh 'robot -d ./logs tests/'
            }
            post {
                always {
                    robot 'logs'
                }
            }
        }
        stage('UAT') {
            steps {
                echo 'Aprovação dos testes de aceitação' 
            } 
        }
        stage('Production') {
            steps {
                echo 'API Ok em produção!'
            } 
        }
    }
}