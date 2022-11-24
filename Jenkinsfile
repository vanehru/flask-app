pipeline{
    agent any
    parameters {
        string(name: 'git_url', description: 'url of github', defaultValue: 'https://github.com/vanehru/flask-app.git')
        choice(name: 'deploy', choices: ['true', 'False'], description: 'deploy')

    }

    stages{
            stage('clone'){
                when {
                    anyOf {
                        expression { env.BRANCH_NAME == 'master' }
                        expression { env.BRANCH_NAME == 'dev' }
                        }
                }
                steps{
                    checkout([
                        $class: 'GitSCM', 
                        branches: [[name: "${env.BRANCH_NAME}"]],
                        userRemoteConfigs: [[credentialsId: 'Githubcred', url: "${params.git_url}"]]
                        ])
                    }
                }
            stage('docker build'){
                when {
                    allOf {
                        anyOf {
                            expression { env.BRANCH_NAME == 'master' }
                            expression { env.BRANCH_NAME == 'dev' }
                            }
                        expression { params.deploy == "true" }
                        }
                    }
                steps{
                sh 'docker build -t test:1 .'
                }
            }
    }
}