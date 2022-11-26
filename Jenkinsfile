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
            stage('docker image stages'){
                when {
                    allOf {
                        anyOf {
                            expression { env.BRANCH_NAME == 'master' }
                            expression { env.BRANCH_NAME == 'dev' }
                            }
                        expression { params.deploy == "true" }
                        }
                    }
                stages{
                    stage('docker build'){
                        steps{
                        sh """docker build -t public.ecr.aws/q5y5m4j7/flask-app/dev:${BUILD_NUMBER} ."""
                        }
                    }

                    stage('docker push'){
                        steps{
                        sh """
                        aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/q5y5m4j7
                        docker push public.ecr.aws/q5y5m4j7/flask-app/dev:$BUILD_NUMBER 
                        """
                        }
                    }

                    stage('delete images'){

                        steps{
                        sh """
                        docker rmi public.ecr.aws/q5y5m4j7/flask-app/dev:${currentBuild.previousBuild.number}
            
                        """
                        }
                    }
                } 
            }
        }
}